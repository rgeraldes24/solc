contract C {
    function f() view public {
        bytes32 x = keccak256("abc");
        bytes32 y = sha256("abc");
        require(true);
        assert(true);
        x; y;
    }
    function g() public {
        bytes32 x = keccak256("abc");
        bytes32 y = sha256("abc");
        require(true);
        assert(true);
        x; y;
    }
}
// ----
// Warning 2018: (17-288): Function state mutability can be restricted to pure
// Warning 2018: (293-559): Function state mutability can be restricted to pure
