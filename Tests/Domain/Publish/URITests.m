//
//  URITests.m
//  Tests
//
//  Created by 髙橋和成 on 11/3/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "URI.h"
#import "UUID.h"
#import "QueryParameters.h"

//#import "../../../VrInteractiveTracking/Domain/Publish/URI.h"
//#import "../../../VrInteractiveTracking/Domain/UUID.h"
//#import "../../../VrInteractiveTracking/Domain/Model/QueryParameters.h"

@interface URI (Private)
- (NSString*) getBaseURL;
- (NSString*) getQuery;
@end

@interface URITests : XCTestCase

@end

@implementation URITests

- (void)setUp {
    [super setUp];
    // UUIDを固定
    [UUID update:@"TestUUID"];
}

- (void)tearDown {
    [super tearDown];
}

- (NSString *)directURL {
    return @"https://panelstg.interactive-circle.jp/ver01/measure?test1=value1";
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



#pragma mark initWithQuerySpec:(QuerySpec*) spec configFile:(ConfigFile*) configFile forceValue:(NSMutableDictionary *)forceValue

/**
 初期化の正常系テスト
 */
- (void)testInitWithQuerySpecNormal {
    // 生成
    URI *uri = [[URI alloc] initWithQuerySpec:nil spec:[self emptyQuerySpec] configFile:[self normalConfig] finishBlock:nil];
    // テスト
    XCTAssertNotNil(uri);
}

#pragma mark getQuery

/**
 クエリ取得の正常系テスト
 */
- (void)testGetQueryNormal {
    // テスト用にパラメータを設定
    QuerySpec *spec = [self emptyQuerySpec];
    [[spec getQueryParameters] add:@"test_key1" value:@"test_value1"];
    // 生成
    URI *uri = [[URI alloc] initWithQuerySpec:nil spec:spec configFile:[self normalConfig] finishBlock:nil];
    // テスト
    NSLog(@"%@", [uri getQuery]);
    XCTAssertTrue([[uri getQuery] containsString:@"test_key1=test_value1"]);
}

/**
 直接URLを入れる方法による初期化の正常系テスト
 （※呼ばれない）
 */
- (void)testGetQueryDirectNormal {
}

#pragma mark getDisabled
// TODO ConfigFileクラスにも追加予定
/**
 無効化フラグの正常系テスト
 */
- (void)testGetDisabledNormal  {
    // 生成
    URI *uri = [[URI alloc] initWithQuerySpec:nil spec:[self emptyQuerySpec] configFile:[self normalConfig] finishBlock:nil];
    // テスト（設定ファイルの定義値はFalse）
    XCTAssertFalse([uri getDisabled]);
}

#pragma mark setConfigFile:(ConfigFile *)configFile

/**
 設定ファイルリストを設定する正常系テスト
 */
- (void)testSetConfigFileNormal  {
    // 生成
    URI *uri = [[URI alloc] initWithQuerySpec:nil spec:[self emptyQuerySpec] configFile:[self normalConfig] finishBlock:nil];
    // 上書きする値を設定
    ConfigFile *config = [self normalConfig];
    [config setDisabled:YES];
    // 上書き
    [uri setConfigFile:config];
    // テスト
    XCTAssertTrue([uri getDisabled]);
}

#pragma mark toURI
/**
 URLを取得する正常系テスト
 */
- (void)testToURINormal  {
    // 生成
    URI *uri = [[URI alloc] initWithQuerySpec:nil spec:[self emptyQuerySpec] configFile:[self normalConfig] finishBlock:nil];
    // テスト
    NSLog(@"Result URL = %@", [uri toURI]);
    XCTAssertTrue([[[uri toURI] absoluteString] containsString:@"https://panelstg.interactive-circle.jp/ver01/measure?"]);
    XCTAssertTrue([[[uri toURI] absoluteString] containsString:@"vr_tagid1=0000"]);
    XCTAssertTrue([[[uri toURI] absoluteString] containsString:@"vr_tagid2=1111"]);
    XCTAssertTrue([[[uri toURI] absoluteString] containsString:@"id1=TestUUID"]);
}

#pragma mark getBeaconTimeout
/**
 ビーコンのタイムアウトを取得する正常系テスト
 */
- (void)testGetTimeoutNormal  {
    // 生成
    URI *uri = [[URI alloc] initWithQuerySpec:nil spec:[self emptyQuerySpec] configFile:[self normalConfig] finishBlock:nil];
    // テスト
    XCTAssertTrue([[uri getBeaconTimeout] isEqualToString:@"6"]);
}

@end
