//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_background_service_ios/FlutterBackgroundServicePlugin.h>)
#import <flutter_background_service_ios/FlutterBackgroundServicePlugin.h>
#else
@import flutter_background_service_ios;
#endif

#if __has_include(<geolocator_apple/GeolocatorPlugin.h>)
#import <geolocator_apple/GeolocatorPlugin.h>
#else
@import geolocator_apple;
#endif

#if __has_include(<location/LocationPlugin.h>)
#import <location/LocationPlugin.h>
#else
@import location;
#endif

#if __has_include(<path_provider_foundation/PathProviderPlugin.h>)
#import <path_provider_foundation/PathProviderPlugin.h>
#else
@import path_provider_foundation;
#endif

#if __has_include(<sqflite/SqflitePlugin.h>)
#import <sqflite/SqflitePlugin.h>
#else
@import sqflite;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterBackgroundServicePlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterBackgroundServicePlugin"]];
  [GeolocatorPlugin registerWithRegistrar:[registry registrarForPlugin:@"GeolocatorPlugin"]];
  [LocationPlugin registerWithRegistrar:[registry registrarForPlugin:@"LocationPlugin"]];
  [PathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"PathProviderPlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
}

@end
