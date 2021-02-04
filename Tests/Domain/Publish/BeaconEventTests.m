//
//  BeaconEventTests.m
//  Tests
//
//  Created by 髙橋和成 on 11/3/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BeaconEvent.h"
//#import "../../../VrInteractiveTracking/Domain/Model/QuerySpec.h"

@interface BeaconEventTests : XCTestCase
@property (nonatomic, readwrite) NSString *RUNNING;
@property (nonatomic, readwrite) NSString *STAND_BY;
@property (nonatomic) URI *uri;
@end

@implementation BeaconEventTests

- (void)setUp {
    [super setUp];
    _STAND_BY = @"STAND_BY";
    _RUNNING = @"RUNNING";
    NSMutableDictionary *dic = [@{@"disabled":@"false",
                                 @"beacon_timeout":@"15"}
                                mutableCopy];

    _uri = [[URI alloc] initWithQuerySpec:nil spec:[self emptyQuerySpec] configFile:[self normalConfig] finishBlock:nil];
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
    [beaconDic setObject:@"https://www.e-agency.co.jp/" forKey:@"default"];
    [dic setObject:beaconDic forKey:@"beacon_url"];
    
    return [[ConfigFile alloc] initWithParams:dic];
}

#pragma mark initWithParam:(EventIdentity*) eventId uri:(URI*) uri eventName:(NSString *)eventName


/**
 初期化の正常値テスト
 */
- (void)testInitNormal {
    // 生成
    BeaconEvent *event = [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:_uri eventName:_RUNNING];
    
    // テスト
    XCTAssertNotNil(event);
}


#pragma mark getEventIdentity

/**
 識別子取得の正常値テスト
 */
- (void)testGetEventIdentityNormal {
    // 生成
    EventIdentity *eventId = [EventIdentity new];
    BeaconEvent *event = [[BeaconEvent alloc] initWithParam:eventId uri:_uri eventName:_RUNNING];
    
    // テスト
    XCTAssertTrue([[eventId getEventIdentity] isEqualToString:[event getEventIdentity]]);
}

#pragma mark occurredOn

/**
 初期化時間の正常値テスト
 */
- (void)testOccurredOnNormal {
    // 生成
    BeaconEvent *event = [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:_uri eventName:_RUNNING];
    
    // テスト
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *time = [formatter stringFromDate:event.date];
    XCTAssertNotNil(time);
}

#pragma mark getURI

/**
 初期化の正常値テスト（URIはDirectを採用）
 */
- (void)testGetURINormal {
    // 生成
    BeaconEvent *event = [[BeaconEvent alloc] initWithParam:[EventIdentity new] uri:_uri eventName:_RUNNING];
    
    // テスト
    XCTAssertTrue([[[[event getURI] toURI] absoluteString] hasPrefix:@"https://www.e-agency.co.jp/"]);
}

@end
