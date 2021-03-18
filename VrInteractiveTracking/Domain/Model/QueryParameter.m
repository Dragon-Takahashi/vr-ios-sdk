//
//  QueryParameter.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/02.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "QueryParameter.h"

@implementation QueryParameter

/**
 * コンストラクタ
 *
 * @param key キー
 * @param value 値
 */
-(id) initWithParameter:(NSString*) key value:(NSString*) value{
    if((self = [super init])){
        _key = [key copy];
        _value = [value copy];
    }
    return self;
}

@end
