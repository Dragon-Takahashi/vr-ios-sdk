//
//  QueryParameter.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/02.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 クエリパラメータ格納クラス
 */
@interface QueryParameter : NSObject

@property (nonatomic, copy) NSString* key;
@property (nonatomic, copy) NSString* value;

/**
 イニシャライザ

 @param key key
 @param value value
 @return self
 */
-(id) initWithParameter:(NSString*) key value:(NSString*) value;

@end
