//
//  Counter.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/18/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 カウンタークラス
 */
@interface Counter : NSObject
@property (readonly, getter=getValue) long long value;

/**
 カウント増加
 */
- (void)increment;

/**
 カウント減少
 */
- (void)decrement;
@end
