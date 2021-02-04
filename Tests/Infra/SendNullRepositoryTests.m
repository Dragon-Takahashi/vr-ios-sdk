//
//  SendNullRepositoryTests.m
//  Tests
//
//  Created by 髙橋和成 on 10/23/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SendNullRepository.h"
#import "EventIdentity.h"

@interface SendNullRepositoryTests : XCTestCase

@end

@implementation SendNullRepositoryTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
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
    [beaconDic setObject:@"https://test.com/takahashi.gif" forKey:@"default"];
    [dic setObject:beaconDic forKey:@"beacon_url"];
    
    return [[ConfigFile alloc] initWithParams:dic];
}


// コールバックテスト
- (void)testSendCallback {
    // BeaconEvent生成
    URI *uri = [[URI alloc] initWithQuerySpec:nil spec:[self emptyQuerySpec] configFile:[self normalConfig] finishBlock:nil];
    BeaconEvent *beaconEvent = [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:uri eventName:@"RUNNING"];
    
    // Callback生成
    BeaconCallback callback = ^(NSString *url) {
        XCTAssertTrue([url hasPrefix:@"https://test.com/takahashi.gif"]);
    };
    
    // 呼び出し
    [SendNullRepository send:beaconEvent callback:callback];
}

// 通信結果テスト
- (void)testSendNilResponse {
    // BeaconEvent生成
    URI *uri = [URI new];
    BeaconEvent *beaconEvent = [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:uri eventName:@"RUNNING"];
    
    // Callback生成
    BeaconCallback callback = ^(NSString *url) {};
    
    // 呼び出し
    Response *response = [SendNullRepository send:beaconEvent callback:callback];
    
    // 返り値テスト
    XCTAssertNil([response getStatus]);
}

@end
