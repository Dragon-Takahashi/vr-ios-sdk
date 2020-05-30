//
//  ConfigLoadBlock.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/29/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FinishLoadBlock) (BOOL result);

/**
 設定ファイルのコールバック管理クラス
 */
@interface ConfigLoadBlock : NSObject
@property (nonatomic, copy) NSString *identity;
@property (nonatomic, copy) FinishLoadBlock finishBlock;

/**
 イニシャライザ

 @param identity Identity
 @param finishBlock コールバック
 @return self
 */
- (instancetype)initWithIdentity:(NSString *)identity finishBlock:(FinishLoadBlock)finishBlock;

/**
 コールバック

 @param result result
 */
- (void)callback:(BOOL)result;

@end
