//
//  Text.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/03.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Response用Textクラス
 */
@interface Text : NSObject

/**
 イニシャライザ

 @param text 文字列
 @return self
 */
- (instancetype) initWithText:(NSString*) text;

/**
 文字取得

 @return 文字列
 */
- (NSString*) getText;

@end
