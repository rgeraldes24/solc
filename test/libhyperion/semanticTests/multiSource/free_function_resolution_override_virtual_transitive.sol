==== Source: s1.hyp ====
function f() pure returns (uint) { return 1337; }
contract C {
  function g() public pure virtual returns (uint) {
    return f();
  }
}
==== Source: s2.hyp ====
import "s1.hyp";
contract D is C {
  function g() public pure virtual override returns (uint) {
    return super.g() + 1;
  }
}
==== Source: s3.hyp ====
import "s2.hyp";
contract E is D {
  function g() public pure override returns (uint) {
    return super.g() + 1;
  }
}
// ----
// g() -> 1339
