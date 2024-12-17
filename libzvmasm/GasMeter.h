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
/** @file GasMeter.cpp
 * @author Christian <c@ethdev.com>
 * @date 2015
 *
 * Utilities for tracking gas costs.
 *
 * With respect to EIP-2929, we do not track warm accounts or storage slots and they are always
 * charged the worst-case, i.e., cold-access.
 */

#pragma once

#include <libzvmasm/ExpressionClasses.h>
#include <libzvmasm/AssemblyItem.h>

#include <liblangutil/ZVMVersion.h>

#include <ostream>
#include <tuple>
#include <utility>

namespace hyperion::zvmasm
{

class KnownState;

namespace GasCosts
{
	static unsigned const stackLimit = 1024;
	static unsigned const tier0Gas = 0;
	static unsigned const tier1Gas = 2;
	static unsigned const tier2Gas = 3;
	static unsigned const tier3Gas = 5;
	static unsigned const tier4Gas = 8;
	static unsigned const tier5Gas = 10;
	static unsigned const tier6Gas = 20;
	static unsigned const tier7Gas = 0;
	static unsigned const expGas = 10;
	static unsigned const expByteGas = 50;
	static unsigned const keccak256Gas = 30;
	static unsigned const keccak256WordGas = 6;
	/// Corresponds to ACCESS_LIST_ADDRESS_COST from EIP-2930
	static unsigned const accessListAddressCost = 2400;
	/// Corresponds to ACCESS_LIST_STORAGE_COST from EIP-2930
	static unsigned const accessListStorageKeyCost = 1900;
	/// Corresponds to COLD_SLOAD_COST from EIP-2929
	static unsigned const coldSloadCost = 2100;
	/// Corresponds to COLD_ACCOUNT_ACCESS_COST from EIP-2929
	static unsigned const coldAccountAccessCost = 2600;
	/// Corresponds to WARM_STORAGE_READ_COST from EIP-2929
	static unsigned const warmStorageReadCost = 100;
	static unsigned const sloadGas = coldSloadCost;
	/// Corresponds to SSTORE_SET_GAS
	static unsigned const sstoreSetGas = 20000;
	/// Corresponds to SSTORE_RESET_GAS from EIP-2929
	static unsigned const sstoreResetGas = 5000 - coldSloadCost;
	/// Corresponds to SSTORE_CLEARS_SCHEDULE from EIP-2200
	static unsigned const sstoreClearsSchedule = sstoreResetGas + accessListStorageKeyCost;
	static unsigned const totalSstoreSetGas = sstoreSetGas + coldSloadCost;
	/// Corresponds to SSTORE_RESET_GAS from EIP-2929
	static unsigned const totalSstoreResetGas = sstoreResetGas + coldSloadCost;
	static unsigned const extCodeGas = coldAccountAccessCost;
	static unsigned const balanceGas = coldAccountAccessCost;
	static unsigned const jumpdestGas = 1;
	static unsigned const logGas = 375;
	static unsigned const logDataGas = 8;
	static unsigned const logTopicGas = 375;
	static unsigned const createGas = 32000;
	static unsigned const callGas = coldAccountAccessCost;
	static unsigned const callStipend = 2300;
	static unsigned const callValueTransferGas = 9000;
	static unsigned const callNewAccountGas = 25000;
	static unsigned const memoryGas = 3;
	static unsigned const quadCoeffDiv = 512;
	static unsigned const createDataGas = 200;
	static unsigned const txGas = 21000;
	static unsigned const txCreateGas = 53000;
	static unsigned const txDataZeroGas = 4;
	static unsigned const txDataNonZeroGas = 16;
	static unsigned const copyGas = 3;
}

/**
 * Class that helps computing the maximum gas consumption for instructions.
 * Has to be initialized with a certain known state that will be automatically updated for
 * each call to estimateMax. These calls have to supply strictly subsequent AssemblyItems.
 * A new gas meter has to be constructed (with a new state) for control flow changes.
 */
class GasMeter
{
public:
	struct GasConsumption
	{
		GasConsumption(unsigned _value = 0, bool _infinite = false): value(_value), isInfinite(_infinite) {}
		GasConsumption(u256 _value, bool _infinite = false): value(std::move(_value)), isInfinite(_infinite) {}
		static GasConsumption infinite() { return GasConsumption(0, true); }

		GasConsumption& operator+=(GasConsumption const& _other);
		GasConsumption operator+(GasConsumption const& _other) const
		{
			GasConsumption result = *this;
			result += _other;
			return result;
		}
		bool operator<(GasConsumption const& _other) const
		{
			return std::make_pair(isInfinite, value) < std::make_pair(_other.isInfinite, _other.value);
		}

		u256 value;
		bool isInfinite;
	};

	/// Constructs a new gas meter given the current state.
	GasMeter(std::shared_ptr<KnownState>  _state, langutil::ZVMVersion _zvmVersion, u256  _largestMemoryAccess = 0):
		m_state(std::move(_state)), m_zvmVersion(_zvmVersion), m_largestMemoryAccess(std::move(_largestMemoryAccess)) {}

	/// @returns an upper bound on the gas consumed by the given instruction and updates
	/// the state.
	/// @param _inculdeExternalCosts if true, include costs caused by other contracts in calls.
	GasConsumption estimateMax(AssemblyItem const& _item, bool _includeExternalCosts = true);

	u256 const& largestMemoryAccess() const { return m_largestMemoryAccess; }

	/// @returns gas costs for simple instructions with constant gas costs (that do not
	/// change with ZVM versions)
	static unsigned runGas(Instruction _instruction);

	/// @returns the gas cost of the supplied data, depending whether it is in creation code, or not.
	/// In case of @a _inCreation, the data is only sent as a transaction and is not stored, whereas
	/// otherwise code will be stored and have to pay "createDataGas" cost.
	static u256 dataGas(bytes const& _data, bool _inCreation);

	/// @returns the gas cost of non-zero data of the supplied length, depending whether it is in creation code, or not.
	/// In case of @a _inCreation, the data is only sent as a transaction and is not stored, whereas
	/// otherwise code will be stored and have to pay "createDataGas" cost.
	static u256 dataGas(uint64_t _length, bool _inCreation);

private:
	/// @returns _multiplier * (_value + 31) / 32, if _value is a known constant and infinite otherwise.
	GasConsumption wordGas(u256 const& _multiplier, ExpressionClasses::Id _value);
	/// @returns the gas needed to access the given memory position.
	/// @todo this assumes that memory was never accessed before and thus over-estimates gas usage.
	GasConsumption memoryGas(ExpressionClasses::Id _position);
	/// @returns the memory gas for accessing the memory at a specific offset for a number of bytes
	/// given as values on the stack at the given relative positions.
	GasConsumption memoryGas(int _stackPosOffset, int _stackPosSize);

	std::shared_ptr<KnownState> m_state;
	langutil::ZVMVersion m_zvmVersion;
	/// Largest point where memory was accessed since the creation of this object.
	u256 m_largestMemoryAccess;
};

inline std::ostream& operator<<(std::ostream& _str, GasMeter::GasConsumption const& _consumption)
{
	if (_consumption.isInfinite)
		return _str << "[???]";
	else
		return _str << std::dec << _consumption.value;
}

}
