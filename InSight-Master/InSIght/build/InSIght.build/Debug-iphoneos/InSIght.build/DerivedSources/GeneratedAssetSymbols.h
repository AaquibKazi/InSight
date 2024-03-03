#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "apple_icon" asset catalog image resource.
static NSString * const ACImageNameAppleIcon AC_SWIFT_PRIVATE = @"apple_icon";

/// The "facebook_icon" asset catalog image resource.
static NSString * const ACImageNameFacebookIcon AC_SWIFT_PRIVATE = @"facebook_icon";

/// The "google_icon" asset catalog image resource.
static NSString * const ACImageNameGoogleIcon AC_SWIFT_PRIVATE = @"google_icon";

/// The "pfp" asset catalog image resource.
static NSString * const ACImageNamePfp AC_SWIFT_PRIVATE = @"pfp";

#undef AC_SWIFT_PRIVATE