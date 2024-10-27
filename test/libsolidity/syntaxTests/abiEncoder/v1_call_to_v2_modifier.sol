==== Source: A ====
pragma abicoder               v2;

struct Data {
    bool flag;
}

contract A {
    function get() public view returns (Data memory) {}
}

contract B {
    modifier validate() {
        A(address(Z00)).get();
        _;
    }
}
==== Source: B ====
pragma abicoder v1;
import "A";

contract C is B {
    function foo()
        public
        validate()
    {}
}
// ----
