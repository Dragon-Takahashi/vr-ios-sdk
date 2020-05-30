//
//  ConfigValueAdapter.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/22/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 設定ファイルのキャストクラス
 */
@interface ConfigValueAdapter : NSObject

/**
 設定ファイルをキャスト

 @param values 要素群
 @return キャスト後の要素群
 */
+ (NSDictionary *)castAllValue:(NSDictionary *)values;

@end
