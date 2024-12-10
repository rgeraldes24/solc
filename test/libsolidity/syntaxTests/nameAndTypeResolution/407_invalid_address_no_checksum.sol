contract C {
    function f() pure public {
        address x = Zfa0bfc97e48458494ccd857e1a85dc91f7f0046e;
        x;
    }
}
// ----
// SyntaxError 9429: (64-105): This looks like an address but has an invalid checksum. Correct checksummed address: "ZfA0bFc97E48458494Ccd857e1A85DC91F7F0046E". If this is not used as an address, please prepend '00'. For more information please see https://docs.soliditylang.org/en/develop/types.html#address-literals
