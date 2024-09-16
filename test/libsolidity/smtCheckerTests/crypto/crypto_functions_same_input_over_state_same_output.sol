contract C {
	bytes data;

	bytes32 kec;
	bytes32 sha;

	constructor(bytes memory _data, bytes32 _h, uint8 _v, bytes32 _r, bytes32 _s) {
		data = _data;

		kec = keccak256(data);
		sha = sha256(data);
	}

	function f() public view {
		bytes32 _kec = keccak256(data);
		bytes32 _sha = sha256(data);
		assert(_kec == kec);
		assert(_sha == sha);
	}
}
// ====
// SMTEngine: all
// ----
// Info 1391: CHC: 4 verification condition(s) proved safe! Enable the model checker option "show proved safe" to see all of them.
