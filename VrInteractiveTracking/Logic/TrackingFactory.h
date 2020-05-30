//
//  TrackingFactory.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/17/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VrInteractiveTrackingSpec.h"

/**
 TrackingFactoryクラス
 */
@interface TrackingFactory : NSObject

/**
 状態判定
 
 @param spec VrInteractiveTrackingSpec
 @return TrackingStrategy
 */
+ (id)of:(VrInteractiveTrackingSpec *)spec;


/**
 状態更新

 @param strategy 現行のTrackingStrategy
 @param spec VrInteractiveTrackingSpec
 @return TrackingStrategy
 */
+ (id)update:(id)strategy spec:(VrInteractiveTrackingSpec *)spec;

@end
