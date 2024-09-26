{
  let s := returndatasize()
  returndatacopy(0,0,s)
}
// ----
// step: unusedStoreEliminator
//
// {
//     {
//         let s := returndatasize()
//         let _1 := 0
//         let _2 := 0
//     }
// }
