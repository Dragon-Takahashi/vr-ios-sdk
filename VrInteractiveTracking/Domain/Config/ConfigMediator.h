//
//  ConfigMediator.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/29/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FinishLoadBlock) (BOOL result);

/**
 設定ファイルのコールバック格納クラス
 */
@interface ConfigMediator : NSObject

/**
 コールバック追加

 @param identity Identity
 @param finishBlock コールバック
 */
- (void)addBlock:(NSString *)identity finishBlock:(FinishLoadBlock)finishBlock;

/**
 コールバック

 @param identity Identity
 @param result result
 */
- (void)callback:(NSString *)identity result:(BOOL)result;

/**
 コールバック判断

 @param identity Identity
 @return true:コールバックあり false:コールバックなし
 */
- (BOOL)isLoaded:(NSString *)identity;

@end
