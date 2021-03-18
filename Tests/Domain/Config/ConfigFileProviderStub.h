//
//  ConfigFileProviderStub.h
//  Tests
//
//  Created by 髙橋和成 on 11/2/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

//#import "ConfigFileProvider.h"
#import "../../../VrInteractiveTracking/Domain/Config/ConfigFileProvider.h"

@interface ConfigFileProviderStub : ConfigFileProvider
+ (void)initConfig;
- (NSString *)getLocalConfigFilePath:(NSString *)fileName;
- (ConfigFile*) loadConfig:(NSString*) identity;
@end
