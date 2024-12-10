if (EMSCRIPTEN)
	CreateExportedFunctionsForEMSDK(
		ExportedFunctions
		solidity_license
		solidity_version
		solidity_compile
		solidity_alloc
		solidity_free
		solidity_reset
	)
	# Specify which functions to export in soljson.js.
	# Note that additional Emscripten-generated methods needed by hypc-js are
	# defined to be exported in cmake/EthCompilerSettings.cmake.
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -s EXPORTED_FUNCTIONS='${ExportedFunctions}'")
	add_executable(soljson libhypc.cpp libhypc.h)
	target_link_libraries(soljson PRIVATE hyperion)
else()
	add_library(libhypc libhypc.cpp libhypc.h)
	set_target_properties(libhypc PROPERTIES OUTPUT_NAME hypc)
	target_link_libraries(libhypc PRIVATE hyperion)
endif()
