//
//  ReactNativeVolumeController.h
//  ReactNativeVolumeController
//
//  Created by Victor C Tavernari on 01/04/17.
//  Copyright © 2017 Tavernari. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface ReactNativeVolumeController : NSObject <RCTBridgeModule>

- (void)change:(float) volumeValue;
- (void)update;

@end
