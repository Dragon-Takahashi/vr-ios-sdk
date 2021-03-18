//
//  OldTableRepositoryImpTests.m
//  Tests
//
//  Created by 髙橋和成 on 10/23/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OldTableRepositoryImpl.h"

@interface OldTableRepositoryImpTests : XCTestCase

@end

@implementation OldTableRepositoryImpTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// 初回起動時のテスト
- (void)testDropFirstTime {
    // フラグを立て直す
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"flg_delete_encrypteddb_2018"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // テーブル削除
    [OldTableRepositoryImpl drop];
    
    // テーブル確認
    XCTAssertFalse([OldTableRepositoryImpl hasDBForTest]);
}

// ２回目以降の起動時のフラグテスト
- (void)testDropFlagOtherTime {
    // フラグチェック
    XCTAssertTrue([[NSUserDefaults standardUserDefaults] boolForKey:@"flg_delete_encrypteddb_2018"]);
}

// ２回目以降の起動時のテスト
- (void)testDropOtherTime {
    // テーブル削除
    [OldTableRepositoryImpl drop];
    
    // テーブル確認
    XCTAssertFalse([OldTableRepositoryImpl hasDBForTest]);
}

@end
