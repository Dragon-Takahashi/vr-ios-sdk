//
//  UUID.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/18.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "UUID.h"

#import "Opt.h"
#import "VRIException.h"

NSString *const UUID_KEY_NAME = @"vr_interactive_tracking_uuid";

@implementation UUID

/**
 * UUIDを保存
 *
 * @return 結果 (YES = 成功, NO = 失敗)
 */
+ (BOOL) save{
    @synchronized (self) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if([self load] == nil) {
            NSString *uuid = [self createUUID];
            [ud setObject:uuid forKey:UUID_KEY_NAME];
            return [ud synchronize];
        }
        return NO;
    }
}

/**
 * UUIDを新規生成
 *
 * @params uuid 任意のUUIDを設定(nullable) 初回生成時には適用されません
 *
 * @return 結果 (YES = 成功, NO = 失敗)
 */
+ (BOOL) update:(NSString*) uuid  {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults] ;
    NSString *oldValue = [ud stringForKey:UUID_KEY_NAME];
    if (uuid == nil) {
        @throw [VRIException exceptionWithMessage:@"uid is null"];
        return NO;
    }else {
        [ud setObject:uuid forKey:UUID_KEY_NAME];
    }
    BOOL result = [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"Update UUID Result : %@", result?@"YES":@"NO");
    NSLog(@"Update UUID : %@ to %@", oldValue, uuid);
    return result;
}

/**
 * UUIDを新規生成
 *
 * @return 結果 (YES = 成功, NO = 失敗)
 */
+ (BOOL) replace  {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults] ;
    if ([[self load] length] != 0) {
        NSString *oldValue = [self load];
        [ud setObject:[self createUUID] forKey:UUID_KEY_NAME];
        BOOL result = [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"Update UUID Result : %@", result?@"YES":@"NO");
        NSLog(@"Update UUID : %@ to %@", oldValue, [ud stringForKey:UUID_KEY_NAME]);
        
        return result;
    }
    return NO;
}



/**
 *  UUIDを返却する．
 *  UUIDが設定されていない場合、新しく生成して返却する．
 *
 *  @return UUID
 */
+ (NSString*) load {
    @synchronized (self) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        return [ud stringForKey:UUID_KEY_NAME];
    }
}



/**
 * UUIDを発行
 *
 * return UUID
 */
+ (NSString *) createUUID {
    // UUIDを発行
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuid =(__bridge_transfer NSString*)CFUUIDCreateString(nil,uuidObj);
    CFRelease(uuidObj);
    NSLog(@"生成されたUUID = %@",uuid);
    return uuid;
}

@end
