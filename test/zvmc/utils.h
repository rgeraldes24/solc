// ZVMC: Ethereum Client-VM Connector API.
// Copyright 2018 The ZVMC Authors.
// Licensed under the Apache License, Version 2.0.

#pragma once

/**
 * @file
 * A collection of helper macros to handle some non-portable features of C/C++ compilers.
 *
 * @addtogroup helpers
 * @{
 */

/**
 * @def ZVMC_EXPORT
 * Marks a function to be exported from a shared library.
 */
#if defined _MSC_VER || defined __MINGW32__
#define ZVMC_EXPORT __declspec(dllexport)
#else
#define ZVMC_EXPORT __attribute__((visibility("default")))
#endif

/**
 * @def ZVMC_NOEXCEPT
 * Safe way of marking a function with `noexcept` C++ specifier.
 */
#ifdef __cplusplus
#define ZVMC_NOEXCEPT noexcept
#else
#define ZVMC_NOEXCEPT
#endif

/** @} */
