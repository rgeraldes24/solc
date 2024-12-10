contract A {
	int public testvar;
	function foo() internal override(N, T) returns (uint256);
}
// ----
// DeclarationError 7920: (68-69): Identifier not found or not unique.
