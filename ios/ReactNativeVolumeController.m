#import "RCTBridgeModule.h"
#import "RCTEventDispatcher.h"

#import "ReactNativeVolumeController.h"

@import AVFoundation;
@import MediaPlayer;

@implementation ReactNativeAudioStreaming

RCT_EXPORT_MODULE()
- (dispatch_queue_t)methodQueue
{
   return dispatch_get_main_queue();
}

#pragma mark - Pubic API

RCT_EXPORT_METHOD(change:(float) volumeValue)
{
  MPVolumeView* volumeView = [[MPVolumeView alloc] init];

  //find the volumeSlider
  UISlider* volumeViewSlider = nil;
  for (UIView *view in [volumeView subviews]){
      if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
          volumeViewSlider = (UISlider*)view;
          break;
      }
  }

  [volumeViewSlider setValue:volumeValue animated:YES];
  [volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
  [volumeView autorelease];
}
