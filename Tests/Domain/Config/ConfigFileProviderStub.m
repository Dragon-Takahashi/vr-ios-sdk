//
//  ConfigFileProviderStub.m
//  Tests
//
//  Created by 髙橋和成 on 11/2/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import "ConfigFileProviderStub.h"

@implementation ConfigFileProviderStub

/**
 テストバンドル用にオーバーライド
 ローカル設定ファイルを取得
 
 @param fileName ファイル名
 @return ファイルパス
 */
//- (NSString *)getLocalConfigFilePath:(NSString *)fileName {
//    // Documentsディレクトリパス
//    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirPath = [path objectAtIndex:0];
//    NSString *configPath = [[documentsDirPath stringByAppendingPathComponent:@"Config"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",fileName]];
//    // Documents配下に設定ファイルがあるかを判定
//    if ([[NSFileManager defaultManager] fileExistsAtPath:configPath] == NO) {
//        configPath = [[NSBundle bundleForClass:self.class] pathForResource:fileName ofType:@"xml"];
//    }
//
//    NSLog(@"Test local config file path = %@", configPath);
//    return configPath;
//}


+ (void)initConfig {
    
    [self common];
    
    [self defaultConfig];
    
    [self testConfig];
    
}

+ (void)common {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePathComponent = @"Remote";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirPath = [paths objectAtIndex:0];
    
    [fileManager createDirectoryAtPath:[documentsDirPath stringByAppendingPathComponent:filePathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (void)defaultConfig {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePathComponent = @"Remote";
    NSString *fileName = @"vrTrackingConfig";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirPath = [paths objectAtIndex:0];
    
    //    NSString *configPath = [[documentsDirPath stringByAppendingPathComponent:filePathComponent] stringByAppendingPathComponent:@"vrTrackingConfig.xml"];
    NSString *configPath = [[documentsDirPath stringByAppendingPathComponent:filePathComponent] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",fileName]];
    
    BOOL isDeleted = [fileManager removeItemAtPath:[self mainConfigPath:fileName] error:nil];
    if (isDeleted) {
        NSLog(@"file is deleted");
    }else {
        NSLog(@"file is not deleted...");
    }
    
    if ([fileManager copyItemAtPath:[self testConfigPath:@"vrTrackingConfig"] toPath:configPath error:nil]) {
        NSLog(@"Config file copy is success");
    }else {
        NSLog(@"Config file copy is miss");
    }
}

+ (void)testConfig {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePathComponent = @"Remote";
    NSString *fileName = @"TestVrTrackingConfig";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirPath = [paths objectAtIndex:0];
    
    //    NSString *configPath = [[documentsDirPath stringByAppendingPathComponent:filePathComponent] stringByAppendingPathComponent:@"vrTrackingConfig.xml"];
    NSString *configPath = [[documentsDirPath stringByAppendingPathComponent:filePathComponent] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",fileName]];
    
    BOOL isDeleted = [fileManager removeItemAtPath:[self mainConfigPath:fileName] error:nil];
    if (isDeleted) {
        NSLog(@"file is deleted");
    }else {
        NSLog(@"file is not deleted...");
    }
    if ([fileManager copyItemAtPath:[self testConfigPath:fileName] toPath:configPath error:nil]) {
        NSLog(@"Config file copy is success");
    }else {
        NSLog(@"Config file copy is miss");
    }
}

+ (NSString *)testConfigPath:(NSString *)fileName {
    NSString *configPath = [[NSBundle bundleForClass:self.class] pathForResource:fileName ofType:@"xml"];
    
    NSLog(@"Test local config file path = %@", configPath);
    return configPath;
}
+ (NSString *)mainConfigPath:(NSString *)fileName {
    // Documentsディレクトリパス
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirPath = [path objectAtIndex:0];
    NSString *configPath = [[documentsDirPath stringByAppendingPathComponent:@"Remote"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",fileName]];
    // Documents配下に設定ファイルがあるかを判定
    if ([[NSFileManager defaultManager] fileExistsAtPath:configPath] == NO) {
        configPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    }
    
    NSLog(@"Main local config file path = %@", configPath);
    return configPath;
}


/**
 ローカル設定ファイルを取得
 
 @param fileName ファイル名
 @return ファイルパス
 */
- (NSString *)getLocalConfigFilePath:(NSString *)fileName {
    // Documentsディレクトリパス
    NSString *configPath = [[NSBundle bundleForClass:self.class] pathForResource:fileName ofType:@"xml"];
    // Documents配下に設定ファイルがあるかを判定
    if ([[NSFileManager defaultManager] fileExistsAtPath:configPath] == NO) {
        configPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    }
    NSLog(@"Local config6 file path = %@", configPath);
    return configPath;
}


@end
