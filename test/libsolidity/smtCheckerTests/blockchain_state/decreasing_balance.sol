contract C {
	uint t;
	constructor() {
		t = address(this).balance;
	}
	function f(address payable a, uint x) public {
		require(address(this).balance >= x);
		a.transfer(x);
	}
	function inv() public view {
		// Removed because current Spacer seg faults in cex generation.
		//assert(address(this).balance == t);
	}
}
// ====
// SMTEngine: all
// ----
// Info 6002: BMC: 1 verification condition(s) proved safe! Enable the model checker option "show proved safe" to see all of them.
