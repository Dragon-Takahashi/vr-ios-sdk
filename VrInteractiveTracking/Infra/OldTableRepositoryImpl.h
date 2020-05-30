//
//  OldTableRepositoryImpl.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/21.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 旧テーブル削除クラス
 */
@interface OldTableRepositoryImpl : NSObject

/**
 削除判断
 */
+ (void)drop;

/**
 旧SDKのDBを削除

 @return true:success false:failed
 */
+ (BOOL)hasDBForTest;
@end
