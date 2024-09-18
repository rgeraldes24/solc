contract C
{
	function f(uint prevrandao) public view {
		assert(block.prevrandao == prevrandao); // should fail
	}
}
// ====
// SMTEngine: all
// SMTIgnoreCex: yes
// ----
// Warning 6328: (58-96): CHC: Assertion violation happens here.
// Warning 6328: (115-153): CHC: Assertion violation happens here.
// Info 1391: CHC: 1 verification condition(s) proved safe! Enable the model checker option "show proved safe" to see all of them.
