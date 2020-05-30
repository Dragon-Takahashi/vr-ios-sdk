//
//  QuerySpec.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/03.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueryParameters.h"
#import "OptValues.h"

/**
 クエリパラメータ仕様クラス
 */
@interface QuerySpec : NSObject

@property (nonatomic) QueryParameters *parameters;

/**
 要素群取得

 @return QueryParameters
 */
- (QueryParameters*) getQueryParameters;

/**
 削除
 */
- (void) clearAllParameters;

/**
 要素追加 for OptValues

 @param builder ビルダー
 */
- (void) addParametersWithBuilder:(OptValues*) builder;

@end
