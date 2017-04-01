#import "RCTBridgeModule.h"
#import <UIKit/UIKit.h>

//! Project version number for ReactNativeVolumeController.
FOUNDATION_EXPORT double ReactNativeVolumeControllerVersionNumber;

//! Project version string for ReactNativeVolumeController.
FOUNDATION_EXPORT const unsigned char ReactNativeVolumeControllerVersionString[];

@interface ReactNativeAudioStreaming : NSObject <RCTBridgeModule>

- (void)change:(float) volumeValue;
