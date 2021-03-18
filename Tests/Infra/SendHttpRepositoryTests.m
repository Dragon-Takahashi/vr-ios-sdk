//
//  SendHttpRepositoryTests.m
//  Tests
//
//  Created by 髙橋和成 on 10/23/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SendHttpRepository.h"
#import "EventIdentity.h"

@interface SendHttpRepositoryTests : XCTestCase
@property (nonatomic) NSString *wrongURL;
@property (nonatomic) NSString *rightURL;
@property (nonatomic) int numOfRunningAsyncTest;
@property (nonatomic) NSTimeInterval timeoutSec;
@property (nonatomic) NSTimeInterval monitorInterval;
@property (nonatomic) NSDate *startDate;
@end

@implementation SendHttpRepositoryTests

- (void)setUp {
    [super setUp];
    _wrongURL = @"https://www.e-agency.co.jp/takahashi.html";
    _rightURL = @"https://panelstg.interactive-circle.jp/ver01/measure";
    self.numOfRunningAsyncTest = 0;
}

- (void)tearDown {
    [super tearDown];
}

// 通信成功時のコールバックテスト
- (void)testRightSendCallback {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    @try {
        // BeaconEvent生成
        URI *uri = [[URI alloc] initWithQuerySpec:_rightURL spec:[self emptyQuerySpec] configFile:[self normalConfig] forceValue:[self emptyForceValue] finishBlock:^(BOOL result) {
            NSLog(@"testRightSendCallback callback");
            
            // コールバックテスト
            XCTAssertTrue(result);
            
        }];
        BeaconEvent *beaconEvent = [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:uri eventName:@"RUNNING"];
        
        // 呼び出し
        [SendHttpRepository send:beaconEvent callback:^(NSString *url) {
            dispatch_semaphore_signal(sem);
        }];
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        dispatch_semaphore_signal(sem);
        XCTFail(@"%@", [exception reason]);
    }
    
    dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 15);
    if (dispatch_semaphore_wait(sem, timeout)) {
        dispatch_semaphore_signal(sem);
        XCTFail(@"Timeout");
    }
}

// 通信成功時のコールバックテスト
- (void)testRightSendCallbackDirect {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    @try {
        // BeaconEvent生成
        URI *uri = [[URI alloc] initWithDirectURL:_rightURL configFile:[self normalConfig] finishBlock:nil];
        BeaconEvent *beaconEvent = [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:uri eventName:@"RUNNING"];
        
        // Callback生成
        BeaconCallback callback = ^(NSString *url) {
            NSLog(@"testRightSendCallback callback");
            XCTAssertTrue([url isEqualToString:_rightURL]);
            
            // 待機条件の解除
            dispatch_semaphore_signal(sem);
            
        };
        
        // 呼び出し
        [SendHttpRepository send:beaconEvent callback:callback];
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        dispatch_semaphore_signal(sem);
        XCTFail(@"%@", [exception reason]);
    }

    dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 15);
    if (dispatch_semaphore_wait(sem, timeout)) {
        dispatch_semaphore_signal(sem);
        XCTFail(@"Timeout");
    }
}

// 通信成功時の通信結果テスト
- (void)testRightSendResponse {
//    // BeaconEvent生成
//    URI *uri = [[URI alloc] initWithDirectURL:_rightURL];
//    BeaconEvent *beaconEvent = [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:uri eventName:@"RUNNING"];
//
//    // Callback生成
//    BeaconCallback callback = ^(NSString *url) {};
//
//    // 呼び出し
//    [SendHttpRepository send:beaconEvent callback:callback];
//
//    // 返り値テスト
//    XCTAssertTrue([[[response getStatus] getStatus] isEqualToString:@"200"]);
}

// 通信失敗時のコールバックテスト
- (void)testWrongSendCallback {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    @try {
        // BeaconEvent生成
        URI *uri = [[URI alloc] initWithQuerySpec:_wrongURL spec:[self emptyQuerySpec] configFile:[self normalConfig] forceValue:[self emptyForceValue] finishBlock:^(BOOL result) {
            NSLog(@"testRightSendCallback callback");
            
            // コールバックテスト
            XCTAssertFalse(result);
            
        }];
        BeaconEvent *beaconEvent = [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:uri eventName:@"RUNNING"];
        
        // 呼び出し
        [SendHttpRepository send:beaconEvent callback:^(NSString *url) {
            dispatch_semaphore_signal(sem);
        }];
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        dispatch_semaphore_signal(sem);
        XCTFail(@"%@", [exception reason]);
    }
    
    dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 15);
    if (dispatch_semaphore_wait(sem, timeout)) {
        dispatch_semaphore_signal(sem);
        XCTFail(@"Timeout");
    }
}

// 通信失敗時のコールバックテスト
- (void)testWrongSendCallbackDirect {
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    @try {
        // BeaconEvent生成
        URI *uri = [[URI alloc] initWithDirectURL:_wrongURL configFile:[self normalConfig] finishBlock:nil];
        BeaconEvent *beaconEvent = [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:uri eventName:@"RUNNING"];
        
        // Callback生成
        BeaconCallback callback = ^(NSString *url) {
            XCTAssertTrue([url isEqualToString:_wrongURL]);
            
            dispatch_semaphore_signal(sem);
        };
        
        // 呼び出し
        [SendHttpRepository send:beaconEvent callback:callback];
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        dispatch_semaphore_signal(sem);
        XCTFail(@"%@", [exception reason]);
    }
    
    dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 15);
    if (dispatch_semaphore_wait(sem, timeout)) {
        dispatch_semaphore_signal(sem);
        XCTFail(@"Timeout");
    }
}

// 通信失敗時の通信結果テスト
- (void)testWrongSendResponse {
    // BeaconEvent生成
    URI *uri = [[URI alloc] initWithDirectURL:_wrongURL configFile:[self normalConfig] finishBlock:nil];
    BeaconEvent *beaconEvent = [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:uri eventName:@"RUNNING"];
    
    // Callback生成
    BeaconCallback callback = ^(NSString *url) {};
    
    // 呼び出し
    [SendHttpRepository send:beaconEvent callback:callback];
    
    // 返り値テスト
//    XCTAssertFalse([[[response getStatus] getStatus] isEqualToString:@"200"]);
}






- (QuerySpec *)emptyQuerySpec {
    return [QuerySpec new];
}
- (ConfigFile *)normalConfig {
    // 設定ファイルの内容を定義
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"0000" forKey:@"vr_tagid1"];
    [dic setObject:@"1111" forKey:@"vr_tagid2"];
    [dic setObject:@"100000" forKey:@"max_que_recs"];
    [dic setObject:@"http://vr-support.data-analytics.jp/log_test/008/vrTrackingConfig_test.xml" forKey:@"config_url"];
    [dic setObject:@"true" forKey:@"debug_log"];
    [dic setObject:@"false" forKey:@"disabled"];
    [dic setObject:@"false" forKey:@"polling"];
    [dic setObject:@"false" forKey:@"polling_start"];
    [dic setObject:@"4" forKey:@"polling_interval"];
    [dic setObject:@"5" forKey:@"config_timeout"];
    [dic setObject:@"6" forKey:@"beacon_timeout"];
    [dic setObject:@"2147483646" forKey:@"expired_time_beacon_log"];
    NSMutableDictionary *beaconDic = [NSMutableDictionary dictionary];
    [beaconDic setObject:@"https://panelstg.interactive-circle.jp/ver01/measure" forKey:@"default"];
    [dic setObject:beaconDic forKey:@"beacon_url"];
    
    return [[ConfigFile alloc] initWithParams:dic];
}

- (QueryParameters *)emptyForceValue {
    return [QueryParameters new];
}


@end
