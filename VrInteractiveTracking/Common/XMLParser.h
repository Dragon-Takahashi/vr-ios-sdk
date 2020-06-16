//
//  XMLParser.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/30.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigFile.h"
//#import "../Domain/Config/ConfigFile.h"

//typedef void (^XmlParseCallback) (NSMutableDictionary *result, NSString *identity, NSString *filePath, NSString *date, BOOL isRemoteFile);
typedef void (^XmlParseCallback) (NSMutableArray *configFileArray, BOOL isRemoteFile);

/**
 XMLParseクラス
 */
@interface XMLParser : NSObject <NSXMLParserDelegate>

@property(nonatomic, copy) XmlParseCallback listener;

/**
 パース処理

 @param filePath ファイルパス
 @param identity Identity
 @param date 日付
 @param isRemoteFile リモート設定ファイルフラグ
 @param callback コールバック
 */
- (void) parseXML:(NSString*) filePath identity:(NSString*) identity date:(NSString*) date isRemoteFile:(BOOL) isRemoteFile callback:(XmlParseCallback) callback;

@end
