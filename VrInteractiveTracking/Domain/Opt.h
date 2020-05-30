//
//  Opt.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/18.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuerySpec.h"

/**
 オプトイン・オプトアウト処理クラス
 */
@interface Opt : NSObject

/**
 オプトイン
 
 @return true:オプトイン成功、false:オプトイン失敗
 */
+(BOOL) in;

/**
 オプトアウト
 
 @return true:オプトアウト成功、false:オプトアウト失敗
 */
+(BOOL) out:(QuerySpec*) querySpec beaconQue:(NSMutableArray*) beaconQue;

/**
 オプトアウトチェック
 
 @return optout:True, ≠optout:False
 */
+(BOOL) isOptout;

@end
