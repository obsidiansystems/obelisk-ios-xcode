#if !defined(__GHCPLATFORM_H__)
#define __GHCPLATFORM_H__

#define GHC_STAGE (1 + 1)

#define BuildPlatform_TYPE  x86_64_apple_darwin
#define HostPlatform_TYPE   aarch64_apple_ios

#define x86_64_apple_darwin_BUILD  1
#define aarch64_apple_ios_HOST  1

#define x86_64_BUILD_ARCH  1
#define aarch64_HOST_ARCH  1
#define BUILD_ARCH  "x86_64"
#define HOST_ARCH  "aarch64"

#define darwin_BUILD_OS  1
#define ios_HOST_OS  1
#define BUILD_OS  "darwin"
#define HOST_OS  "ios"

#define apple_BUILD_VENDOR  1
#define apple_HOST_VENDOR  1
#define BUILD_VENDOR  "apple"
#define HOST_VENDOR  "apple"


#endif /* __GHCPLATFORM_H__ */
