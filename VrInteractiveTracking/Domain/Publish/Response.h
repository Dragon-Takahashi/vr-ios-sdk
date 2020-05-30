//
//  Response.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/03.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Status.h"
#import "Text.h"

/**
 レスポンスクラス
 */
@interface Response : NSObject

@property (nonatomic, copy) NSString *url;

/**
 イニシャライザ

 @param status Status
 @param text Text
 @return self
 */
- (instancetype) initWithResult:(Status*) status text:(Text*) text;

/**
 状態取得

 @return Status
 */
- (Status*) getStatus;

/**
 文字取得

 @return Text
 */
- (Text*) getText;

@end
