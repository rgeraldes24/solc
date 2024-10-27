contract test {
    function f() public {
        address(Z12).delegatecall("abc");
    }
}
// ----
// Warning 9302: (50-83): Return value of low-level calls not used.
