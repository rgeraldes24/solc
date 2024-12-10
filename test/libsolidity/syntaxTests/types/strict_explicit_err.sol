contract B{}

enum E { Value }

contract C
{
    function f() public pure {

        uint16 a = uint16(int8(-1));

        int8 b = -1;
        uint16 c = uint16(b);

        int8 d = int8(uint16(type(uint16).max));

        uint16 e = type(uint16).max;
        int8 g = int8(e);

        address h = address(uint(type(uint).max));

        uint i = uint(address(0));

        uint j = type(uint).max;
        address k = address(j);

        int80 l = int80(bytes10("h"));
        bytes10 m = bytes10(int80(-1));

        B n = B(int(100));
        int o = int(new B());

        B p = B(0x00);

        int q = int(E(0));
        int r = int(E.Value);
    }
}
// ----
// TypeError 9640: (96-112): Explicit type conversion not allowed from "int8" to "uint16".
// TypeError 9640: (155-164): Explicit type conversion not allowed from "int8" to "uint16".
// TypeError 9640: (184-214): Explicit type conversion not allowed from "uint16" to "int8".
// TypeError 9640: (271-278): Explicit type conversion not allowed from "uint16" to "int8".
// TypeError 9640: (301-330): Explicit type conversion not allowed from "uint256" to "address".
// TypeError 9640: (350-366): Explicit type conversion not allowed from "address" to "uint256".
// TypeError 9640: (422-432): Explicit type conversion not allowed from "uint256" to "address".
// TypeError 9640: (453-472): Explicit type conversion not allowed from "bytes10" to "int80".
// TypeError 9640: (494-512): Explicit type conversion not allowed from "int80" to "bytes10".
// TypeError 9640: (529-540): Explicit type conversion not allowed from "int256" to "contract B".
// TypeError 9640: (558-570): Explicit type conversion not allowed from "contract B" to "int256".
// TypeError 9640: (587-594): Explicit type conversion not allowed from "int_const 0" to "contract B".
// TypeError 9640: (613-622): Explicit type conversion not allowed from "enum E" to "int256".
// TypeError 9640: (640-652): Explicit type conversion not allowed from "enum E" to "int256".
