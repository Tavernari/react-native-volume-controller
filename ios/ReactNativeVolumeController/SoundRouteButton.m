//
//  SoundRouteButton.m
//  ReactNativeVolumeController
//
//  Created by Victor Carvalho Tavernari on 01/05/17.
//  Copyright © 2017 Tavernari. All rights reserved.
//

#import "SoundRouteButton.h"
#import <React/RCTViewManager.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation SoundRouteButton

RCT_EXPORT_MODULE()

- (UIView *)view
{
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    [volumeView sizeToFit];
    [volumeView setShowsVolumeSlider:false];
    [volumeView setShowsRouteButton:true];
    return volumeView;
}

@end
