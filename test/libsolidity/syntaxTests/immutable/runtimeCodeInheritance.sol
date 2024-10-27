contract Base {
    address public immutable user = address(Z0);
}

contract Derived is Base {}

contract Test {
    function test() public pure returns(bytes memory) {
        return type(Derived).runtimeCode;
    }
}
// ----
// TypeError 9274: (185-210): "runtimeCode" is not available for contracts containing immutable variables.
