//
//  BeaconProviderTests.m
//  Tests
//
//  Created by 髙橋和成 on 11/4/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BeaconProvider.h"

@interface BeaconProvider (Private)
@property (nonatomic) BeaconPublisher *beaconPublisher;
@property (nonatomic, weak) ConfigFileProvider *configFileProvider;
@property (nonatomic, copy) QuerySpec *querySpec;
@property (nonatomic) NSMutableArray *queue;
@end

@interface ConfigFileProvider (Private)
@property (nonatomic) NSMutableDictionary *configFileList;
@property (nonatomic) NSMutableArray *configQue;
@property (nonatomic) BOOL isRunning;
@end

@interface BeaconProviderTests : XCTestCase
//@property (nonatomic) ConfigFileProvider *configFileProvider;
@end

@implementation BeaconProviderTests

- (void)setUp {
    [super setUp];
//    _configFileProvider = [ConfigFileProvider new];
//    _configFileProvider.configFileList = [NSMutableDictionary dictionary];
//    _configFileProvider.configStatusList = [NSMutableDictionary dictionary];
//    _configFileProvider.configQue = [NSMutableArray array];
//    _configFileProvider.isRunning = NO;
//    [_configFileProvider setConfig:[[self normalConfig] getElements]];
}

- (void)tearDown {
    [super tearDown];
}

- (QuerySpec *)emptyQuerySpec {
    return [QuerySpec new];
}
//- (ConfigFileProvider *)normalConfigFileProvider {
//    return _configFileProvider;
//}
- (ConfigFile *)normalConfig {
    // 設定ファイルの内容を定義
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"test_default" forKey:@"identity"];
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
//- (void)setConfigStatusWithIdentity:(NSString *)identity status:(BOOL) isRunning {
//    NSString *status;
//    if (isRunning) {
//        status = @"YES";
//    }else {
//        status = @"NO";
//    }
//    [_configFileProvider.configStatusList setObject:status forKey:identity];
//}
- (NSString *)directURL {
    return @"https://panelstg.interactive-circle.jp/ver01/measure?test_key1=test_value1";
}


/**
 初期化の正常系テスト
 */
- (void)testInitNormal {
    BeaconProvider *provider = [BeaconProvider new];
    
    XCTAssertNotNil([provider queue]);
    XCTAssertNotNil([provider beaconPublisher]);
}


#pragma mark addWithQuerySpec:(QuerySpec *)spec configFile:(ConfigFile *)config forceValue:(NSMutableDictionary *)forceValue

/**
 Addの正常系テスト（設定ファイル設定終了時）
 */
- (void)testAddWithQuerySpecRunningNormal {
    // 初期化
//    BeaconProvider *provider = [[BeaconProvider alloc] initWithConfigFileProvider:[self normalConfigFileProvider]];
    BeaconProvider *provider = [BeaconProvider new];
    
    // 更新状態の変更
//    [self setConfigStatusWithIdentity:@"default" status:YES];
    
    // キューを追加
    [provider addWithQuerySpec:nil spec:[self emptyQuerySpec] configFile:[self normalConfig] forceValue:[self emptyForceValue] state:YES finishBlock:^(BOOL result) {
//        XCTAssertTrue(result);
    }];
    
    // TODO 引数にコールバックを入れる予定なので、そのコールバックから送信完了の通知をテスト予定
    
}

/**
 Addの正常系テスト（設定ファイル設定時）
 */
- (void)testAddWithQuerySpecStandByNormal {
    // 初期化
//    BeaconProvider *provider = [[BeaconProvider alloc] initWithConfigFileProvider:[self normalConfigFileProvider]];
    BeaconProvider *provider = [BeaconProvider new];
    
    // 更新状態の変更
//    [self setConfigStatusWithIdentity:@"test_default" status:YES];
    
    // キューを追加
    [provider addWithQuerySpec:nil spec:[self emptyQuerySpec] configFile:[self normalConfig] forceValue:[self emptyForceValue] state:NO finishBlock:nil];
    
    XCTAssertTrue([provider.queue count] == 1);
    
}

#pragma mark addDirect:(NSString*) directUrl

/**
 Addの正常系テスト（設定ファイル設定終了時）
 */
- (void)testAddDirectRunningNormal {
    // 初期化
//    BeaconProvider *provider = [[BeaconProvider alloc] initWithConfigFileProvider:[self normalConfigFileProvider]];
    BeaconProvider *provider = [BeaconProvider new];
    
    // 更新状態の変更
//    [self setConfigStatusWithIdentity:@"test_default" status:NO];
    
    // キューを追加
    [provider addDirect:[self directURL] configFile:[self normalConfig] state:true finishBlock:^(BOOL result) {
        // 正しく送信されたことを確認
        XCTAssertTrue(result);
    }];
    
    
}

/**
 Addの正常系テスト（設定ファイル設定時）
 */
- (void)testAddDirectStandByNormal {
    // 初期化
//    BeaconProvider *provider = [[BeaconProvider alloc] initWithConfigFileProvider:[self normalConfigFileProvider]];
    BeaconProvider *provider = [BeaconProvider new];
    
    // 更新状態の変更
//    [self setConfigStatusWithIdentity:@"test_default" status:YES];
    
    // キューを追加
    [provider addWithQuerySpec:nil spec:[self emptyQuerySpec] configFile:[self normalConfig] forceValue:[self emptyForceValue] state:NO finishBlock:nil];
    
    // Queueが１つあることを確認
    XCTAssertTrue([provider.queue count] == 1);
    
}

#pragma mark sendQueue:(ConfigFile *)configFile
/**
 Queueの送信処理の正常系テスト（QueueCountが1以上の場合）
 */
- (void)testSendQueueNoDataNormal {
    // 初期化
//    BeaconProvider *provider = [[BeaconProvider alloc] initWithConfigFileProvider:[self normalConfigFileProvider]];
    BeaconProvider *provider = [BeaconProvider new];
    
    // 更新状態の変更
//    [self setConfigStatusWithIdentity:@"test_default" status:NO];
    
    // キューを追加
    [provider addWithQuerySpec:nil spec:[self emptyQuerySpec] configFile:[self normalConfig] forceValue:[self emptyForceValue] state:NO finishBlock:^(BOOL result) {
        // コールバックでテスト
//        XCTAssertTrue(result);
    }];
    
    // 送信（エラーが起きないことを確認）
    [provider sendQueue:[self normalConfig]];
    
    
}

/**
 Queueの送信処理の正常系テスト（QueueCountが1以上の場合）
 */
- (void)testSendQueueOneDataNormal {
    // 初期化
//    BeaconProvider *provider = [[BeaconProvider alloc] initWithConfigFileProvider:[self normalConfigFileProvider]];
    BeaconProvider *provider = [BeaconProvider new];
    
    // 更新状態の変更
//    [self setConfigStatusWithIdentity:@"test_default" status:YES];
    
    // キューを追加
    ConfigFile *config = [self normalConfig];
    NSLog(@"addqueue config = %@", [config getIdentity]);
    [provider addWithQuerySpec:nil spec:[self emptyQuerySpec] configFile:config forceValue:[self emptyForceValue] state:NO finishBlock:nil];
    
    // Queueが１つあることを確認
    XCTAssertTrue([provider.queue count] == 1);
    
    // 更新状態の変更
//    [self setConfigStatusWithIdentity:@"test_default" status:NO];
    // 送信
    [provider sendQueue:[self normalConfig]];
    
    // Queueが０になっていることを確認
    XCTAssertTrue([provider.queue count] == 0);
    
}


#pragma mark pop:(URI *)uri

/**
 popの正常系テスト（）
 このメソッドは外部から叩かれることがないのでprivateで問題ないか確認
 */
- (void)testPopNoDataNormal {
    // 初期化
//    BeaconProvider *provider = [[BeaconProvider alloc] initWithConfigFileProvider:[self normalConfigFileProvider]];
    BeaconProvider *provider = [BeaconProvider new];
    
    // URI生成（ダイレクトURLを使用）
    URI *uri = [[URI alloc] initWithDirectURL:[self directURL] configFile:[self normalConfig] finishBlock:^(BOOL result) {
        // 正しく送信されたことを確認
//        XCTAssertTrue(result);
    }];
    
    // 送信
    [provider pop:uri];
    
    
}


#pragma mark getBeaconQue
/**
 新SDKではbeaconlogCountがなくなったので使用しないかと思いますが、要確認。
 */



@end
