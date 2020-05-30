//
//  ConfigAcceptor.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/13/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "ConfigAcceptor.h"

@implementation ConfigAcceptor


/**
 イニシャライザ

 @return self
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _stateList = [NSMutableDictionary dictionary];
    }
    return self;
}

/**
 更新状態を返す

 @param identity identity
 @return 更新状態
 */
- (BOOL)isOKWithIdentity:(NSString *)identity {
    [self isCheckedIdentity:identity];
    NSLog(@"symbol=%@ required=%@",[[_stateList objectForKey:identity] symbol], [State STAND_BY]);
    return [[[_stateList objectForKey:identity] symbol] isEqual:[State STAND_BY]];
}

/**
 更新状態を変更

 @param identity identity
 @param state 新しい更新状態
 */
- (void)updateWithIdentity:(NSString *)identity state:(NSString *)state {
    [self isCheckedIdentity:identity];
    [[_stateList objectForKey:identity] state:state];
}

/**
 更新状態の文字列を返す

 @return 更新状態の文字列
 */
- (NSString *)toString {
    NSString *result = @"ConfigFile";
    for (NSString *identity in _stateList) {
        result = [result stringByAppendingFormat:@"\nidentity:%@, state:%@",identity,[[_stateList objectForKey:identity] symbol]];
    }
    
    return result;
}

/**
 identityの存在を確認
 なければ新規でStateクラスを生成

 @param identity identity
 */
- (void)isCheckedIdentity:(NSString *)identity {
    if (![_stateList objectForKey:identity]) {
        [_stateList setObject:[State new] forKey:identity];
    }
}

@end
