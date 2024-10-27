contract C {
  function f(bytes calldata x) public returns (C[] memory) {
    return abi.decode(x, (C[]));
  }
  function g() public returns (bytes memory) {
    C[] memory c = new C[](3);
    c[0] = C(address(Z42));
    c[1] = C(address(Z21));
    c[2] = C(address(Z23));
    return abi.encode(c);
  }
}
// ----
// f(bytes): 0x20, 0xA0, 0x20, 3, 0x01, 0x02, 0x03 -> 0x20, 3, 0x01, 0x02, 0x03
// g() -> 0x20, 0xa0, 0x20, 3, 0x42, 0x21, 0x23
