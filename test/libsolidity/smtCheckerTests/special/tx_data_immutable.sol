contract C {
	bytes32 bhash;
	address coin;
	uint prevrandao;
	uint glimit;
	uint number;
	uint tstamp;
	bytes mdata;
	address sender;
	bytes4 sig;
	uint value;
	uint gprice;
	address origin;

	function f() public payable {
		bhash = blockhash(12);
		coin = block.coinbase;
		prevrandao = block.prevrandao;
		glimit = block.gaslimit;
		number = block.number;
		tstamp = block.timestamp;
		mdata = msg.data;
		sender = msg.sender;
		sig = msg.sig;
		value = msg.value;
		gprice = tx.gasprice;
		origin = tx.origin;

		fi();

		assert(bhash == blockhash(12));
		assert(coin == block.coinbase);
		assert(prevrandao == block.prevrandao);
		assert(glimit == block.gaslimit);
		assert(number == block.number);
		assert(tstamp == block.timestamp);
		assert(mdata.length == msg.data.length);
		assert(sender == msg.sender);
		assert(sig == msg.sig);
		assert(value == msg.value);
		assert(gprice == tx.gasprice);
		assert(origin == tx.origin);
	}

	function fi() internal view {
		assert(bhash == blockhash(12));
		assert(coin == block.coinbase);
		assert(prevrandao == block.prevrandao);
		assert(glimit == block.gaslimit);
		assert(number == block.number);
		assert(tstamp == block.timestamp);
		assert(mdata.length == msg.data.length);
		assert(sender == msg.sender);
		assert(sig == msg.sig);
		assert(value == msg.value);
		assert(gprice == tx.gasprice);
		assert(origin == tx.origin);
	}
}
// ====
// SMTEngine: all
// ----
// Info 1391: CHC: 24 verification condition(s) proved safe! Enable the model checker option "show proved safe" to see all of them.
