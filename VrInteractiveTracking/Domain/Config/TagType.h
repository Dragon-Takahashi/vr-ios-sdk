//
//  TagType.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 1/28/21.
//  Copyright © 2021 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "../VRIException.h"
#import "Config.h"
#import "../Model/ValidationHandler.h"
#import "VrConfigValidator.h"
#import "VConfigValidator.h"

extern NSString *const kVR;
extern NSString *const kV;

@interface TagType : NSObject

//@property (nonatomic) NSString *kVR;
//@property (nonatomic) NSString *kV;
@property (nonatomic, copy) NSString *symbol;


/**
 タグタイプ返却

 @param symbol symbol
 @return TagType
 */
- (TagType *) of:(NSString *)symbol;


/**
 設定ファイルチェック

 @param config 設定ファイル
 @param handler ValidationHandler
 */
- (void) validate:(id<Config>) config handler:(ConfigValidationHandler *)handler;

@end
