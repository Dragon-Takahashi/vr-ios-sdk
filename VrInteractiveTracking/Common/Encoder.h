//
//  Encoder.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/08.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 エンコードクラス
 */
@interface Encoder : NSObject

/**
 エンコーダー

 @param urlStr URL
 @return EncodedURL
 */
+ (NSString *)urlEncode:(NSString*) urlStr;

@end
