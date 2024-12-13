add_subdirectory(ossfuzz)

add_subdirectory(yulInterpreter)
add_executable(yulrun yulrun.cpp)
target_link_libraries(yulrun PRIVATE yulInterpreter libhypc evmasm Boost::boost Boost::program_options)

add_executable(solfuzzer afl_fuzzer.cpp fuzzer_common.cpp)
target_link_libraries(solfuzzer PRIVATE libhypc evmasm Boost::boost Boost::program_options Boost::system)

add_executable(yulopti yulopti.cpp)
target_link_libraries(yulopti PRIVATE solidity Boost::boost Boost::program_options Boost::system)

add_executable(isoltest
	isoltest.cpp
	IsolTestOptions.cpp
	../Common.cpp
	../CommonSyntaxTest.cpp
	../ZVMHost.cpp
	../TestCase.cpp
	../TestCaseReader.cpp
	../libhyperion/util/BytesUtils.cpp
	../libhyperion/util/Common.cpp
	../libhyperion/util/ContractABIUtils.cpp
	../libhyperion/util/TestFileParser.cpp
	../libhyperion/util/TestFunctionCall.cpp
	../libhyperion/GasTest.cpp
	../libhyperion/MemoryGuardTest.cpp
	../libhyperion/NatspecJSONTest.cpp
	../libhyperion/SyntaxTest.cpp
	../libhyperion/SemanticTest.cpp
	../libhyperion/AnalysisFramework.cpp
	../libhyperion/SolidityExecutionFramework.cpp
	../ExecutionFramework.cpp
	../libhyperion/ABIJsonTest.cpp
	../libhyperion/ASTJSONTest.cpp
	../libhyperion/ASTPropertyTest.cpp
	../libhyperion/SMTCheckerTest.cpp
	../libyul/Common.cpp
	../libyul/ControlFlowGraphTest.cpp
	../libyul/ControlFlowSideEffectsTest.cpp
	../libyul/EVMCodeTransformTest.cpp
	../libyul/FunctionSideEffects.cpp
	../libyul/ObjectCompilerTest.cpp
	../libyul/SyntaxTest.cpp
	../libyul/StackShufflingTest.cpp
	../libyul/StackLayoutGeneratorTest.cpp
	../libyul/YulOptimizerTest.cpp
	../libyul/YulOptimizerTestCommon.cpp
	../libyul/YulInterpreterTest.cpp
)
target_compile_definitions(isoltest PRIVATE ISOLTEST)
target_link_libraries(isoltest PRIVATE evmc libhypc solidity yulInterpreter evmasm Boost::boost Boost::program_options Boost::unit_test_framework Threads::Threads)
