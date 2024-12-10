type I16 is int16;
using {
    bitor as |, bitand as &, bitxor as ^, bitnot as ~,
    add as +, sub as -, unsub as -, mul as *, div as /, mod as %,
    eq as ==, noteq as !=, lt as <, gt as >, leq as <=, geq as >=
} for I16 global;

function bitor(I16 x, I16 y) pure returns (I16) { return I16.wrap(I16.unwrap(x) | I16.unwrap(y)); }
function bitand(I16 x, I16 y) pure returns (I16) { return I16.wrap(I16.unwrap(x) & I16.unwrap(y)); }
function bitxor(I16 x, I16 y) pure returns (I16) { return I16.wrap(I16.unwrap(x) ^ I16.unwrap(y)); }
function bitnot(I16 x) pure returns (I16) { return I16.wrap(~I16.unwrap(x)); }

function add(I16 x, I16 y) pure returns (I16) { return I16.wrap(I16.unwrap(x) + I16.unwrap(y)); }
function sub(I16 x, I16 y) pure returns (I16) { return I16.wrap(I16.unwrap(x) - I16.unwrap(y)); }
function unsub(I16 x) pure returns (I16) { return I16.wrap(-I16.unwrap(x)); }
function mul(I16 x, I16 y) pure returns (I16) { return I16.wrap(I16.unwrap(x) * I16.unwrap(y)); }
function div(I16 x, I16 y) pure returns (I16) { return I16.wrap(I16.unwrap(x) / I16.unwrap(y)); }
function mod(I16 x, I16 y) pure returns (I16) { return I16.wrap(I16.unwrap(x) % I16.unwrap(y)); }

function eq(I16 x, I16 y) pure returns (bool) { return I16.unwrap(x) == I16.unwrap(y); }
function noteq(I16 x, I16 y) pure returns (bool) { return I16.unwrap(x) != I16.unwrap(y); }
function lt(I16 x, I16 y) pure returns (bool) { return I16.unwrap(x) < I16.unwrap(y); }
function gt(I16 x, I16 y) pure returns (bool) { return I16.unwrap(x) > I16.unwrap(y); }
function leq(I16 x, I16 y) pure returns (bool) { return I16.unwrap(x) <= I16.unwrap(y); }
function geq(I16 x, I16 y) pure returns (bool) { return I16.unwrap(x) >= I16.unwrap(y); }

contract C {
    I16 constant MINUS_TWO = I16.wrap(-2);
    I16 constant VALUEZERO = I16.wrap(0);
    I16 constant ONE = I16.wrap(1);
    I16 constant TWO = I16.wrap(2);
    I16 constant THREE = I16.wrap(3);
    I16 constant FOUR = I16.wrap(4);

    function testBitwise() public pure {
        assert(ONE | TWO == FOUR); // should fail
        assert(ONE & THREE == FOUR); // should fail
        assert(TWO ^ TWO == FOUR); // should fail
        assert(~ONE == FOUR); // should fail
    }

    function testArithmetic() public pure {
        assert(TWO + THREE == FOUR); // should fail
        assert(TWO - TWO == FOUR); // should fail
        assert(-TWO == FOUR); // should fail
        assert(TWO * THREE == FOUR); // should fail
        assert(TWO / TWO == FOUR); // should fail
        assert(TWO % TWO == FOUR); // should fail
    }

    function testComparison() public pure {
        assert(!(TWO == TWO)); // should fail
        assert(TWO != TWO); // should fail
        assert(TWO < TWO); // should fail
        assert(TWO > TWO); // should fail
        assert(!(TWO <= TWO)); // should fail
        assert(!(TWO >= TWO)); // should fail
    }
}
// ====
// SMTEngine: all
// ----
// Warning 6328: (2017-2042): CHC: Assertion violation happens here.
// Warning 6328: (2067-2094): CHC: Assertion violation happens here.
// Warning 6328: (2119-2144): CHC: Assertion violation happens here.
// Warning 6328: (2169-2189): CHC: Assertion violation happens here.
// Warning 6328: (2265-2292): CHC: Assertion violation happens here.
// Warning 6328: (2317-2342): CHC: Assertion violation happens here.
// Warning 6328: (2367-2387): CHC: Assertion violation happens here.
// Warning 6328: (2412-2439): CHC: Assertion violation happens here.
// Warning 6328: (2464-2489): CHC: Assertion violation happens here.
// Warning 6328: (2514-2539): CHC: Assertion violation happens here.
// Warning 6328: (2615-2636): CHC: Assertion violation happens here.
// Warning 6328: (2661-2679): CHC: Assertion violation happens here.
// Warning 6328: (2704-2721): CHC: Assertion violation happens here.
// Warning 6328: (2746-2763): CHC: Assertion violation happens here.
// Warning 6328: (2788-2809): CHC: Assertion violation happens here.
// Warning 6328: (2834-2855): CHC: Assertion violation happens here.
// Info 1391: CHC: 5 verification condition(s) proved safe! Enable the model checker option "show proved safe" to see all of them.
