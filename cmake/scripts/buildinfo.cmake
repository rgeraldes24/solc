# generates BuildInfo.h
#
# this module expects
# ZOND_SOURCE_DIR - main CMAKE_SOURCE_DIR
# ZOND_DST_DIR - main CMAKE_BINARY_DIR
# ZOND_BUILD_TYPE
# ZOND_BUILD_PLATFORM
#
# example usage:
# cmake -DZOND_SOURCE_DIR=. -DZOND_DST_DIR=build -DZOND_BUILD_TYPE=Debug -DZOND_BUILD_PLATFORM=Darwin.appleclang -P scripts/buildinfo.cmake
#
# Its main output variables are SOL_VERSION_BUILDINFO and SOL_VERSION_PRERELEASE

if (NOT ZOND_BUILD_TYPE)
	set(ZOND_BUILD_TYPE "unknown")
endif()

if (NOT ZOND_BUILD_PLATFORM)
	set(ZOND_BUILD_PLATFORM "unknown")
endif()

# Logic here: If prerelease.txt exists but is empty, it is a non-pre release.
# If it does not exist, create our own prerelease string
if (EXISTS ${ZOND_SOURCE_DIR}/prerelease.txt)
	file(READ ${ZOND_SOURCE_DIR}/prerelease.txt SOL_VERSION_PRERELEASE)
	string(STRIP "${SOL_VERSION_PRERELEASE}" SOL_VERSION_PRERELEASE)
else()
	string(TIMESTAMP SOL_VERSION_PRERELEASE "develop.%Y.%m.%d" UTC)
	string(REPLACE .0 . SOL_VERSION_PRERELEASE "${SOL_VERSION_PRERELEASE}")
endif()

if (EXISTS ${ZOND_SOURCE_DIR}/commit_hash.txt)
	file(READ ${ZOND_SOURCE_DIR}/commit_hash.txt SOL_COMMIT_HASH)
	string(STRIP ${SOL_COMMIT_HASH} SOL_COMMIT_HASH)
else()
	execute_process(
		COMMAND git --git-dir=${ZOND_SOURCE_DIR}/.git --work-tree=${ZOND_SOURCE_DIR} rev-parse --short=8 HEAD
		OUTPUT_VARIABLE SOL_COMMIT_HASH OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_QUIET
	)
	execute_process(
		COMMAND git --git-dir=${ZOND_SOURCE_DIR}/.git --work-tree=${ZOND_SOURCE_DIR} diff HEAD --shortstat
		OUTPUT_VARIABLE SOL_LOCAL_CHANGES OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_QUIET
	)
endif()

if (SOL_COMMIT_HASH)
	string(STRIP ${SOL_COMMIT_HASH} SOL_COMMIT_HASH)
	string(SUBSTRING ${SOL_COMMIT_HASH} 0 8 SOL_COMMIT_HASH)
endif()

if (NOT SOL_COMMIT_HASH)
	message(FATAL_ERROR "Unable to determine commit hash. Either compile from within git repository or "
		"supply a file called commit_hash.txt")
endif()
if (NOT SOL_COMMIT_HASH MATCHES [a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9])
    message(FATAL_ERROR "Malformed commit hash \"${SOL_COMMIT_HASH}\". It has to consist of exactly 8 hex digits.")
endif()

if (SOL_COMMIT_HASH AND SOL_LOCAL_CHANGES)
	set(SOL_COMMIT_HASH "${SOL_COMMIT_HASH}.mod")
endif()

set(SOL_VERSION_COMMIT "commit.${SOL_COMMIT_HASH}")
set(SOl_VERSION_PLATFORM ZOND_BUILD_PLATFORM)
set(SOL_VERSION_BUILDINFO "commit.${SOL_COMMIT_HASH}.${ZOND_BUILD_PLATFORM}")

set(TMPFILE "${ZOND_DST_DIR}/BuildInfo.h.tmp")
set(OUTFILE "${ZOND_DST_DIR}/BuildInfo.h")

configure_file("${ZOND_BUILDINFO_IN}" "${TMPFILE}")

include("${ZOND_CMAKE_DIR}/EthUtils.cmake")
replace_if_different("${TMPFILE}" "${OUTFILE}" CREATE)

