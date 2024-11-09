contract C {
    struct S {
        uint x;
    }

    enum E {A, B, C}

    function f() public {
        string.concat(
            false,
            1,
            1e10,
            1e-10,
            0.1,
            0x1234567,
            0x11112222333344445555666677778888999900,     // One byte less than an address
            Z1111222233334444555566667777888899990000,   // Address
            0x111122223333444455556666777788889999000011, // One byte more than an address
            0x00112233445566778899aabbccddeeff00112233445566778899aabbccddeeff,  // exactly 32 bytes
            -0x0000000000000000000000000000000000000000000000000000000000000001, // exactly 32 bytes
            bytes(bytes32(0x00112233445566778899aabbccddeeff00112233445566778899aabbccddeeff))[:],
            f,
            (),
            (0, 0),
            [0],
            [0][:],
            [0][0],
            new C(),
            S(0),
            E.A
        );
    }
}
// ----
// TypeError 9640: (697-779): Explicit type conversion not allowed from "bytes32" to "bytes memory".
// TypeError 1227: (697-782): Index range access is only supported for dynamic calldata arrays.
// TypeError 1227: (864-870): Index range access is only supported for dynamic calldata arrays.
// TypeError 9977: (134-139): Invalid type for argument in the string.concat function call. string type is required, but t_bool provided.
// TypeError 9977: (153-154): Invalid type for argument in the string.concat function call. string type is required, but t_rational_1_by_1 provided.
// TypeError 9977: (168-172): Invalid type for argument in the string.concat function call. string type is required, but t_rational_10000000000_by_1 provided.
// TypeError 9977: (186-191): Invalid type for argument in the string.concat function call. string type is required, but t_rational_1_by_10000000000 provided.
// TypeError 9977: (205-208): Invalid type for argument in the string.concat function call. string type is required, but t_rational_1_by_10 provided.
// TypeError 9977: (222-231): Invalid type for argument in the string.concat function call. string type is required, but t_rational_19088743_by_1 provided.
// TypeError 9977: (245-285): Invalid type for argument in the string.concat function call. string type is required, but t_rational_380605192295934637532253317235440047844071680_by_1 provided.
// TypeError 9977: (336-377): Invalid type for argument in the string.concat function call. string type is required, but t_address provided.
// TypeError 9977: (404-448): Invalid type for argument in the string.concat function call. string type is required, but t_rational_24943341882306372405313753398341798975509081620497_by_1 provided.
// TypeError 9977: (495-561): Invalid type for argument in the string.concat function call. string type is required, but t_rational_30272441630670900764332283662402067049651745785153368133042924362431065855_by_1 provided.
// TypeError 9977: (596-663): Invalid type for argument in the string.concat function call. string type is required, but t_rational_minus_1_by_1 provided.
// TypeError 9977: (697-782): Invalid type for argument in the string.concat function call. string type is required, but t_bytes_memory_ptr_slice provided.
// TypeError 9977: (796-797): Invalid type for argument in the string.concat function call. string type is required, but t_function_internal_nonpayable$__$returns$__$ provided.
// TypeError 9977: (811-813): Invalid type for argument in the string.concat function call. string type is required, but t_tuple$__$ provided.
// TypeError 9977: (827-833): Invalid type for argument in the string.concat function call. string type is required, but t_tuple$_t_rational_0_by_1_$_t_rational_0_by_1_$ provided.
// TypeError 9977: (847-850): Invalid type for argument in the string.concat function call. string type is required, but t_array$_t_uint8_$1_memory_ptr provided.
// TypeError 9977: (864-870): Invalid type for argument in the string.concat function call. string type is required, but t_array$_t_uint8_$1_memory_ptr_slice provided.
// TypeError 9977: (884-890): Invalid type for argument in the string.concat function call. string type is required, but t_uint8 provided.
// TypeError 9977: (904-911): Invalid type for argument in the string.concat function call. string type is required, but t_contract$_C_$61 provided.
// TypeError 9977: (925-929): Invalid type for argument in the string.concat function call. string type is required, but t_struct$_S_$4_memory_ptr provided.
// TypeError 9977: (943-946): Invalid type for argument in the string.concat function call. string type is required, but t_enum$_E_$8 provided.

