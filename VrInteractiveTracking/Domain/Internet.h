//
//  Internet.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/17/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 通信状態判定クラス
 */
@interface Internet : NSObject

/**
 接続確認

 @return true:接続可能 false:接続不可能
 */
+ (BOOL)isOnline;

@end
