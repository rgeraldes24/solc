/*
	This file is part of solidity.

	solidity is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	solidity is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with solidity.  If not, see <http://www.gnu.org/licenses/>.
*/
// SPDX-License-Identifier: GPL-3.0

#include <test/tools/ossfuzz/protoToSol.h>
#include <test/tools/ossfuzz/SolidityZvmoneInterface.h>
#include <test/tools/ossfuzz/solProto.pb.h>

#include <test/ZVMHost.h>

#include <zvmone/zvmone.h>
#include <src/libfuzzer/libfuzzer_macro.h>

#include <fstream>

static zvmc::VM zvmone = zvmc::VM{zvmc_create_zvmone()};

using namespace hyperion::test::fuzzer;
using namespace hyperion::test::solprotofuzzer;
using namespace hyperion;
using namespace hyperion::frontend;
using namespace hyperion::test;
using namespace hyperion::util;
using namespace std;

DEFINE_PROTO_FUZZER(Program const& _input)
{
	ProtoConverter converter;
	string sol_source = converter.protoToSolidity(_input);

	if (char const* dump_path = getenv("PROTO_FUZZER_DUMP_PATH"))
	{
		// With libFuzzer binary run this to generate a YUL source file x.yul:
		// PROTO_FUZZER_DUMP_PATH=x.yul ./a.out proto-input
		ofstream of(dump_path);
		of.write(sol_source.data(), static_cast<streamsize>(sol_source.size()));
	}

	if (char const* dump_path = getenv("SOL_DEBUG_FILE"))
	{
		sol_source.clear();
		// With libFuzzer binary run this to generate a YUL source file x.yul:
		// PROTO_FUZZER_LOAD_PATH=x.yul ./a.out proto-input
		ifstream ifstr(dump_path);
		sol_source = {
			std::istreambuf_iterator<char>(ifstr),
			std::istreambuf_iterator<char>()
		};
		std::cout << sol_source << std::endl;
	}

	// We target the default ZVM which is the latest
	langutil::ZVMVersion version;
	ZVMHost hostContext(version, zvmone);
	string contractName = "C";
	string libraryName = converter.libraryTest() ? converter.libraryName() : "";
	string methodName = "test()";
	StringMap source({{"test.hyp", sol_source}});
	CompilerInput cInput(version, source, contractName, OptimiserSettings::minimal(), {});
	ZvmoneUtility zvmoneUtil(
		hostContext,
		cInput,
		contractName,
		libraryName,
		methodName
	);
	auto minimalResult = zvmoneUtil.compileDeployAndExecute();
	solAssert(minimalResult.status_code != ZVMC_REVERT, "Sol proto fuzzer: Zvmone reverted.");
	if (minimalResult.status_code == ZVMC_SUCCESS)
		solAssert(
			ZvmoneUtility::zeroWord(minimalResult.output_data, minimalResult.output_size),
			"Proto hypc fuzzer: Output incorrect"
		);
}
