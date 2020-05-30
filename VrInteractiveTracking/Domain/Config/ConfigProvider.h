//
//  ConfigProvider.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/20.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//
#import "ConfigFile.h"

#ifndef ConfigProvider_h
#define ConfigProvider_h

typedef void (^FinishLoadCustomConfigBlock) (NSString *param, int result);

/**
 設定ファイル情報格納クラス
 */
@protocol ConfigProvider <NSObject>
@required
- (ConfigFile*) loadConfig:(NSString*) identity;
- (void) addConfigWithIdentity:(NSString*) identity fileName:(NSString *)fileName;
- (ConfigFile*) loadConfig;

@end


#endif /* ConfigProvider_h */
