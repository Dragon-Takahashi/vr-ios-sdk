//
//  ConfigFile.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/20.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "ConfigFile.h"

// 設定ファイルのタグ定数
NSString *const CONFIG_KEY_IDENTITY = @"identity";
NSString *const CONFIG_KEY_TAG1 = @"vr_tagid1";
NSString *const CONFIG_KEY_TAG2 = @"vr_tagid2";
NSString *const CONFIG_KEY_CONFIG_URL = @"config_url";
NSString *const CONFIG_KEY_DISABLED = @"disabled";
NSString *const CONFIG_KEY_CONFIG_TIMEOUT = @"config_timeout";
NSString *const CONFIG_KEY_BEACON_TIMEOUT = @"beacon_timeout";
NSString *const CONFIG_KEY_BEACON_URL = @"beacon_url";
NSString *const CONFIG_KEY_BEACON_URL_DEFAULT = @"default";

@interface ConfigFile()
@property (nonatomic) NSMutableDictionary *params;
@end


@implementation ConfigFile

#pragma mark - Constructor

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setParams:nil];
    }
    return self;
}

/**
 * コンストラクタ
 *
 * @param params 設定ファイルの値を格納した配列
 *
 */
- (instancetype) initWithParams:(NSMutableDictionary*) params{
    if((self = [super init])){
        [self setParams:params];
    }
    return self;
}


/**
 設定ファイル変数の初期化

 @param params 引数の設定ファイルの定義値
 */
- (void)setParams:(NSMutableDictionary *)params {
    if (params) {
        _params = params;
        [self parseParam:params];
    }else {
        _params = [NSMutableDictionary dictionary];
    }
}

/**
 * 設定ファイルの値を格納した配列をパースし、各変数へ格納する
 *
 * @param params 設定ファイルの値を格納した配列
 *
 */
- (void) parseParam:(NSMutableDictionary*) params {
    // TODO 各変数へ値をぶち込んでいく
    
    for (NSString *key in params) {
        if ([key isEqualToString:CONFIG_KEY_IDENTITY]) {
            _identity = [params objectForKey:CONFIG_KEY_IDENTITY];
        }else if ([key isEqualToString:CONFIG_KEY_TAG1]) {
            _vr_TagId1 = [params objectForKey:CONFIG_KEY_TAG1];
        }else if ([key isEqualToString:CONFIG_KEY_TAG2]) {
            _vr_TagId2 = [params objectForKey:CONFIG_KEY_TAG2];
        }else if ([key isEqualToString:CONFIG_KEY_CONFIG_URL]) {
            _config_Url = [params objectForKey:CONFIG_KEY_CONFIG_URL];
        }else if ([key isEqualToString:CONFIG_KEY_DISABLED]) {
            _disable = [self castStringForBool:[params objectForKey:CONFIG_KEY_DISABLED]];
        }else if ([key isEqualToString:CONFIG_KEY_CONFIG_TIMEOUT]) {
            _config_timeout = [params objectForKey:CONFIG_KEY_CONFIG_TIMEOUT];
        }else if ([key isEqualToString:CONFIG_KEY_BEACON_TIMEOUT]) {
            _beacon_timeout = [params objectForKey:CONFIG_KEY_BEACON_TIMEOUT];
        }else if ([key isEqualToString:CONFIG_KEY_BEACON_URL]) {
            if ([[params objectForKey:CONFIG_KEY_BEACON_URL] isKindOfClass:[NSString class]]) {
                _beacon_url =[params objectForKey:CONFIG_KEY_BEACON_URL];
            }else {
                _beacon_url = [[params objectForKey:CONFIG_KEY_BEACON_URL] objectForKey:CONFIG_KEY_BEACON_URL_DEFAULT];
            }
        }
    }
}


/**
 * 設定ファイルの中身全ての配列を返す
 *
 */
- (NSMutableDictionary *)getElements {
    return _params;
}

/**
 boolean型の設定値をlowercaseに変更
 BOOL型からのキャストを吸収

 @param value 設定ファイルの定義値（boolean型・BOOL型）
 @return 小文字のboolean型文字列
 */
- (NSString *)castStringForBool:(id)value {
    
    NSString *result = [NSString string];
    @try {
        if (![value isKindOfClass:[NSString class]]) {
            if ([value isEqual: @YES]) {
                result = @"true";
            }else {
                result = @"false";
            }
        }else {
            result = [value lowercaseString];
            if (![result isEqualToString:@"true"] && ![result isEqualToString:@"false"]) {
                result = @"false";
            }
        }
    } @catch (NSException *exception) {
        result = @"false";
    }

    return result;
}

/**
 Disabledの設定値のセッター
 
 @param disabled フラグ（YES = true, NO = false）
 */
- (void)setDisabled:(BOOL)disabled {
    if (!disabled) {
        _disable = @"false";
    }else {
        _disable = @"true";
    }
}
/**
 Disabledの設定値のゲッター
 デフォルトの設定＝true
 
 @return フラグ（YES = true, NO = false）
 */
- (BOOL)getDisabled {
    if ([_disable isEqualToString:@"false"]) {
        return NO;
    }else {
        return YES;
    }
}

- (void)setIdentity:(NSString *)identity {
    _identity = identity;
    NSMutableDictionary *dic = [_params mutableCopy];
    [dic setObject:identity forKey:CONFIG_KEY_IDENTITY];
    _params = dic;
}



@end

