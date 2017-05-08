//
//  ReactNativeVolumeController.m
//  ReactNativeVolumeController
//
//  Created by Victor C Tavernari on 01/04/17.
//  Copyright © 2017 Tavernari. All rights reserved.
//

#import "ReactNativeVolumeController.h"

#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation ReactNativeVolumeController{
    BOOL initialized;
    MPVolumeView* volumeView;
    UISlider* slider;
    UIButton* airplayButton;
    NSNotificationCenter *center;
    BOOL isAirplayEnable;
}

@synthesize bridge = _bridge;

-(id) init{
    self = [super init];
    if (self) {
        
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


-(UIView *) view{
    volumeView = [[MPVolumeView alloc] init];
    [volumeView sizeToFit];
    [volumeView setShowsVolumeSlider:false];
    [volumeView setShowsRouteButton:true];
    
    for (UIView *view in [volumeView subviews]){
        if ([view isKindOfClass:[UISlider class]]){
            slider = (UISlider*)view;
            slider.continuous = NO;
            float outputVolume = [AVAudioSession sharedInstance].outputVolume;
            [slider setValue:outputVolume animated:NO];
            break;
        }
        
        if ([view isKindOfClass:[UIButton class]]){
            airplayButton = (UIButton*)view;
            break;
        }
    }
    return volumeView;
}



@end
