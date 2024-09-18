contract C {
	address coin;
	uint prevrandao;
	uint gas;
	uint number;
	uint timestamp;
	function f() public {
		coin = block.coinbase;
		prevrandao = block.prevrandao;
		gas = block.gaslimit;
		number = block.number;
		timestamp = block.timestamp;

		g();
	}
	function g() internal view {
		assert(uint160(coin) >= 0); // should hold
		assert(prevrandao > 2**64); // should hold
		assert(gas >= 0); // should hold
		assert(number >= 0); // should hold
		assert(timestamp >= 0); // should hold

		assert(coin == block.coinbase); // should fail with BMC
		assert(prevrandao == block.prevrandao); // should fail with BMC
		assert(gas == block.gaslimit); // should fail with BMC
		assert(number == block.number); // should fail with BMC
		assert(timestamp == block.timestamp); // should fail with BMC
	}
}
// ====
// SMTEngine: bmc
// ----
// Warning 4661: (409-435): BMC: Assertion violation happens here.
// Warning 4661: (569-599): BMC: Assertion violation happens here.
// Warning 4661: (627-658): BMC: Assertion violation happens here.
// Warning 4661: (686-724): BMC: Assertion violation happens here.
// Warning 4661: (752-781): BMC: Assertion violation happens here.
// Warning 4661: (809-839): BMC: Assertion violation happens here.
// Warning 4661: (867-903): BMC: Assertion violation happens here.
// Info 6002: BMC: 12 verification condition(s) proved safe! Enable the model checker option "show proved safe" to see all of them.
