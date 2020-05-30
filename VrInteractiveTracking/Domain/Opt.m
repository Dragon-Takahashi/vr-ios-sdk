//
//  Opt.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/18.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "Opt.h"

#import "UUID.h"


NSString *const OPT_OUT_NAME = @"optout";

@implementation Opt

/**
 * オプトイン（新しいUUIDを付与）
 * オプトアウトの場合はNOを返す
 *
 * @return 結果 (YES = 成功, NO = 失敗)
 */
+ (BOOL) in {
    @synchronized(self) {
        // UUIDが「optout」以外ならNOを返す
        if (![self isOptout]) {
            return NO;
        }
        
        // 新しいUUIDを生成
        [UUID replace];
        
        // 値が正しくセットできているかを判断
        if (![self isOptout]) {
            return YES;
        }else {
            return NO;
        }
    }
}

/**
 * オプトアウト（UUIDの値をオプトアウト値に変更）
 * 設定した送信パラメーターは全てクリア
 *
 * @param querySpec インスタンス化されたQuerySpecオブジェクト（オプト値をクリアするために使用）
 *
 * @return 結果 (YES = 成功, NO = 失敗)
 */
+ (BOOL) out:(QuerySpec*) querySpec beaconQue:(NSMutableArray*) beaconQue {
    
    @synchronized(self) {
        // UUIDが「optout」ならNOを返す
        if ([self isOptout]) {
            return NO;
        }
        
        // UUIDの保存領域を「optout」で上書きする
        [UUID update:OPT_OUT_NAME];
        
        // 値が合っているかを判断
        if ([self isOptout]) {
            return YES;
        }else {
            return NO;
        }
    }
}


/**
 * オプトアウト状況を返す
 *
 * @return オプトアウト状況
 */
+ (BOOL) isOptout {
    @synchronized(self) {
        // 値が「optout」かどうかを判断
        NSString *uuid = [UUID load];
        if (uuid == nil) {
            [UUID save];
            uuid = [UUID load];
        }
        if ([uuid isEqualToString:OPT_OUT_NAME]) {
            return YES;
        }else {
            return NO;
        }
    }
}

@end
