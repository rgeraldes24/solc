set(sources
    soltest.cpp
    Common.cpp
    Common.h
    CommonSyntaxTest.cpp
    CommonSyntaxTest.h
    ZVMHost.cpp
    ZVMHost.h
    ExecutionFramework.cpp
    ExecutionFramework.h
    FilesystemUtils.cpp
    FilesystemUtils.h
    InteractiveTests.h
    Metadata.cpp
    Metadata.h
    TestCase.cpp
    TestCase.h
    TestCaseReader.cpp
    TestCaseReader.h
)
detect_stray_source_files("${sources}" ".")

set(contracts_sources
    contracts/AuctionRegistrar.cpp
    contracts/ContractInterface.h
    contracts/Wallet.cpp
)
detect_stray_source_files("${contracts_sources}" "contracts/")

set(libsolutil_sources
    libsolutil/Checksum.cpp
    libsolutil/CommonData.cpp
    libsolutil/CommonIO.cpp
    libsolutil/FixedHash.cpp
    libsolutil/FunctionSelector.cpp
    libsolutil/IpfsHash.cpp
    libsolutil/IterateReplacing.cpp
    libsolutil/JSON.cpp
    libsolutil/Keccak256.cpp
    libsolutil/LazyInit.cpp
    libsolutil/LEB128.cpp
    libsolutil/StringUtils.cpp
    libsolutil/SwarmHash.cpp
    libsolutil/TemporaryDirectoryTest.cpp
    libsolutil/UTF8.cpp
    libsolutil/Whiskers.cpp
)
detect_stray_source_files("${libsolutil_sources}" "libsolutil/")

set(libzvmasm_sources
    libzvmasm/Assembler.cpp
    libzvmasm/Optimiser.cpp
)
detect_stray_source_files("${libzvmasm_sources}" "libzvmasm/")

set(liblangutil_sources
    liblangutil/CharStream.cpp
    liblangutil/Scanner.cpp
    liblangutil/SourceLocation.cpp
)
detect_stray_source_files("${liblangutil_sources}" "liblangutil/")

set(libhyperion_sources
    libhyperion/ABIDecoderTests.cpp
    libhyperion/ABIEncoderTests.cpp
    libhyperion/ABIJsonTest.cpp
    libhyperion/ABIJsonTest.h
    libhyperion/ABITestsCommon.h
    libhyperion/AnalysisFramework.cpp
    libhyperion/AnalysisFramework.h
    libhyperion/Assembly.cpp
    libhyperion/ASTJSONTest.cpp
    libhyperion/ASTJSONTest.h
    libhyperion/ErrorCheck.cpp
    libhyperion/ErrorCheck.h
    libhyperion/GasCosts.cpp
    libhyperion/GasMeter.cpp
    libhyperion/GasTest.cpp
    libhyperion/GasTest.h
    libhyperion/Imports.cpp
    libhyperion/InlineAssembly.cpp
    libhyperion/LibSolc.cpp
    libhyperion/Metadata.cpp
    libhyperion/MemoryGuardTest.cpp
    libhyperion/MemoryGuardTest.h
    libhyperion/NatspecJSONTest.cpp
    libhyperion/NatspecJSONTest.h
    libhyperion/SemanticTest.cpp
    libhyperion/SemanticTest.h
    libhyperion/SemVerMatcher.cpp
    libhyperion/SMTCheckerTest.cpp
    libhyperion/SMTCheckerTest.h
    libhyperion/SolidityCompiler.cpp
    libhyperion/SolidityEndToEndTest.cpp
    libhyperion/SolidityExecutionFramework.cpp
    libhyperion/SolidityExecutionFramework.h
    libhyperion/SolidityExpressionCompiler.cpp
    libhyperion/SolidityNameAndTypeResolution.cpp
    libhyperion/SolidityOptimizer.cpp
    libhyperion/SolidityParser.cpp
    libhyperion/SolidityTypes.cpp
    libhyperion/StandardCompiler.cpp
    libhyperion/SyntaxTest.cpp
    libhyperion/SyntaxTest.h
    libhyperion/ViewPureChecker.cpp
    libhyperion/analysis/FunctionCallGraph.cpp
    libhyperion/interface/FileReader.cpp
    libhyperion/ASTPropertyTest.h
    libhyperion/ASTPropertyTest.cpp
)
detect_stray_source_files("${libhyperion_sources}" "libhyperion/")

set(libhyperion_util_sources
    libhyperion/util/BytesUtils.cpp
    libhyperion/util/BytesUtilsTests.cpp
    libhyperion/util/BytesUtils.h
    libhyperion/util/Common.cpp
    libhyperion/util/Common.h
    libhyperion/util/ContractABIUtils.cpp
    libhyperion/util/ContractABIUtils.h
    libhyperion/util/SoltestErrors.h
    libhyperion/util/SoltestTypes.h
    libhyperion/util/TestFileParser.cpp
    libhyperion/util/TestFileParser.h
    libhyperion/util/TestFileParserTests.cpp
    libhyperion/util/TestFunctionCall.cpp
    libhyperion/util/TestFunctionCall.h
    libhyperion/util/TestFunctionCallTests.cpp
)
detect_stray_source_files("${libhyperion_util_sources}" "libhyperion/util/")

set(libyul_sources
    libyul/Common.cpp
    libyul/Common.h
    libyul/CompilabilityChecker.cpp
    libyul/ControlFlowGraphTest.cpp
    libyul/ControlFlowGraphTest.h
    libyul/ControlFlowSideEffectsTest.cpp
    libyul/ControlFlowSideEffectsTest.h
    libyul/ZVMCodeTransformTest.cpp
    libyul/ZVMCodeTransformTest.h
    libyul/FunctionSideEffects.cpp
    libyul/FunctionSideEffects.h
    libyul/Inliner.cpp
    libyul/KnowledgeBaseTest.cpp
    libyul/Metrics.cpp
    libyul/ObjectCompilerTest.cpp
    libyul/ObjectCompilerTest.h
    libyul/ObjectParser.cpp
    libyul/Parser.cpp
    libyul/StackLayoutGeneratorTest.cpp
    libyul/StackLayoutGeneratorTest.h
    libyul/StackShufflingTest.cpp
    libyul/StackShufflingTest.h
    libyul/SyntaxTest.h
    libyul/SyntaxTest.cpp
    libyul/YulInterpreterTest.cpp
    libyul/YulInterpreterTest.h
    libyul/YulOptimizerTest.cpp
    libyul/YulOptimizerTest.h
    libyul/YulOptimizerTestCommon.cpp
    libyul/YulOptimizerTestCommon.h
)
detect_stray_source_files("${libyul_sources}" "libyul/")

set(hypcli_sources
    hypc/Common.cpp
    hypc/Common.h
    hypc/CommandLineInterface.cpp
    hypc/CommandLineInterfaceAllowPaths.cpp
    hypc/CommandLineParser.cpp
)
detect_stray_source_files("${hypcli_sources}" "hypc/")

set(yul_phaser_sources
    yulPhaser/TestHelpers.h
    yulPhaser/TestHelpers.cpp
    yulPhaser/TestHelpersTest.cpp
    yulPhaser/Common.cpp
    yulPhaser/Chromosome.cpp
    yulPhaser/FitnessMetrics.cpp
    yulPhaser/AlgorithmRunner.cpp
    yulPhaser/GeneticAlgorithms.cpp
    yulPhaser/Mutations.cpp
    yulPhaser/PairSelections.cpp
    yulPhaser/Phaser.cpp
    yulPhaser/Population.cpp
    yulPhaser/Program.cpp
    yulPhaser/ProgramCache.cpp
    yulPhaser/Selections.cpp
    yulPhaser/SimulationRNG.cpp
)
detect_stray_source_files("${yul_phaser_sources}" "yulPhaser/")

add_executable(soltest ${sources}
    ${contracts_sources}
    ${libsolutil_sources}
    ${liblangutil_sources}
    ${libzvmasm_sources}
    ${libyul_sources}
    ${libhyperion_sources}
    ${libhyperion_util_sources}
    ${hypcli_sources}
    ${yul_phaser_sources}
)
target_link_libraries(soltest PRIVATE hypcli libhypc yul hyperion smtutil solutil phaser Boost::boost yulInterpreter zvmasm Boost::filesystem Boost::program_options Boost::unit_test_framework zvmc)


# Special compilation flag for Visual Studio (version 2019 at least affected)
# in order to compile SolidityEndToEndTest.cpp, which is quite huge.
# We can remove this flag once we've extracted the tests.
# TODO: Remove this option as soon as we have reduced the SLoC's in SolidityEndToEndTest.cpp
if (MSVC)
    target_compile_options(soltest PUBLIC "/bigobj")
endif()

if (NOT Boost_USE_STATIC_LIBS)
    target_compile_definitions(soltest PUBLIC -DBOOST_TEST_DYN_LINK)
endif()

add_subdirectory(tools)
add_subdirectory(zvmc)
