//
//  QueryParameters.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/02.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "QueryParameters.h"

#import "../VRIException.h"

@implementation QueryParameters


- (instancetype)init
{
    self = [super init];
    if (self) {
        _params = [NSMutableArray array];
    }
    return self;
}

/**
 * 単一のパラメーターを設定
 *
 * @param key キー
 * @param value 値
 *
 * @return 結果（YES = 成功, NO = 失敗）
 */
- (BOOL) add:(NSString*)key value:(NSString*)value{
    
    if (!key || !value) {
        NSLog(@"add key or value is empty : key = %@ value = %@", key, value);
        return NO;
    }
    
    // 値の重複チェック
    BOOL isNewItem = YES;
    for (QueryParameter *param in _params) {
        if ([param.key isEqualToString:key]) {
            isNewItem = NO;
        }
    }
    
    if (isNewItem) {
        QueryParameter *qp = [[QueryParameter alloc] initWithParameter:key value:value];
        [_params addObject:qp];
        NSLog(@"値を新規追加 key=%@",key);
    }else {
        QueryParameter *qp = [self getValue:key];
        [qp setValue:value];
        NSLog(@"値を上書き key=%@",key);
    }
    
    if ([[_params[_params.count-1] key] isEqualToString:key]) {
        return YES;
    }else {
        return NO;
    }
    
}

/**
 * 複数のパラメーターを設定
 *
 * @param addParams QueryParameterの配列
 *
 * @return 結果（YES = 成功, NO = 失敗）
 */
- (BOOL) addAll:(NSMutableDictionary*) addParams{
    
    if (!addParams) {
        return NO;
    }
    
    int count = (int)[NSNumber numberWithUnsignedInt:(int)[_params count]] + (int)[NSNumber numberWithUnsignedInt:(int)[addParams count]] ;
    
    for (NSString *key in addParams) {
        [self add:key value:addParams[key]];
    }
    
    if (_params.count == count) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL) addAllWithQueryParameters:(QueryParameters *) addParams {
    for (int i = 0; i < [[addParams getParameters] count] ; i++) {
        QueryParameter *param = [addParams getParameters][i];
        [self add:param.key value:param.value];
    }
    return YES;
}


/**
 * パラメーターを初期化
 *
 * @return 結果（YES = 成功, NO = 失敗）
 */
- (BOOL) clear{
    
    [_params removeAllObjects];
    
    if (_params.count == 0) {
        return YES;
    }else {
        return NO;
    }
}

/**
 * パラメーターを返却
 *
 * @return パラメーター
 */
- (NSMutableArray*) getParameters {
    return _params;
}

/**
 * リストから引数のキー
 *
 *
 */
- (QueryParameter*) getValue:(NSString*) key{
    for (QueryParameter *param in _params) {
        if ([param.key isEqualToString:key]) {
            return param;
        }
    }
    @throw [VRIException exceptionWithMessage:[NSString stringWithFormat:@"key is not found : %@", key]];
}

/**
 * キーを検索
 *
 * @return キーの有無
 */
- (BOOL)containKey:(NSString *)key {
    for (QueryParameter *param in _params) {
        if ([param.key isEqualToString:key]) {
            return YES;
        }
    }
    return NO;
}


@end
