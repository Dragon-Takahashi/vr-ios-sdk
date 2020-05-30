//
//  UUID+refresh.m
//  Tests
//
//  Created by 髙橋和成 on 11/3/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "UUID+refresh.h"

NSString *const UUID_KEY_NAME = @"vr_interactive_tracking_uuid";

@implementation UUID (refresh)

/**
 * 既存の保存値を削除
 * ※注 テスト用
 *
 */
+ (BOOL) forceClearForTest {
    // 既存のUUIDを削除
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults] ;
    [ud removeObjectForKey:UUID_KEY_NAME];
    [ud synchronize];
    
    if ([ud synchronize]) {
        return YES;
    }else {
        return NO;
    }
}

@end
