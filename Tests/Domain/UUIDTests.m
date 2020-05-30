//
//  UUIDTests.m
//  Tests
//
//  Created by 髙橋和成 on 10/23/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "UUID+refresh.h"

@interface UUIDTests : XCTestCase

@end

@implementation UUIDTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

//
///**
// 目的：UUIDが存在しない際に、UUIDを取得するとnilが帰ってくることを確認する
// */
//- (void)testLoadNormalNull {
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [UUID forceClearForTest];
//    });
//    sleep(3);
//    
//    NSLog(@"testLoadNormalNull %@",[UUID load]);
//    
//    // 前提：初期化しているのでUUIDが存在しない
//    // 想定：UUIDが存在しないので、nilが返ってくることを確認
//    XCTAssertTrue([UUID load] == nil);
//}

/**
 目的：正しくUUIDが保存できているかを確認する
 */
- (void)testLoadNoramlNotNullAfterSave {
    // UUIDを初期化
    [UUID forceClearForTest];
    [UUID save];
    
    // 前提：UUIDを設定している
    // 想定：UUIDがnilではないことを確認
    XCTAssertNotNil([UUID load]);
}


/**
 目的：複数回呼ばれても同じUUIDを返すことを確認する
 */
- (void)testMultiLoadUUID {
    [UUID forceClearForTest];
    [UUID save];
    
    NSString *uuid1 = [UUID load];
    
    // 前提：UUIDを設定している
    // 想定：uuid1と新しく取得したUUIDが同じ値であることを確認する
    XCTAssertTrue([uuid1 isEqualToString:[UUID load]]);
}


/**
 目的：複数回saveを叩かれてもnil以外だったら更新しないことをを確認する
 */
- (void)testSaveMulti {
    [UUID forceClearForTest];
    
    [UUID save];
    NSString *uuid1 = [UUID load];
    
    [UUID save];
    
    // 前提：２回saveを叩かれている
    // 想定：更新されないので、同じ値が入っているかを確認する
    XCTAssertTrue([uuid1 isEqualToString:[UUID load]]);
}

/**
 目的：一度インスタンスとして取り出したUUIDと、新しく取り出したUUIDが別のインスタンスが別物であることを確認する
 */
- (void)testReplaceUUIDNormalMultiDifferentInstance {
    [UUID forceClearForTest];
    NSString *uuid1 = [UUID load];
    
    [UUID update:@"test"];
    
    // 前提：UUIDを初期化して、"test"という値で上書きしている
    // 想定：uuid1と、新しく取り出したUUIDが別のインスタンスが別物であることを確認
    XCTAssertNotEqual(uuid1, [UUID load]);
}


/**
 目的：値を正常に上書きできた際に、戻り値がtrueになっていることを確認する
 */
- (void)testReplaceUUIDNormalReturn {
    [UUID forceClearForTest];
    
    // 前提：UUIDを初期化して、"This_is_test"という値で上書きしている
    // 想定：戻り値がtrueになっていることを確認
    XCTAssertTrue([UUID update:@"This_is_test"]);
}

/**
 目的：別の値を上書きしても、問題なく上書きできているかを確認する
 */
- (void)testReplaceUUIDNormal {
    [UUID forceClearForTest];
    [UUID update:@"This_is_test"];
    
    // 前提：UUIDを初期化して、"This_is_test"という値で上書きしている
    // 想定：UUIDが"This_is_test"に変わっていることを確認
    XCTAssertTrue([[UUID load] isEqualToString:@"This_is_test"]);
}

/**
 目的：複数ので取得しても、同じインスタンスとして取得できているかを確認する
 */
- (void)testGetUUIDNormalMultiInstance {
    [UUID forceClearForTest];
    [UUID save];
    
    // 前提：UUIDを初期化している
    // 想定：同じインスタンスであることを確認
    XCTAssertEqual([UUID load], [UUID load]);
}

/**
 目的：複数ので取得しても、違うインスタンスとして取得できているかを確認する
 */
- (void)testGetUUIDNormalMultiInstanceSameValue {
    [UUID forceClearForTest];
    [UUID save];
    
    // 前提：UUIDを初期化している
    // 想定：別のインスタンスでも同じ値であることを確認
    XCTAssertTrue([[UUID load] isEqualToString:[UUID load]]);
}

/**
 目的：複数ので取得しても、違うインスタンスとして取得できているかを確認する
 */
- (void)testGetUUIDNormalNullMultiInstance {
    [UUID forceClearForTest];
    
    // 前提：UUIDを初期化している
    // 想定：同じインスタンスなので同じくnilであることを確認
    XCTAssertTrue([UUID load] == [UUID load]);
}

/**
 目的：複数ので取得しても、違うインスタンスとして取得できているかを確認する
 */
- (void)testGetUUIDNormalNullMultiInstanceSameValue {
    [UUID save];
    
    NSLog(@"%@",[UUID load]);
    
    // 前提：UUIDを初期化している
    // 想定：nilなので同じであることを確認
    XCTAssertTrue([[UUID load] isEqualToString:[UUID load]]);
}

/**
 目的；nilで上書きした場合に上書きをせず、元の値を保持しているかを確認する
 */
- (void)testReplaceUUIDIrregularNull {
    [UUID forceClearForTest];
    
    NSString *uuid = [UUID load];
    
    // 前提：UUIDを初期化して、nilで上書きしようとしている
    // 想定：エラーが吐き出され、UUIDが変わっていないことを確認
    XCTAssertThrows([UUID update:nil], @"uid is null");
    XCTAssertEqual(uuid, [UUID load]);
}

/**
 目的；空文字で上書きした場合に上書きをせず、元の値を保持しているかを確認する
 */
- (void)testReplaceUUIDIrregularEmpty {
    [UUID forceClearForTest];
    
    [UUID update:@""];
    // 前提：UUIDを初期化して、空文字で上書きしようとしている
    // 想定：UUIDが空文字になっていることを確認
    XCTAssertTrue([[UUID load] isEqualToString:@""]);
}

@end
