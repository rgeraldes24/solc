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
 * EVM versioning.
 */

#pragma once

#include <cstdint>
#include <optional>
#include <string>

#include <boost/operators.hpp>


namespace solidity::evmasm
{
/// Virtual machine bytecode instruction. Forward declared from libevmasm/Instruction.h
enum class Instruction: uint8_t;
}

namespace solidity::langutil
{

/**
 * A version specifier of the EVM we want to compile to.
 * Defaults to the latest version deployed on Ethereum Mainnet at the time of compiler release.
 */
class EVMVersion:
	boost::less_than_comparable<EVMVersion>,
	boost::equality_comparable<EVMVersion>
{
public:
	EVMVersion() = default;

	static EVMVersion shanghai() { return {Version::Shanghai}; }

	static std::optional<EVMVersion> fromString(std::string const& _version)
	{
		for (auto const& v: {shanghai()})
			if (_version == v.name())
				return v;
		return std::nullopt;
	}

	bool operator==(EVMVersion const& _other) const { return m_version == _other.m_version; }
	bool operator<(EVMVersion const& _other) const { return m_version < _other.m_version; }

	std::string name() const
	{
		switch (m_version)
		{
		case Version::Shanghai: return "shanghai";
		}
		return "INVALID";
	}

private:
	enum class Version { Shanghai };

	EVMVersion(Version _version): m_version(_version) {}

	Version m_version = Version::Shanghai;
};

}
