{
  for {} div(create(0, 1, 1), shl(msize(), 1)) {}
  {
  }
}
// ====
// EVMVersion: >shanghai
// ----
// step: expressionSimplifier
//
// {
//     {
//         for { } div(create(0, 1, 1), shl(msize(), 1)) { }
//         { }
//     }
// }
