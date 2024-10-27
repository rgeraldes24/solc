{
    let a := address()
    let ret := balance(a)
    sstore(a, ret)
}
// ----
// step: expressionSimplifier
//
// {
//     {
//         let a := address()
//         sstore(a, selfbalance())
//     }
// }
