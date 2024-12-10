==== Source: s1.hyp ====
function f() pure returns (uint) { return 1337; }
contract C {
  function f() public pure virtual returns (uint) {
    return f();
  }
}
==== Source: s2.hyp ====
import "s1.hyp";
function f() pure returns (uint) { return 42; }
contract D is C {
  function f() public pure override returns (uint) {
    return f();
  }
}
// ----
// Warning 2519: (s1.hyp:65-134): This declaration shadows an existing declaration.
// Warning 2519: (s2.hyp:85-155): This declaration shadows an existing declaration.
// DeclarationError 1686: (s2.hyp:17-64): Function with same name and parameter types defined twice.
