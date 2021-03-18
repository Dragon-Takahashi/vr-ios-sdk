//
//  OldTableRepositoryImpl.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/21.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "OldTableRepositoryImpl.h"

#import "../HouseKeeper/HouseKeeper.h"
#import "../Domain/UUID.h"
#import <CommonCrypto/CommonDigest.h>
#import "../Domain/VRIException.h"

@implementation OldTableRepositoryImpl

+ (void)drop {
    NSLog(@"drop");
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"flg_delete_encrypteddb_2018"]) {
        // 旧SDKのDB削除
        [self deleteDB];
        
        // フラグを下ろす
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"flg_delete_encrypteddb_2018"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

/**
 * 旧SDKのDBを削除
 *
 */
+ (void) deleteDB {
    
    @try {
        // Phase1,2対応
        NSURL *storeURLPhase1 = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"vr_interactive_tracking.db"];
        NSError *errorPhase1 = nil;
        BOOL retPhase1 = [[NSFileManager defaultManager] removeItemAtPath:[storeURLPhase1 path] error:&errorPhase1];
        NSLog(@"Remove DB File Path:%@ %@:", storeURLPhase1, retPhase1 ? @"成功" : @"失敗");
        
        // 旧SDKで使用したDBファイルを削除する
        NSString *dbFileName = [NSString stringWithFormat:@"%@.db", [self sha512:[UUID load]]];
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:dbFileName];
        NSError *error = nil;
        BOOL ret = [[NSFileManager defaultManager] removeItemAtPath:[storeURL path] error:&error];
        NSLog(@"Remove DB File Path:%@ %@:", storeURL, ret ? @"成功" : @"失敗");
        dbFileName = [NSString stringWithFormat:@"%@.db-shm", [self sha512:[UUID load]]];
        storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:dbFileName];
        error = nil;
        ret = [[NSFileManager defaultManager] removeItemAtPath:[storeURL path] error:&error];
        NSLog(@"Remove DB-shm File Path:%@ %@:", storeURL, ret ? @"成功" : @"失敗");
        dbFileName = [NSString stringWithFormat:@"%@.db-wal", [self sha512:[UUID load]]];
        storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:dbFileName];
        error = nil;
        ret = [[NSFileManager defaultManager] removeItemAtPath:[storeURL path] error:&error];
        NSLog(@"Remove DB-wal File Path:%@ %@:", storeURL, ret ? @"成功" : @"失敗");
    } @catch (NSException *exception) {
        @throw [VRIException exceptionWithMessage:[exception reason]];
    }

}

/**
 * ファイルパスを作成
 */
+ (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
}

/**
 * SHA512ハッシュ化
 */
+ (NSString *) sha512:(NSString *) input {
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_LONG length = (CC_LONG)data.length;
    
    CC_SHA512(data.bytes, length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    //    NSLog(@"SHA512 : %@", output);
    return output;
}

/**
 * DB確認用（削除予定）
 */
+ (BOOL) hasDBForTest {
    NSString *dbFileName = [NSString stringWithFormat:@"%@.db", [self sha512:[UUID load]]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:dbFileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]]) {
        NSLog(@"DB is exist");
        return YES;
    }else {
        NSLog(@"DB is not exist");
        return NO;
    }
    
}

@end
