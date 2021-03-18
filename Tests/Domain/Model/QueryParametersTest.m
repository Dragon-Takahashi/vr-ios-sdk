//
//  QueryParametersTest.m
//  Tests
//
//  Created by 髙橋和成 on 10/30/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "QueryParameters.h"

@interface QueryParametersTest : XCTestCase

@end

@implementation QueryParametersTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - init

/**
目的：newした際に保持しているQueryParameterが0個であることを確認する
*/
- (void)testInitNormal {
    QueryParameters *params = [QueryParameters new];
    
    // 前提：インスタンス化済み
    // 想定：QueryParameterが0個であることを確認
    XCTAssertTrue([[params getParameters] count] == 0);
}

#pragma mark - add:(NSString*)key value:(NSString*)value

/**
 目的：KeyValueが正常に追加できるかを確認する
 */
- (void)testAddNoarmal {
    QueryParameters *params = [QueryParameters new];
    
    [params add:@"Test key" value:@"Test value"];
    
    // 前提：keyに"Test key"、valueに"Test value"のQueryParameterが入っている
    // 想定：keyが"Test key"のQueryParameterを取得でき、valueが"Test value"であることを確認する
    XCTAssertTrue([[params getValue:@"Test key"].value isEqualToString:@"Test value"]);
}


/**
 目的：Keyがnullの場合でもkey=nullとしてValueを追加できないことを確認する
 */
- (void)testAddIrregularNullKey {
    QueryParameters *params = [QueryParameters new];
    
    [params add:nil value:@"Test value"];
    
    // 前提：keyにnil、valueに"Test value"のQueryParameterが入っている
    // 想定：keyがnilのQueryParameterは取得できないので、存在しないという旨のエラーが吐き出せれることを確認する
    @try {
        NSLog(@"%@",[params getValue:nil].value);
        XCTFail(@"do not throw error.");
    } @catch (NSException *exception) {
        XCTAssertTrue([[exception reason] isEqualToString:@"key is not found : (null)"]);
    }
    
}

/**
 目的：valueがnullの場合でもvalue=nullとしてkeyを追加できるを確認する
 */
- (void)testAddIrregularNullValue {
    QueryParameters *params = [QueryParameters new];
    
    [params add:@"Test key" value:nil];
    
    // 前提：keyに"Test key"、valueにnilのQueryParameterが追加している
    // 想定：valueがnilのため、keyが"Test key"のQueryParameterが取得出来ず、エラーが吐き出されることを確認
    @try {
        NSLog(@"%@",[params getValue:@"Test key"].value);
        XCTFail(@"do not throw error.");
    } @catch (NSException *exception) {
        XCTAssertTrue([[exception reason] isEqualToString:@"key is not found : Test key"]);
    }
}

/**
 目的：Keyが空文字の場合でもkey=""としてValueを追加できることを確認する
 */
- (void)testAddIrregularEmptyKey {
    QueryParameters *params = [QueryParameters new];
    
    [params add:@"" value:@"Test value"];
    
    // 前提：keyに""、valueに"Test value"のQueryParameterが入っている
    // 想定：keyが""のQueryParameterを取得でき、valueが"Test value"であることを確認する
    XCTAssertTrue([[params getValue:@""].value isEqualToString:@"Test value"]);
}

/**
 目的：valueが空文字の場合でもvalue=""としてkeyを追加できることを確認する
 */
- (void)testAddIrregularEmptyValue {
    QueryParameters *params = [QueryParameters new];
    
    [params add:@"Test key" value:@""];
    
    // 前提：keyに"Test key"、valueに""のQueryParameterが入っている
    // 想定：keyが"Test key"のQueryParameterを取得でき、valueが""であることを確認する
    XCTAssertTrue([[params getValue:@"Test key"].value isEqualToString:@""]);
}

/**
 目的：同一Keyに違うValueを設定した場合に正しく上書きされるかを確認する
 */
- (void)testAddOverride {
    QueryParameters *params = [QueryParameters new];
    
    [params add:@"Test key" value:@"Test value1"];
    [params add:@"Test key" value:@"Test value2"];
    
    // 前提：keyが"Test key"にvalueが"Test value2"が上書きされている
    // 想定：keyに"Test key"が入っているQueryParameterのvalueが"Test value2"になっていることを確認
    XCTAssertTrue([[params getValue:@"Test key"].value isEqualToString:@"Test value2"]);
}


#pragma mark - addAll

/**
 目的：key/valueの連想配列で上書きした場合に正しく全ての値が追加されているかを確認する
 */
- (void)testAddAllNormal {
    QueryParameters *params = [QueryParameters new];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"Test value1" forKey:@"Test key1"];
    [dic setObject:@"Test value2" forKey:@"Test key2"];
    
    [params addAll:dic];
    
    // 前提：keyに"Test key1"、valueに"Test value1"のQueryParameterとkeyに"Test key2"、valueに"Test value2"のQueryParameterを追加している
    // 想定：keyが"Test key1"のvalueが"Test value1"になっていることを確認
    XCTAssertTrue([[params getValue:@"Test key1"].value isEqualToString:@"Test value1"]);
    // 想定：keyが"Test key2"のvalueが"Test value2"になっていることを確認
    XCTAssertTrue([[params getValue:@"Test key2"].value isEqualToString:@"Test value2"]);
}


/**
 目的：空のkey/valueの連想配列で上書きした場合にエラーが起きないかをを確認する
 */
- (void)testAddAllIrregulerEmptyDictionary {
    QueryParameters *params = [QueryParameters new];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    @try {
        [params addAll:dic];
        [params getValue:@"Test key"];
        
        XCTFail(@"do not throw error");
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        // 前提：空の辞書をQueryParametersに追加している
        // 想定：空の辞書をQueryParametersに追加してもエラーは起きないが、未登録のキーを参照しているので
        XCTAssertTrue([[exception reason] isEqualToString:@"key is not found : Test key"]);
    }
}

/**
 目的：連続でkey/valueの連想配列を追加した際に、正常に値が反映されているかを確認する
 */
- (void)testAddAllMultiParameter2StraightTimes {
    QueryParameters *params = [QueryParameters new];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setObject:@"Test value1" forKey:@"Test key1"];
    [dic1 setObject:@"Test value2" forKey:@"Test key2"];
    [params addAll:dic1];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setObject:@"Test value3" forKey:@"Test key3"];
    [dic2 setObject:@"Test value4" forKey:@"Test key4"];
    [params addAll:dic2];
    
    // 前提：辞書型で４つのkey/valueを追加している
    // 想定：追加したkey/valueが正しく追加されているかを確認する
    XCTAssertTrue([[params getValue:@"Test key1"].value isEqualToString:@"Test value1"]);
    XCTAssertTrue([[params getValue:@"Test key2"].value isEqualToString:@"Test value2"]);
    XCTAssertTrue([[params getValue:@"Test key3"].value isEqualToString:@"Test value3"]);
    XCTAssertTrue([[params getValue:@"Test key4"].value isEqualToString:@"Test value4"]);
}


/**
 目的：連続で空のkey/valueの連想配列を追加した際に、正常に値が反映されているかを確認する
 */
- (void)testAddAllNoParameter2StraightTimes {
    QueryParameters *params = [QueryParameters new];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    
    @try {
        [params addAll:dic1];
        [params addAll:dic2];
        [params getValue:@"Test key"];
        
        XCTFail(@"do not throw error");
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        // 前提：空の辞書を２種類QueryParametersに追加している
        // 想定：空の辞書をQueryParametersに追加してもエラーは起きないが、未登録のキーを参照しているので
        XCTAssertTrue([[exception reason] isEqualToString:@"key is not found : Test key"]);
    }
}


/**
 目的：連続でkey/valueの連想配列を追加した際に、シーケンシャルが担保されているかを確認する
 */
- (void)testAddAllNormal2StraightTimesSequential {
    QueryParameters *params = [QueryParameters new];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setObject:@"Test value1" forKey:@"Test key1"];
    [dic1 setObject:@"Test value2" forKey:@"Test key2"];
    [params addAll:dic1];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setObject:@"Test value3" forKey:@"Test key3"];
    [dic2 setObject:@"Test value4" forKey:@"Test key4"];
    [params addAll:dic2];
    
    NSArray *list = [params getParameters];
    
    // 前提：辞書型で４つのkey/valueを追加している
    // 想定：追加したkey/valueが順番通りに追加されているかを確認する
    for (int i = 0; i < [list count]; i++) {
        NSString *valueName = [NSString stringWithFormat:@"Test value%d",i+1];
        XCTAssertTrue([[(QueryParameter *)list[i] value] isEqualToString:valueName]);
    }
}

/**
 目的：key/valueの連想配列で上書きした際に、正常に値が反映されているかを確認する
 */
- (void)testAddAllOverrideMultiParameter {
    QueryParameters *params = [QueryParameters new];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setObject:@"Test value1" forKey:@"Test key1"];
    [dic1 setObject:@"Test value2" forKey:@"Test key2"];
    [params addAll:dic1];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setObject:@"Test value3" forKey:@"Test key1"];
    [dic2 setObject:@"Test value4" forKey:@"Test key2"];
    [params addAll:dic2];
    
    // 前提：key="Test key1"とkey="Test key2"において辞書型で上書きしている
    // 想定：dic2で追加した方の値がvalueに入っていることを確認
    XCTAssertTrue([[params getValue:@"Test key1"].value isEqualToString:@"Test value3"]);
    XCTAssertTrue([[params getValue:@"Test key2"].value isEqualToString:@"Test value4"]);
}



#pragma mark - clear

/**
 目的：追加したQueryParameterが正しく全て削除出来ているかを確認する
 */
- (void)testClear {
    QueryParameters *params = [QueryParameters new];
    [params add:@"Test key1" value:@"Test value"];
    [params add:@"Test key2" value:@"Test value"];
    
    [params clear];
    
    @try {
        [params getValue:@"Test key1"];
        
        XCTFail(@"do not throw error");
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        // 前提：QueryParameterを全てに削除している
        // 想定：key"Test key1"は存在しないので、エラーが吐き出されるかを確認
        XCTAssertTrue([[exception reason] isEqualToString:@"key is not found : Test key1"]);
    }
    
    @try {
        [params getValue:@"Test key2"];
        
        XCTFail(@"do not throw error");
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        // 前提：QueryParameterを全てに削除している
        // 想定：key"Test key2"は存在しないので、エラーが吐き出されるかを確認
        XCTAssertTrue([[exception reason] isEqualToString:@"key is not found : Test key2"]);
    }
}

/**
 目的：連続で削除を行った場合でも、正しくエラーが起きず全て削除出来ているかを確認する
 */
- (void)testClear2StraightTimes {
    QueryParameters *params = [QueryParameters new];
    [params add:@"Test key1" value:@"Test value"];
    [params add:@"Test key2" value:@"Test value"];
    
    @try {
        [params clear];
        [params clear];
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        // 前提：QueryParameterの削除を２回連続で行っている
        // 想定：clearメソッドは連続で何回叩かれても問題ないはずなので、ここではエラーは発生しないかを確認
        XCTFail(@"%@", [exception reason]);
    }
    
    @try {
        [params getValue:@"Test key1"];
        
        XCTFail(@"do not throw error");
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        XCTAssertTrue([[exception reason] isEqualToString:@"key is not found : Test key1"]);
    }
    
    @try {
        [params getValue:@"Test key2"];
        
        XCTFail(@"do not throw error");
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        XCTAssertTrue([[exception reason] isEqualToString:@"key is not found : Test key2"]);
    }
}




#pragma mark - getParamters

/**
 目的：取得したQueryParametersの項目の一つを更新した際に、正しく値が上書きされるかを確認する
 */
- (void)testGetParametersOverride {
    QueryParameters *params = [QueryParameters new];
    
    [params add:@"Test key" value:@"Test value1"];
    
    NSMutableArray *array = [params getParameters];
    QueryParameter *param = array[0];
    [param setValue:@"Test value2"];
    
    // 前提：key"Test key"のvalueを"Test value2"で上書きしている
    // 想定：valueが"Test value2"になっていることを確認
    XCTAssertTrue([[params getValue:@"Test key"].value isEqualToString:@"Test value2"]);
}



#pragma mark - getValue

/**
 目的：取得したQueryParameterのkeyを上書き出来ることを確認する
 */
- (void)testGetValueOverrideKey {
    QueryParameters *params = [QueryParameters new];
    
    [params add:@"Test key1" value:@"Test value"];
    [params getValue:@"Test key1"].key = @"Test key2";
    
    // 前提：key"Test key1"のkeyを"Test key2"に変更している
    // 想定：key"Test key2"に値"Test value"が入っていることを確認
    XCTAssertTrue([[params getValue:@"Test key2"].value isEqualToString:@"Test value"]);
    // 想定：key"Test key1"が存在しないことを確認
    @try {
        [params getValue:@"Test key1"];
        XCTFail(@"do not throw error");
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
        XCTAssertTrue([[exception reason] isEqualToString:@"key is not found : Test key1"]);
    }
}

/**
 目的：取得したQueryParameterのvalueを上書き出来ることを確認する
 */
- (void)testGetValueOverrideValue {
    QueryParameters *params = [QueryParameters new];
    
    [params add:@"Test key" value:@"Test value1"];
    [params getValue:@"Test key"].value = @"Test value2";
    
    // 前提：key"Test key"のvalueを"Test key2"に変更している
    // 想定：key"Test key"に値"Test value2"が入っていることを確認
    XCTAssertTrue([[params getValue:@"Test key"].value isEqualToString:@"Test value2"]);
}


@end
