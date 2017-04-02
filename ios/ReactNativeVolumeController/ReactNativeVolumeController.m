//
//  ReactNativeVolumeController.m
//  ReactNativeVolumeController
//
//  Created by Victor C Tavernari on 01/04/17.
//  Copyright © 2017 Tavernari. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>
#import "ReactNativeVolumeController.h"

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation ReactNativeVolumeController{
    BOOL initialized;
    MPVolumeView* volumeView;
    UISlider* slider;
}

@synthesize bridge = _bridge;

-(id) init{
    self = [super init];
    if (self) {
        CGRect frame = CGRectMake(20, -100, 10, 10);
        volumeView = [[MPVolumeView alloc] initWithFrame:frame];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIView *topView = window.rootViewController.view;
        [topView addSubview:volumeView];
        [volumeView sizeToFit];
        [volumeView setShowsVolumeSlider:true];
        [volumeView setShowsRouteButton:true];
        volumeView.hidden = true;
        [volumeView setAlpha:0.0];
        
        for (UIView *view in [volumeView subviews]){
            if ([view isKindOfClass:[UISlider class]]){
                slider = (UISlider*)view;
                slider.continuous = NO;
                float outputVolume = [AVAudioSession sharedInstance].outputVolume;
                [slider setValue:outputVolume animated:NO];
                break;
            }
        }
        
        [[AVAudioSession sharedInstance] addObserver:self forKeyPath:@"outputVolume" options:0 context:nil];

    }
    return self;
}

- (void)removeVolumeChangeObserver
{
    @try
    {
        [[AVAudioSession sharedInstance] removeObserver:self forKeyPath:@"outputVolume"];
    }
    
    @catch(id anException)
    {
        
    }
}

- (void)sendEventWithNewVolume
{
    [self.bridge.eventDispatcher sendDeviceEventWithName:@"VolumeControllerValueUpdatedEvent"
                                                    body:@{@"volume":
                                                               [NSNumber numberWithFloat:[[AVAudioSession sharedInstance] outputVolume]]
                                                           }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"outputVolume"])
    {
        [self sendEventWithNewVolume];
    }
}


RCT_EXPORT_MODULE()

#pragma mark - Pubic API

RCT_EXPORT_METHOD(change:(float) volumeValue)
{
    [slider setValue:volumeValue animated:NO];
    [slider sendActionsForControlEvents:UIControlEventTouchUpInside];
}

RCT_EXPORT_METHOD(update)
{
    [self change:[[AVAudioSession sharedInstance] outputVolume]];
    [self sendEventWithNewVolume];
}



@end
