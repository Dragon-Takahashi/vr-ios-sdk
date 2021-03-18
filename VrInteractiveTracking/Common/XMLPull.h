//
//  XMLPull.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/01.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^XmlPullCallback) (NSString *configFilePath, NSString *date, NSString *identity, NSString *filePath);

/**
 XML取得クラス
 */
@interface XMLPull : NSObject <NSURLSessionDelegate>

@property (nonatomic, copy) XmlPullCallback listener;
@property (nonatomic, copy) NSString *filePathComponent;

/**
 XML取得

 @param url 該当ファイルのURL
 @param identity Identity
 @param configTimeout タイムアウト
 @param callback コールバック
 */
- (void) getXml:(NSString*) url identity:(NSString*) identity configTimeout:(NSString *)configTimeout callback:(XmlPullCallback) callback;

@end
