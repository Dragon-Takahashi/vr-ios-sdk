//
//  UUID.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/18.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 UUIDクラス
 */
@interface UUID : NSObject

/**
 UUID保存
 
 @return true:保存成功、false:保存失敗
 */
+ (BOOL) save;

/**
 UUID更新
 
 @param uuid UUID
 @return true:更新成功、false:更新失敗
 */
+ (BOOL) update:(NSString*) uuid;

/**
 UUID再発行
 
 @return true:再発行成功、false:再発行失敗
 */
+ (BOOL) replace;

/**
 UUID取得
 
 @return uuid UUID
 */
+ (NSString*) load;

@end
