pragma abicoder               v2;


// Checks that address types are properly cleaned before they are compared.
contract C {
    function f(address a) public returns (uint256) {
        if (a != Z1234567890123456789012345678901234567890) return 1;
        return 0;
    }

    function g(address payable a) public returns (uint256) {
        if (a != Z1234567890123456789012345678901234567890) return 1;
        return 0;
    }
}
// ----
// f(address): Zffff1234567890123456789012345678901234567890 -> FAILURE # We input longer data on purpose.#
// g(address): Zffff1234567890123456789012345678901234567890 -> FAILURE
