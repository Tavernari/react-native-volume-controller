//
//  ReactNativeVolumeController.h
//  ReactNativeVolumeController
//
//  Created by Victor C Tavernari on 01/04/17.
//  Copyright © 2017 Tavernari. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>
#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface ReactNativeVolumeController : RCTViewManager <RCTBridgeModule>

- (void)change:(float) volumeValue;
- (void)update;
@end
