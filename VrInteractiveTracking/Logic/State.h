//
//  State.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/13/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Stateクラス
 */
@interface State : NSObject

@property (nonatomic, copy) NSString *symbol;

/**
 イニシャライザ

 @param symbol ステータス
 */
- (void)state:(NSString *)symbol;

/**
 実行中の文字列

 @return IN_PROGRESS
 */
+ (NSString *)IN_PROGRESS;

/**
 待機中の文字列

 @return STAND_BY
 */
+ (NSString *)STAND_BY;

@end
