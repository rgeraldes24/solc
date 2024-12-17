/*
	This file is part of hyperion.

	hyperion is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	hyperion is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with hyperion.  If not, see <http://www.gnu.org/licenses/>.
*/
// SPDX-License-Identifier: GPL-3.0

#pragma once

#include <test/TestCase.h>

namespace hyperion::yul
{
struct AsmAnalysisInfo;
struct Block;
}

namespace hyperion::yul::test
{

class YulInterpreterTest: public hyperion::frontend::test::ZVMVersionRestrictedTestCase
{
public:
	static std::unique_ptr<TestCase> create(Config const& _config)
	{
		return std::make_unique<YulInterpreterTest>(_config.filename);
	}

	explicit YulInterpreterTest(std::string const& _filename);

	TestResult run(std::ostream& _stream, std::string const& _linePrefix = "", bool const _formatted = false) override;

private:
	bool parse(std::ostream& _stream, std::string const& _linePrefix, bool const _formatted);
	std::string interpret();

	std::shared_ptr<Block> m_ast;
	std::shared_ptr<AsmAnalysisInfo> m_analysisInfo;
	bool m_simulateExternalCallsToSelf = false;
};

}
