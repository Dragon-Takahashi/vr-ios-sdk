//
//  Identity.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/05.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 イベントIdentityクラス
 */
@interface EventIdentity : NSObject

@property(nonatomic, readonly, getter=getEventIdentity) NSString* eventIdentity;

@end
