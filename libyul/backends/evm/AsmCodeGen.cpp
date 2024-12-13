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
/**
 * Helper to compile Yul code using libzvmasm.
 */

#include <libyul/backends/evm/AsmCodeGen.h>

#include <libyul/backends/evm/EthAssemblyAdapter.h>
#include <libyul/backends/evm/ZVMCodeTransform.h>
#include <libyul/AST.h>
#include <libyul/AsmAnalysisInfo.h>

#include <libhyputil/StackTooDeepString.h>

using namespace hyperion;
using namespace hyperion::yul;
using namespace hyperion::util;
using namespace hyperion::langutil;

void CodeGenerator::assemble(
	Block const& _parsedData,
	AsmAnalysisInfo& _analysisInfo,
	zvmasm::Assembly& _assembly,
	langutil::ZVMVersion _evmVersion,
	ExternalIdentifierAccess::CodeGenerator _identifierAccessCodeGen,
	bool _useNamedLabelsForFunctions,
	bool _optimizeStackAllocation
)
{
	EthAssemblyAdapter assemblyAdapter(_assembly);
	BuiltinContext builtinContext;
	CodeTransform transform(
		assemblyAdapter,
		_analysisInfo,
		_parsedData,
		EVMDialect::strictAssemblyForEVM(_evmVersion),
		builtinContext,
		_optimizeStackAllocation,
		_identifierAccessCodeGen,
			_useNamedLabelsForFunctions ?
			CodeTransform::UseNamedLabels::YesAndForceUnique :
			CodeTransform::UseNamedLabels::Never
	);
	transform(_parsedData);
	if (!transform.stackErrors().empty())
		assertThrow(
			false,
			langutil::StackTooDeepError,
			util::stackTooDeepString + " When compiling inline assembly" +
			(transform.stackErrors().front().comment() ? ": " + *transform.stackErrors().front().comment() : ".")
		);
}
