//
//  ConfigFile.m
//  Tests
//
//  Created by 髙橋和成 on 10/31/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "../../../VrInteractiveTracking/Domain/Config/ConfigFile.h"

@interface ConfigFileTests : XCTestCase

@end

@implementation ConfigFileTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}



#pragma mark - init

/**
 目的：初期化が正常に行われることを確認する
 */
- (void)testInitNormal {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"tagid1" forKey:@"vr_tagid1"];
    [dic setObject:@"tagid2" forKey:@"vr_tagid2"];
    [dic setObject:@"1111" forKey:@"max_que_recs"];
    [dic setObject:@"http://config-url" forKey:@"config_url"];
    [dic setObject:@"true" forKey:@"debug_log"];
    [dic setObject:@"true" forKey:@"disabled"];
    [dic setObject:@"false" forKey:@"polling"];
    [dic setObject:@"false" forKey:@"polling_start"];
    [dic setObject:@"2222" forKey:@"polling_interval"];
    [dic setObject:@"3333" forKey:@"config_timeout"];
    [dic setObject:@"4444" forKey:@"beacon_timeout"];
    [dic setObject:@"2147483646" forKey:@"expired_time_beacon_log"];
    NSMutableDictionary *beaconDic = [NSMutableDictionary dictionary];
    [beaconDic setObject:@"https://beacon-url" forKey:@"default"];
    [dic setObject:beaconDic forKey:@"beacon_url"];
    ConfigFile *config = [[ConfigFile alloc] initWithParams:dic];
    
    // 前提：想定している正常な設定ファイルを読み込む
    // 想定：設定値が全て正確に入っているかをを確認
    XCTAssertTrue([config.getVr_TagId1 isEqualToString:@"tagid1"]);
    XCTAssertTrue([config.getVr_TagId2 isEqualToString:@"tagid2"]);
    XCTAssertTrue([config.getConfig_Url isEqualToString:@"http://config-url"]);
    XCTAssertTrue(config.getDisabled == true);
    XCTAssertTrue([config.getConfig_timeout isEqualToString:@"3333"]);
    XCTAssertTrue([config.getBeacon_timeout isEqualToString:@"4444"]);
    XCTAssertTrue([config.getBeacon_url isEqualToString:@"https://beacon-url"]);
}

/**
 目的：初期化時にnilが入っていた場合でも初期化が行われることを確認する
 */
- (void)testInitIrregularNull {
    // 生成
    ConfigFile *config = [[ConfigFile alloc] initWithParams:nil];
    
    // 前提：想定していないNULLを読み込む
    // 想定：書きが入っているかを確認
    //      DebugLog = false
    //      Disabled = true
    //      それ以外　= null
    XCTAssertNil(config.getVr_TagId1);
    XCTAssertNil(config.getVr_TagId2);
    XCTAssertNil(config.getConfig_Url);
    XCTAssertTrue([config getDisabled]);
    XCTAssertNil(config.getConfig_timeout);
    XCTAssertNil(config.getBeacon_timeout);
    XCTAssertNil(config.getBeacon_url);
}

/**
 目的：初期化時にnewした場合でも初期化が行われることを確認する
 */
- (void)testInitNew {
    ConfigFile *config = [ConfigFile new];
    
    // 前提：想定していないNULLを読み込む
    // 想定：書きが入っているかを確認
    //      DebugLog = false
    //      Disabled = true
    //      それ以外　= null
    XCTAssertNil(config.getVr_TagId1);
    XCTAssertNil(config.getVr_TagId2);
    XCTAssertNil(config.getConfig_Url);
    XCTAssertTrue([config getDisabled]);
    XCTAssertNil(config.getConfig_timeout);
    XCTAssertNil(config.getBeacon_timeout);
    XCTAssertNil(config.getBeacon_url);
}

/**
 目的：true/falseの文字列に大文字が混じっていても、初期化が正常に行われることを確認する
 */
- (void)testInitNormalUpperCase {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"tagid1" forKey:@"vr_tagid1"];
    [dic setObject:@"tagid2" forKey:@"vr_tagid2"];
    [dic setObject:@"1111" forKey:@"max_que_recs"];
    [dic setObject:@"http://config-url" forKey:@"config_url"];
    [dic setObject:@"TrUe" forKey:@"debug_log"];
    [dic setObject:@"FaLSe" forKey:@"disabled"];
    [dic setObject:@"false" forKey:@"polling"];
    [dic setObject:@"false" forKey:@"polling_start"];
    [dic setObject:@"2222" forKey:@"polling_interval"];
    [dic setObject:@"3333" forKey:@"config_timeout"];
    [dic setObject:@"4444" forKey:@"beacon_timeout"];
    [dic setObject:@"2147483646" forKey:@"expired_time_beacon_log"];
    NSMutableDictionary *beaconDic = [NSMutableDictionary dictionary];
    [beaconDic setObject:@"https://beacon-url" forKey:@"default"];
    [dic setObject:beaconDic forKey:@"beacon_url"];
    ConfigFile *config = [[ConfigFile alloc] initWithParams:dic];
    
    // 前提：true/falseの文字列に大文字が混じっていてる設定ファイルを読み込む
    // 想定：設定値が全て正確に入っているかをを確認
    XCTAssertTrue([config.getVr_TagId1 isEqualToString:@"tagid1"]);
    XCTAssertTrue([config.getVr_TagId2 isEqualToString:@"tagid2"]);
    XCTAssertTrue([config.getConfig_Url isEqualToString:@"http://config-url"]);
    XCTAssertTrue(config.getDisabled == false);
    XCTAssertTrue([config.getConfig_timeout isEqualToString:@"3333"]);
    XCTAssertTrue([config.getBeacon_timeout isEqualToString:@"4444"]);
    XCTAssertTrue([config.getBeacon_url isEqualToString:@"https://beacon-url"]);
}

/**
 目的：true/falseの文字列がYES/NOで入っていた場合でも、初期化が正常に行われることを確認する
 ただし、「DebugLog」「Disabled」のみ適用
 */
- (void)testInitNormalYesNo {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"tagid1" forKey:@"vr_tagid1"];
    [dic setObject:@"tagid2" forKey:@"vr_tagid2"];
    [dic setObject:@"http://config-url" forKey:@"config_url"];
    [dic setObject:@NO forKey:@"disabled"];
    [dic setObject:@"3333" forKey:@"config_timeout"];
    [dic setObject:@"4444" forKey:@"beacon_timeout"];
    NSMutableDictionary *beaconDic = [NSMutableDictionary dictionary];
    [beaconDic setObject:@"https://beacon-url" forKey:@"default"];
    [dic setObject:beaconDic forKey:@"beacon_url"];
    ConfigFile *config = [[ConfigFile alloc] initWithParams:dic];
    
    // 前提：true/falseの文字列がYES/NOで入っている設定ファイルを読み込む
    // 想定：設定値が全て正確に入っているかをを確認
    XCTAssertTrue([config.getVr_TagId1 isEqualToString:@"tagid1"]);
    XCTAssertTrue([config.getVr_TagId2 isEqualToString:@"tagid2"]);
    XCTAssertTrue([config.getConfig_Url isEqualToString:@"http://config-url"]);
    XCTAssertTrue(config.getDisabled == false);
    XCTAssertTrue([config.getConfig_timeout isEqualToString:@"3333"]);
    XCTAssertTrue([config.getBeacon_timeout isEqualToString:@"4444"]);
    XCTAssertTrue([config.getBeacon_url isEqualToString:@"https://beacon-url"]);
}

/**
 目的：true/falseの文字列に違う文字が入っていた場合でも、初期化が正常に行われることを確認する
 ただし、「DebugLog」「Disabled」のみ適用
 */
- (void)testInitNormalOtherWord {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"tagid1" forKey:@"vr_tagid1"];
    [dic setObject:@"tagid2" forKey:@"vr_tagid2"];
    [dic setObject:@"http://config-url" forKey:@"config_url"];
    [dic setObject:@"ノー" forKey:@"disabled"];
    [dic setObject:@"3333" forKey:@"config_timeout"];
    [dic setObject:@"4444" forKey:@"beacon_timeout"];
    NSMutableDictionary *beaconDic = [NSMutableDictionary dictionary];
    [beaconDic setObject:@"https://beacon-url" forKey:@"default"];
    [dic setObject:beaconDic forKey:@"beacon_url"];
    ConfigFile *config = [[ConfigFile alloc] initWithParams:dic];
    
    // 前提：true/falseの文字列がYES/NOで入っている設定ファイルを読み込む
    // 想定：設定値が全て正確に入っているかをを確認
    XCTAssertTrue([config.getVr_TagId1 isEqualToString:@"tagid1"]);
    XCTAssertTrue([config.getVr_TagId2 isEqualToString:@"tagid2"]);
    XCTAssertTrue([config.getConfig_Url isEqualToString:@"http://config-url"]);
    XCTAssertTrue(config.getDisabled == false);
    XCTAssertTrue([config.getConfig_timeout isEqualToString:@"3333"]);
    XCTAssertTrue([config.getBeacon_timeout isEqualToString:@"4444"]);
    XCTAssertTrue([config.getBeacon_url isEqualToString:@"https://beacon-url"]);
}



#pragma mark - getElements

/**
 目的：セットした設定ファイルとConfigFileから取得した設定ファイルが同値であることを確認する
 */
- (void)testGetElementsNormal {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"tagid1" forKey:@"vr_tagid1"];
    [dic setObject:@"tagid2" forKey:@"vr_tagid2"];
    [dic setObject:@"http://config-url" forKey:@"config_url"];
    [dic setObject:@"true" forKey:@"disabled"];
    [dic setObject:@"3333" forKey:@"config_timeout"];
    [dic setObject:@"4444" forKey:@"beacon_timeout"];
    NSMutableDictionary *beaconDic = [NSMutableDictionary dictionary];
    [beaconDic setObject:@"https://beacon-url" forKey:@"default"];
    [dic setObject:beaconDic forKey:@"beacon_url"];
    ConfigFile *config = [[ConfigFile alloc] initWithParams:dic];
    
    // 前提：想定している正常な設定ファイルを読み込み、それを取り出す
    // 想定：セットした設定ファイルとConfigFileから取得した設定ファイルが同値であることを確認
    XCTAssertTrue(dic == config.getElements);
}

/**
 目的：nilをセットした場合には空の配列を取得することを確認する
 */
- (void)testGetElementsIrregularInitNull {
    ConfigFile *config = [[ConfigFile alloc] initWithParams:nil];
    
    // 前提：nilを引数に初期化しているため、空の配列を生成している
    // 想定：空の配列を取得することを確認
    XCTAssertTrue([config.getElements count] == 0);
}

/**
 目的：Disabledの値が正確にセットされているかを確認する
 */
- (void)testSetDisabled{
    ConfigFile *config = [ConfigFile new];
    
    // 前提：disabledにtrueをセットしている
    // 想定：disabledにtrueが入っていることを確認
    [config setDisabled:YES];
    XCTAssertTrue(config.getDisabled == true);
    
    // 前提：disabledにfalseをセットしている
    // 想定：disabledにfalseが入っていることを確認
    [config setDisabled:NO];
    XCTAssertTrue(config.getDisabled == false);
    
}

@end
