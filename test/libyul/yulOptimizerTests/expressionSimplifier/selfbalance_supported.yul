{
    sstore(0, balance(address()))
}
// ----
// step: expressionSimplifier
//
// { { sstore(0, selfbalance()) } }
