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

#include <libzvmasm/ZVMAssemblyStack.h>

#include <libhyputil/JSON.h>
#include <liblangutil/Exceptions.h>
#include <libhyperion/codegen/CompilerContext.h>

#include <range/v3/view/enumerate.hpp>
#include <range/v3/view/transform.hpp>

#include <tuple>

using namespace hyperion::util;
using namespace hyperion::langutil;
using namespace hyperion::frontend;

namespace hyperion::zvmasm
{

void ZVMAssemblyStack::parseAndAnalyze(std::string const& _sourceName, std::string const& _source)
{
	solAssert(!m_evmAssembly);
	m_name = _sourceName;
	Json::Value assemblyJson;
	solRequire(jsonParseStrict(_source, assemblyJson), AssemblyImportException, "Could not parse JSON file.");
	std::tie(m_evmAssembly, m_sourceList) = zvmasm::Assembly::fromJSON(assemblyJson);
	solRequire(m_evmAssembly != nullptr, AssemblyImportException, "Could not create evm assembly object.");
}

void ZVMAssemblyStack::assemble()
{
	solAssert(m_evmAssembly);
	solAssert(m_evmAssembly->isCreation());
	solAssert(!m_evmRuntimeAssembly);

	m_object = m_evmAssembly->assemble();
	m_sourceMapping = AssemblyItem::computeSourceMapping(m_evmAssembly->items(), sourceIndices());
	if (m_evmAssembly->numSubs() > 0)
	{
		m_evmRuntimeAssembly = std::make_shared<zvmasm::Assembly>(m_evmAssembly->sub(0));
		solAssert(m_evmRuntimeAssembly && !m_evmRuntimeAssembly->isCreation());
		m_runtimeSourceMapping = AssemblyItem::computeSourceMapping(m_evmRuntimeAssembly->items(), sourceIndices());
		m_runtimeObject = m_evmRuntimeAssembly->assemble();
	}
}

LinkerObject const& ZVMAssemblyStack::object(std::string const& _contractName) const
{
	solAssert(_contractName == m_name);
	return m_object;
}

LinkerObject const& ZVMAssemblyStack::runtimeObject(std::string const& _contractName) const
{
	solAssert(_contractName == m_name);
	return m_runtimeObject;
}

std::map<std::string, unsigned> ZVMAssemblyStack::sourceIndices() const
{
	solAssert(m_evmAssembly);
	return m_sourceList
		| ranges::views::enumerate
		| ranges::views::transform([](auto const& _source) { return std::make_pair(_source.second, _source.first); })
		| ranges::to<std::map<std::string, unsigned>>;
}

std::string const* ZVMAssemblyStack::sourceMapping(std::string const& _contractName) const
{
	solAssert(_contractName == m_name);
	return &m_sourceMapping;
}

std::string const* ZVMAssemblyStack::runtimeSourceMapping(std::string const& _contractName) const
{
	solAssert(_contractName == m_name);
	return &m_runtimeSourceMapping;
}

Json::Value ZVMAssemblyStack::assemblyJSON(std::string const& _contractName) const
{
	solAssert(_contractName == m_name);
	solAssert(m_evmAssembly);
	return m_evmAssembly->assemblyJSON(sourceIndices());
}

std::string ZVMAssemblyStack::assemblyString(std::string const& _contractName, StringMap const& _sourceCodes) const
{
	solAssert(_contractName == m_name);
	solAssert(m_evmAssembly);
	return m_evmAssembly->assemblyString(m_debugInfoSelection, _sourceCodes);
}

std::string const ZVMAssemblyStack::filesystemFriendlyName(std::string const& _contractName) const
{
	solAssert(_contractName == m_name);
	return m_name;
}

std::vector<std::string> ZVMAssemblyStack::sourceNames() const
{
	return m_sourceList;
}

} // namespace hyperion::zvmasm