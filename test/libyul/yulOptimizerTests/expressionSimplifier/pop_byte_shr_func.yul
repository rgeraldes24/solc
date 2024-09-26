{
  function f() -> x { mstore(0, 1337) }
  mstore(0, byte(0, shr(0x8, f())))
}
// ----
// step: expressionSimplifier
//
// {
//     {
//         pop(f())
//         mstore(0, 0)
//     }
//     function f() -> x
//     { mstore(0, 1337) }
// }
