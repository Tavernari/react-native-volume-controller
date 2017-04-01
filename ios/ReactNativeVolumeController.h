#import "RCTBridgeModule.h"

@interface ReactNativeAudioStreaming : NSObject <RCTBridgeModule>

- (void)change:(float) volumeValue;
