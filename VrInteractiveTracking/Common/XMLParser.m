//
//  XMLParser.m
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/09/30.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#import "XMLParser.h"

@interface XMLParser() {
    
    __block NSXMLParser *xmlParser;
    __block NSMutableArray *parseResult;
    __block NSMutableDictionary *parseElementDic;
    __block NSString *parseElement;
    __block NSDictionary *parseDict;
    __block NSString *parseIdentity;
    __block BOOL isMultipulConfig;
    
    __block NSString *filePath;
    __block NSString *identity;
    __block NSString *date;
    __block BOOL isRemoteFile;
    
}
@end

@implementation XMLParser


- (void) parseXML:(NSString*) filePath identity:(NSString*) identity date:(NSString*) date isRemoteFile:(BOOL) isRemoteFile callback:(XmlParseCallback) callback {
    if (callback) {
        _listener = [callback copy];
        self->filePath = filePath;
        self->identity = identity;
        self->date = date;
        self->isRemoteFile = isRemoteFile;
        
        [self parseInit:filePath];
    }
}

- (void) parseInit:(NSString*) filePath {
    
    NSLog(@"ParseXML start url = %@",filePath);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC));
    dispatch_queue_t reentrantAvoidanceQueue = dispatch_queue_create("reentrantAvoidanceQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(reentrantAvoidanceQueue, ^{
        @try {
            // 結果保存用の変数を初期化
//            parseResult = [[NSMutableDictionary alloc] init];
            parseResult = NSMutableArray.new;
            
            // NSXMLParserを初期化
            if ([filePath length] == 0) {
                if (_listener) {
                    _listener(parseResult, isRemoteFile);
                }
                return;
            }
            NSURL *xmlURL = [NSURL fileURLWithPath:filePath];
            xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
            xmlParser.delegate = self;
            bool isFinished = false;
            isFinished = [xmlParser parse];
            
            xmlParser.delegate = nil;
            xmlParser = nil;
            
            DLog(@"ParseXML result = %@", isFinished ? @"YES" : @"NO");
            dispatch_semaphore_signal(semaphore);
        } @catch (NSException *exception) {
            DLog(@"ParseXML berror : %@",[exception reason]);
            dispatch_semaphore_signal(semaphore);
        }
        
    });
    dispatch_sync(reentrantAvoidanceQueue, ^{ });
    dispatch_semaphore_wait(semaphore, time);
    
}


//デリゲートメソッド(解析開始時)
-(void) parserDidStartDocument:(NSXMLParser *)parser{
    DLog(@"解析開始");
    isMultipulConfig = NO;
}

//デリゲートメソッド(要素の開始タグを読み込んだ時)
- (void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName
     attributes:(NSDictionary *)attributeDict{
    
//    DLog(@"要素の開始タグを読み込んだ:%@",elementName);
    
    // config(s)タグは読み込まない
    if ([elementName isEqualToString:@"configs"] ) {
        isMultipulConfig = YES;
        return;
    }
    if ([elementName isEqualToString:@"config"]) {
        parseElementDic = NSMutableDictionary.new;
        parseIdentity = nil;
        return;
    }
    
    parseElement = elementName;
    parseDict = attributeDict;
    
}

//デリゲートメソッド(タグ以外のテキストを読み込んだ時)
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
//    DLog(@"要素のテキストを読み込んだ:%@",string);
    
    // 開始タグ~終了タグの文字列以外は弾く
    if (parseElement.length == 0) {
        return;
    }
    
    if ([parseElement isEqualToString:@"beacon_url"]) {
        parseElementDic[parseElement] = [parseDict objectForKey:@"default"];
    }else {
        parseElementDic[parseElement] = string;
    }
    
    if ([parseElement isEqualToString:@"identity"]) {
        parseIdentity = string;
    }
}

//デリゲートメソッド(要素の終了タグを読み込んだ時)
- (void) parser:(NSXMLParser *)parser
  didEndElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName{
    
//    DLog(@"要素の終了タグを読み込んだ:%@",elementName);
    
    if ([elementName isEqualToString:@"config"]) {
        if (!isMultipulConfig) {
            [parseResult addObject:[self elementToConfigFileWithIdentity:identity filePath:filePath elements:parseElementDic]];
        }else if (parseIdentity.length != 0){
            [parseResult addObject:[self elementToConfigFileWithIdentity:parseIdentity filePath:filePath elements:parseElementDic]];
        }
    }
    
    parseElement = nil;
    parseDict = nil;
}

//デリゲートメソッド(解析終了時)
-(void) parserDidEndDocument:(NSXMLParser *)parser{
    
    // 確認用
    DLog(@"parse result : %@", [parseResult description]);
    
    DLog(@"解析終了");
    
    // メモリ解放
    xmlParser.delegate = nil;
    xmlParser = nil;
    
    // ConfigFileクラスに結果をコールバック
    if (_listener) {
        _listener(parseResult, isRemoteFile);
    }else {
        DLog(@"Listener is nil");
    }
    
    
}


- (ConfigFile *)elementToConfigFileWithIdentity:(NSString *)identity filePath:(NSString *)filePath elements:(NSMutableDictionary *)elements {
    ConfigFile *configFile = [[ConfigFile alloc] initWithParams:[elements copy]];
    configFile.identity = identity;
    configFile.filePath = filePath;
    configFile.date = [self castStringToDate:date];
    return configFile;
}

/**
 * 日時のキャスト
 * 想定例：Wed, 10 Oct 2018 07:13:44 GMT
 *
 * @param dateStr キャスト前の日時
 *
 * @return キャスト後の日時
 */
- (NSDate*) castStringToDate:(NSString*) dateStr {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"E, d MMM yyyy HH:mm:ss Z"];
    //タイムゾーンの指定
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSDate *date = [formatter dateFromString:dateStr];
    return date;
}

@end
