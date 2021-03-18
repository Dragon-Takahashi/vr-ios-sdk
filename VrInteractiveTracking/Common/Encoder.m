//
//  Encoder.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/08.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "Encoder.h"

#import "../Domain/VRIException.h"

@implementation Encoder

/**
 * URLエンコード
 *
 * @param urlStr エンコード前の文字列
 *
 * @return エンコード後の文字列
 */
+ (NSString *)urlEncode:(NSString*) urlStr{
    
//    NSString *escapedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)urlStr,NULL,
//                                                                                  CFSTR("!*'();:@&=+$,/?%#[]+　'|~！”＃＄％＆’（）＝～@<>＜＞？＊｀〜｜"),kCFStringEncodingUTF8);
    @try {
        NSString *genDelims = @":/?#[]@";
        NSString *subDelims = @"!$&'()*+,;=";
        NSString *reservedCharacters = [NSString stringWithFormat:@"%@%@", genDelims, subDelims];
        //URLQueryAllowedCharacterSetからRFC 3986で予約されている文字を除いたもののみエスケープしない
        NSMutableCharacterSet * allowedCharacterSet = [NSCharacterSet URLQueryAllowedCharacterSet].mutableCopy;
        [allowedCharacterSet removeCharactersInString:reservedCharacters];
        NSString *escapedString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        
        return escapedString;
    } @catch (NSException *exception) {
        @throw [VRIException exceptionWithMessage:[NSString stringWithFormat:@"Encode error. text = %@",urlStr]];
        return urlStr;
    }

}


@end
