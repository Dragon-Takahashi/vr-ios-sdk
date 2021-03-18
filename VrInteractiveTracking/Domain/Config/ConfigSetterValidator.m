//
//  ConfigSetterValidator.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/22/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "ConfigSetterValidator.h"

@interface ConfigSetterValidator()
@property (nonatomic, copy, readwrite, getter=handler) ConfigValidationHandler *handler;
@property (nonatomic, copy) ConfigFile *config;
@end

@implementation ConfigSetterValidator

- (instancetype)initWithValidationHandler:(ConfigValidationHandler *)handler config:(ConfigFile *)config {
    self = [super init];
    if (self) {
        _handler = handler;
        _config = config;
        
        [self validate];
    }
    return self;
}

- (void)validate {
    [self isCheckedVrTagId1];
    [self isCheckedVrTagId2];
    [self isCheckedConfigTimeout];
    [self isCheckedBeaconTimeout];
    [self isCheckedConfigURL];
    [self isCheckedBeaconURL];
}

- (void)isCheckedVrTagId1 {
    if ([_config.getVr_TagId1 isEqualToString:@""]) {
        [_handler handleError:@"The vr_tagid1 is empty"];
    }
}

- (void)isCheckedVrTagId2 {
    if ([_config.getVr_TagId2 isEqualToString:@""]) {
        [_handler handleError:@"The vr_tagid2 is empty"];
    }
}

- (void)isCheckedConfigTimeout {
    if ([_config.getConfig_timeout isEqualToString:@""]) {
        [_handler handleError:@"The config_timeout is empty"];
    }
    if (![self isDigit:_config.getConfig_timeout] && _config.getConfig_timeout != nil) {
        [_handler handleError:@"The config_timeout exceeded the digit"];
    }
    if ([self isOverflow:_config.getConfig_timeout] && _config.getConfig_timeout != nil) {
        [_handler handleError:@"The config_timeout is overflow"];
    }
    if ([self isUnderZero:_config.getConfig_timeout] && _config.getConfig_timeout != nil) {
        [_handler handleError:@"The config_timeout is under zero"];
    }
}

- (void)isCheckedBeaconTimeout {
    if ([_config.getBeacon_timeout isEqualToString:@""]) {
        [_handler handleError:@"The beacon_timeout is empty"];
    }
    if (![self isDigit:_config.getBeacon_timeout] && _config.getBeacon_timeout != nil) {
        [_handler handleError:@"The beacon_timeout exceeded the digit"];
    }
    if ([self isOverflow:_config.getBeacon_timeout] && _config.getBeacon_timeout != nil) {
        [_handler handleError:@"The beacon_timeout is overflow"];
    }
    if ([self isUnderZero:_config.getBeacon_timeout] && _config.getBeacon_timeout != nil ) {
        [_handler handleError:@"The beacon_timeout is under zero"];
    }
}

- (void)isCheckedConfigURL {
    if (![self isHTTP:_config.getConfig_Url] && [_config.getConfig_Url length] != 0) {
        [_handler handleError:@"The config_url is not URL"];
    }
}

- (void)isCheckedBeaconURL {
    if ([_config.getBeacon_url isEqualToString:@""]) {
        [_handler handleError:@"The beacon_url is empty"];
    }
    
    if (![self isHTTP:_config.getBeacon_url] && [_config.getBeacon_url length] != 0) {
        [_handler handleError:@"The beacon_url is not URL"];
    }
}


#pragma mark - validate method

/**
 *  半角数字かを判定する.
 *
 *  @param text 文字列
 *
 *  @return 結果(YES = 半角, NO = 半角英数字以外)
 */
- (BOOL)isDigit:(NSString *)text
{
    if ([text length] == 0) {
        return NO;
    }
    NSCharacterSet *digit = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    NSScanner *scanner = [NSScanner localizedScannerWithString:text];
    [scanner setCharactersToBeSkipped:nil];
    
    [scanner scanCharactersFromSet:digit intoString:NULL];
    
    return [scanner isAtEnd];
}

/**
 *  int桁数オーバーフローかを判定する．
 *
 *  @param text 文字列
 *
 *  @return 結果(YES = 桁数内, NO = オーバーフロー)
 */
- (BOOL)isOverflow:(NSString *)text
{
    int intText = [text intValue];
    if (intText == INT_MAX) {
        return YES;
    }
    return NO;
}

/**
 * 外部と通信をするかを判断し返す
 * 「http://」「https://」で開始されているかを判定する.
 *
 * @return 結果(YES = 通信, NO = ローカルパス)
 */
-(BOOL)isHTTP:(NSString*) url {
    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
        return YES;
    }else {
        return NO;
    }
}


/**
 0以下の数字かを判断
 
 @param text 文字列
 @return 結果(YES = 0以下, NO = 1以上)
 */
- (BOOL)isUnderZero:(NSString *)text {
    int intText = [text intValue];
    if (intText > 0) {
        return NO;
    }else {
        return YES;
    }
}



@end
