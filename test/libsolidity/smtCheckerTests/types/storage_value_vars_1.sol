contract C
{
    address a;
    bool b;
    uint c;
    function f(uint x) public {
        if (x == 0)
        {
            a = Z0000000000000000000000000000000000000100;
            b = true;
        }
        else
        {
            a = Z0000000000000000000000000000000000000200;
            b = false;
        }
        assert(a > Z0000000000000000000000000000000000000000 && b);
    }
}
// ====
// SMTEngine: all
// ----
// TODO(rgeraldes24)
// Warning 6328: (330-389): CHC: Assertion violation happens here.\nCounterexample:\na = 0x0200, b = false, c = 0\nx = 1\n\nTransaction trace:\nC.constructor()\nState: a = 0x0, b = false, c = 0\nC.f(1)
