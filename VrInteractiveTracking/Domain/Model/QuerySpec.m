//
//  QuerySpec.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/03.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "QuerySpec.h"

@interface QuerySpec()
//@property (nonatomic, readwrite) QueryParameters *parameters;
@end

@implementation QuerySpec
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}


/**
 * コンストラクタ
 *
 */
- (id) init {
    if((self = [super init])){
//        _parametersList = [NSMutableDictionary dictionary];
        _parameters = [QueryParameters new];
    }
    return self;
}

/**
 * 新しいQueryParametersクラスを生成
 *
 */
//- (void) addQueryParameters:(NSString*) title {
//    QueryParameters *parameters = [QueryParameters new];
//    [_parametersList setObject:parameters forKey:title];
//}

/**
 * QueryParametersクラスを取得
 *
 * @return 対象のQueryParameters
 */
- (QueryParameters*) getQueryParameters {
    return _parameters;
}

/**
 * 全てのパラメータを削除
 *
 */
- (void) clearAllParameters {
    // パラメータ削除
    [_parameters clear];
}

/**
 * 直感的にパラメータを追加する「setVrOptValue」を叩かれた際にQueryParametersへ流し込む窓口
 *
 * @param builder ビルダー
 *
 */
- (void) addParametersWithBuilder:(OptValues*) builder{
    
    
    // インデックスに入っている値を上書き
    [_parameters addAll:[builder getParams]];
    
}

@end
