//
//  ReactNativeVolumeController.m
//  ReactNativeVolumeController
//
//  Created by Victor C Tavernari on 01/04/17.
//  Copyright © 2017 Tavernari. All rights reserved.
//

#import "RCTBridgeModule.h"
#import "ReactNativeVolumeController.h"

@import AVFoundation;
@import MediaPlayer;

@implementation ReactNativeAudioStreaming

RCT_EXPORT_MODULE()

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

@end
