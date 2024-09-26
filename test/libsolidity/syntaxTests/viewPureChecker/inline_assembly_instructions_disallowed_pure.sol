contract C {
    function f() public pure {
        assembly {
            pop(sload(0))
            sstore(0, 1)
            pop(gas())
            pop(address())
            pop(balance(0))
            pop(caller())
            pop(callvalue())
            pop(extcodesize(0))
            extcodecopy(0, 1, 2, 3)
            pop(create(0, 1, 2))
            pop(call(0, 1, 2, 3, 4, 5, 6))
            pop(delegatecall(0, 1, 2, 3, 4, 5))
            log0(0, 1)
            log1(0, 1, 2)
            log2(0, 1, 2, 3)
            log3(0, 1, 2, 3, 4)
            log4(0, 1, 2, 3, 4, 5)
            pop(origin())
            pop(gasprice())
            pop(blockhash(0))
            pop(coinbase())
            pop(timestamp())
            pop(number())
            pop(gaslimit())

            // These two are disallowed too but the error suppresses other errors.
            //pop(msize())
            //pop(pc())
        }
    }
}
// ----
// TypeError 2527: (79-87): Function declared as pure, but this expression (potentially) reads from the environment or state and thus requires "view".
// TypeError 8961: (101-113): Function cannot be declared as pure because this expression (potentially) modifies the state.
// TypeError 2527: (130-135): Function declared as pure, but this expression (potentially) reads from the environment or state and thus requires "view".
// TypeError 2527: (153-162): Function declared as pure, but this expression (potentially) reads from the environment or state and thus requires "view".
// TypeError 2527: (180-190): Function declared as pure, but this expression (potentially) reads from the environment or state and thus requires "view".
// TypeError 2527: (208-216): Function declared as pure, but this expression (potentially) reads from the environment or state and thus requires "view".
// TypeError 2527: (234-245): Function declared as pure, but this expression (potentially) reads from the environment or state and thus requires "view".
// TypeError 2527: (263-277): Function declared as pure, but this expression (potentially) reads from the environment or state and thus requires "view".
// TypeError 2527: (291-314): Function declared as pure, but this expression (potentially) reads from the environment or state and thus requires "view".
// TypeError 8961: (331-346): Function cannot be declared as pure because this expression (potentially) modifies the state.
// TypeError 8961: (364-389): Function cannot be declared as pure because this expression (potentially) modifies the state.
// TypeError 8961: (407-437): Function cannot be declared as pure because this expression (potentially) modifies the state.
// TypeError 8961: (451-461): Function cannot be declared as pure because this expression (potentially) modifies the state.
// TypeError 8961: (474-487): Function cannot be declared as pure because this expression (potentially) modifies the state.
// TypeError 8961: (500-516): Function cannot be declared as pure because this expression (potentially) modifies the state.
// TypeError 8961: (529-548): Function cannot be declared as pure because this expression (potentially) modifies the state.
// TypeError 8961: (561-583): Function cannot be declared as pure because this expression (potentially) modifies the state.
// TypeError 2527: (600-608): Function declared as pure, but this expression (potentially) reads from the environment or state and thus requires "view".
// TypeError 2527: (626-636): Function declared as pure, but this expression (potentially) reads from the environment or state and thus requires "view".
// TypeError 2527: (654-666): Function declared as pure, but this expression (potentially) reads from the environment or state and thus requires "view".
// TypeError 2527: (684-694): Function declared as pure, but this expression (potentially) reads from the environment or state and thus requires "view".
// TypeError 2527: (712-723): Function declared as pure, but this expression (potentially) reads from the environment or state and thus requires "view".
// TypeError 2527: (741-749): Function declared as pure, but this expression (potentially) reads from the environment or state and thus requires "view".
// TypeError 2527: (767-777): Function declared as pure, but this expression (potentially) reads from the environment or state and thus requires "view".
