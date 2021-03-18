//
//  Range.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/14/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "Range.h"

@interface Range()
@property (nonatomic) NSInteger lesser_equal;
@property (nonatomic) NSInteger greater_equal;
@end

@implementation Range

/**
 イニシャライザ
 通常はこのメソッドは使用しない

 @return self
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**
 イニシャライザ

 @param lesser_equal 指定する範囲の下限（ex:1 -> 1~）
 @param greater_equal 指定する範囲の上限（ex:10 -> ~10）
 @return self
 */
- (instancetype)initWithLesserEqual:(NSInteger)lesser_equal greater_equal:(NSInteger)greater_equal
{
    self = [super init];
    if (self) {
        _lesser_equal = lesser_equal;
        _greater_equal = greater_equal;
    }
    return self;
}

/**
 指定された範囲に入っているかを判断
 使用例：lesser_equal = 1, greater_equal = 10 の場合
 引数：
 0 = NO
 1 = YES
 10 = YES
 11 = NO
 
 @param value 判断される数字
 @return 結果（YES = 範囲内, NO = 範囲外）
 */
- (BOOL)includes:(NSInteger)value {
    return _lesser_equal<=value && value<=_greater_equal;
}

/**
 文字列を返す
 形式：lesser equal[下限],greater equal[上限]

 @return 下限と上限の文字列
 */
- (NSString *)toString {
    return [NSString stringWithFormat:@"lesser equal[%ld],greater equal[%ld]", (long)_lesser_equal, (long)_greater_equal];
}


@end
