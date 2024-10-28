type A is address;

using {add as +} for A global;

function add(A a, A b) pure returns (A) {
    return A.wrap(address(uint160(A.unwrap(a)) + uint160(A.unwrap(b))));
}

contract C {
    function g() public pure returns (A) {
        A a = A.wrap(Z3333333333333333333333333333333333333333);
        A b = A.wrap(Z1111111111111111111111111111111111111111);
        A c = A.wrap(Z5555555555555555555555555555555555555555);
        return a + b + c;
    }
}
// ----
// g() -> Z9999999999999999999999999999999999999999
