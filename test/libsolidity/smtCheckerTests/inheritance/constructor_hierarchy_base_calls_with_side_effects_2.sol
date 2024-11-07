contract A {
	uint public x;
	constructor(uint a) { x = a; }
}

contract B is A {
	constructor(uint b) A(b) {
	}

	function f() internal returns (uint) {
		x = x + 1;
		return x;
	}
}

abstract contract T is A {
	uint k;
	constructor(uint t) {
		k = t;
	}
}

contract C is T, B {
	constructor() B(f()) T(f()) {
		assert(x == 1);
		assert(k == 2);
		assert(x == k); // should fail
	}
}
// ====
// SMTEngine: all
// ----
// Warning 6328: (349-363): CHC: Assertion violation happens here.
// Info 1391: CHC: 3 verification condition(s) proved safe! Enable the model checker option "show proved safe" to see all of them.
