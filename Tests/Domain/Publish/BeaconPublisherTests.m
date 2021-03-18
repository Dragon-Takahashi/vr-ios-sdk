//
//  BeaconPublisherTests.m
//  Tests
//
//  Created by 髙橋和成 on 11/3/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BeaconPublisher.h"

@interface BeaconPublisher (PrivateMethod)
@property (nonatomic) NSMutableArray *sendQueue;
@property (nonatomic) BOOL isRunning;
@end

@interface BeaconPublisherTests : XCTestCase
@end

@implementation BeaconPublisherTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

//@property (nonatomic, copy) BeaconCallback listener;
//@property (nonatomic) SendType *sendType;

- (URI *)normalURI {
    return [[URI alloc] initWithQuerySpec:nil spec:[self emptyQuerySpec] configFile:[self normalConfig] forceValue:[self emptyForceValue] finishBlock:nil];
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
    [dic setObject:@"5" forKey:@"polling_interval"];
    [dic setObject:@"5" forKey:@"config_timeout"];
    [dic setObject:@"5" forKey:@"beacon_timeout"];
    [dic setObject:@"2147483646" forKey:@"expired_time_beacon_log"];
    NSMutableDictionary *beaconDic = [NSMutableDictionary dictionary];
    [beaconDic setObject:@"https://panelstg.interactive-circle.jp/ver01/measure" forKey:@"default"];
    [dic setObject:beaconDic forKey:@"beacon_url"];

    return [[ConfigFile alloc] initWithParams:dic];
}

- (QueryParameters *)emptyForceValue {
    return [QueryParameters new];
}


#pragma mark init
/**
 初期化の正常系テスト
 */
- (void)testInitNormal {
    // 生成
    BeaconPublisher *publisher = [BeaconPublisher new];
    //テスト
    XCTAssertNotNil(publisher.sendType);
    XCTAssertNotNil(publisher.sendQueue);
}

#pragma mark add:(URI *)uri eventName:(NSString *)eventName;
/**
 送信キューへの追加処理の正常系テスト（追加直後に一件は飛ばしてしまうためエラーがなければ問題ない認識）
 */
- (void)testAddNormal {
    // 生成
    BeaconPublisher *publisher = [BeaconPublisher new];
    @try {
        // 追加
        [publisher add:[self normalURI] eventName:@"STAND_BY"];
        //テスト
        XCTAssertTrue(YES);
    }@catch (NSException *e) {
        //テスト
        XCTAssertTrue(NO);
    }
}

#pragma mark publish;

/**
 送信キューの送信処理の正常系テスト
 （外部から叩かれることがない認識なのでprivateにしても良いか確認）
 */
- (void)testPublishNormal {
    // 生成
    BeaconPublisher *publisher = [BeaconPublisher new];
    @try {
        // 追加
        [publisher publish];
        //テスト
        XCTAssertTrue(YES);
    }@catch (NSException *e) {
        //テスト
        XCTAssertTrue(NO);
    }
}

@end
