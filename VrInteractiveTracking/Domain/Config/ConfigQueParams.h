//
//  ConfigQueParams.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/09.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FinishLoadCustomConfigBlock) (NSString *param, int result);

/**
 設定ファイルのキュー格納クラス
 */
@interface ConfigQueParams : NSObject

@property (nonatomic, copy) NSString *identity;
@property (nonatomic, copy) NSString *filePath;

@end
