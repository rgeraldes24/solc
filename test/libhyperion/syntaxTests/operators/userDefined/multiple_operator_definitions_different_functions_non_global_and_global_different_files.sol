==== Source: Int.hyp ====
type Int is int;

using {add as +} for Int;

function add(Int, Int) pure returns (Int) {}

==== Source: test.hyp ====
import "Int.hyp";

using {anotherAdd as +} for Int global;

function anotherAdd(Int, Int) pure returns (Int) {}

function test() pure returns (Int) {
    return Int.wrap(0) + Int.wrap(0);
}
// ----
// TypeError 3320: (Int.hyp:25-28): Operators can only be defined in a global 'using for' directive.
// TypeError 4117: (test.hyp:19-58): Can only use "global" with types defined in the same source unit at file level.
