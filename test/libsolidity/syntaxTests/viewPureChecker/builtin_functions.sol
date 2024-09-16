contract C {
    function f() public {
        payable(this).transfer(1);
        require(payable(this).send(2));
        selfdestruct(payable(this));
        (bool success,) = address(this).delegatecall("");
        require(success);
		(success,) = address(this).call("");
        require(success);
    }
    function g() pure public {
        bytes32 x = keccak256("abc");
        bytes32 y = sha256("abc");
        require(true);
        assert(true);
        x; y;
    }
    receive() payable external {}
}
// ----
// Warning 5159: (122-134): "selfdestruct" has been deprecated. The underlying opcode will eventually undergo breaking changes, and its use is not recommended.
