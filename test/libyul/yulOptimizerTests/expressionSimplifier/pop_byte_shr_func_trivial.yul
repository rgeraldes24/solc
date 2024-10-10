{
  function f() -> x {}
  sstore(0, byte(0, shr(0x8, f())))
}
// ----
// step: expressionSimplifier
//
// { { sstore(0, 0) } }
