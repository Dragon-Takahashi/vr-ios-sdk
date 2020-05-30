//
//  Range.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/14/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 範囲チェッククラス
 */
@interface Range : NSObject

/**
 イニシャライザ

 @param lesser_equal lesser_equal
 @param greater_equal greater_equal
 @return self
 */
- (instancetype)initWithLesserEqual:(NSInteger)lesser_equal greater_equal:(NSInteger)greater_equal;

/**
 範囲チェック

 @param value チェック値
 @return true:範囲内,false:範囲外
 */
- (BOOL)includes:(NSInteger)value;

/**
 文字列返却

 @return 文字列
 */
- (NSString *)toString;

@end
