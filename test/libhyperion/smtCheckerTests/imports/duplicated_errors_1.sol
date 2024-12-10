==== Source: a.hyp ====
contract A {
	uint x;
}
==== Source: b.hyp ====
import "a.hyp";
contract B is A {
	function g() public view { assert(x > x); }
}
==== Source: c.hyp ====
import "b.hyp";
contract C is B {
	function h(uint x) public pure { assert(x < x); }
}
// ====
// SMTEngine: all
// SMTSolvers: smtlib2
// ----
// Warning 6328: (b.hyp:62-75): CHC: Assertion violation might happen here.
// Warning 3996: CHC analysis was not possible. No Horn solver was available. None of the installed solvers was enabled.
// Warning 7812: (b.hyp:62-75): BMC: Assertion violation might happen here.
// Warning 8084: BMC analysis was not possible. No SMT solver (Z3 or CVC4) was available. None of the installed solvers was enabled.
// Warning 6328: (c.hyp:68-81): CHC: Assertion violation might happen here.
// Warning 3996: CHC analysis was not possible. No Horn solver was available. None of the installed solvers was enabled.
// Warning 7812: (c.hyp:68-81): BMC: Assertion violation might happen here.
// Warning 8084: BMC analysis was not possible. No SMT solver (Z3 or CVC4) was available. None of the installed solvers was enabled.
