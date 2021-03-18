//
//  QueryParameters.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/02.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueryParameter.h"

/**
 クエリパラメータリスト格納クラス
 */
@interface QueryParameters : NSObject

@property(nonatomic) NSMutableArray *params;

/**
 QueryParameter追加

 @param key key
 @param value value
 @return true:success false:failed
 */
- (BOOL) add:(NSString*)key value:(NSString *)value;
/**
 複数のQueryParameter追加

 @param addParams key-value群
 @return true:success false:failed
 */
- (BOOL) addAll:(NSMutableDictionary *)addParams;
/**
 QueryParametersベースでの複数のQueryParameter追加

 @param addParams QueryParameters
 @return true:success false:failed
 */
- (BOOL) addAllWithQueryParameters:(QueryParameters *)addParams;
/**
 削除

 @return true:success false:failed
 */
- (BOOL) clear;
/**
 要素群取得

 @return 要素群
 */
- (NSMutableArray *)getParameters;
/**
 要素取得

 @param key 要素key
 @return 要素
 */
- (QueryParameter *)getValue:(NSString *)key;

/**
 要素確認

 @param key 要素key
 @return 結果
 */
- (BOOL)containKey:(NSString *)key;

@end
