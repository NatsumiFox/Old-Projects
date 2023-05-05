#if !defined(INCLUDE_LIB_COMPAT_H)
#define INCLUDE_LIB_COMPAT_H

///////////////////////////////////////////////////////////////////////////////
// target OS standardization
///////////////////////////////////////////////////////////////////////////////

#if defined(_WIN32) || defined(_WIN64) || defined(__CYGWIN__)
#define WIN
#elif defined(unix) || defined(__unix__) || defined(__unix)
#define LINUX
#elif defined(__APPLE__) || defined(__MACH__)
#define MACOS
#endif

///////////////////////////////////////////////////////////////////////////////
// CPU architecture standardization
///////////////////////////////////////////////////////////////////////////////

#if defined(__i386__) || defined(_M_X86)
#define X86
#elif defined(__x86_64__) || defined(_M_X64)
#define X64
#elif defined(__aarch64__) || defined(_M_ARM64)
#define ARM64
#endif

///////////////////////////////////////////////////////////////////////////////
// Endianness standardization
///////////////////////////////////////////////////////////////////////////////

#if (defined(__BYTE_ORDER__) && defined(__ORDER_BIG_ENDIAN__) && (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)) || \
    (defined(BYTE_ORDER) && defined(BIG_ENDIAN) && (BYTE_ORDER == BIG_ENDIAN))
#define ENDIANNESS 0

#elif (defined(__BYTE_ORDER__) && defined(__ORDER_LITTLE_ENDIAN__) && (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)) || \
    (defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && (BYTE_ORDER == LITTLE_ENDIAN))
#define ENDIANNESS 1

#else
#define ENDIANNESS 2
#endif

///////////////////////////////////////////////////////////////////////////////
// c_noreturn attribute
///////////////////////////////////////////////////////////////////////////////

#if defined(__STDC__) && __STDC_VERSION__ >= 201112l
// If compiling under C11 or newer, use standard C keyword
#define c_noreturn _Noreturn

#elif defined(__cplusplus) && __cplusplus >= 201103l
// Otherwise, if compiling under C++11 or newer, use standard C++ attribute
#define c_noreturn [[noreturn]]

#elif defined(_MSC_VER)
// Otherwise, if compiling under Microsoft C compiler, use Microsoft attribute
// syntax
#define c_noreturn __declspec(noreturn)

#elif defined(__GNUC__) || defined(__clang__)
// Otherwise, if compiling under GCC or Clang, use GNU attribute syntax
#define c_noreturn __attribute__((noreturn))

#else
// Otherwise, ignore noreturn hint altogether
#define c_noreturn

#endif

///////////////////////////////////////////////////////////////////////////////
// c_inline attribute
///////////////////////////////////////////////////////////////////////////////

#if defined(__cplusplus)
// If compiling under C++, use `inline` keyword as usual
#define c_inline inline

#else
// If compiling under C, use `static inline` keyword; `inline` doesn't do
// what one would expect
#define c_inline static inline

#endif

#endif // INCLUDE_LIB_COMPAT_H
