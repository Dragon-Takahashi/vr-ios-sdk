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
    __block NSMutableDictionary *parseResult;
    __block NSString *parseElement;
    __block NSDictionary *parseDict;
    
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
            parseResult = [[NSMutableDictionary alloc] init];
            
            // NSXMLParserを初期化
            if ([filePath length] == 0) {
                if (_listener) {
                    _listener(parseResult, identity, filePath, date, isRemoteFile);
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
            
            NSLog(@"ParseXML result = %@", isFinished ? @"YES" : @"NO");
            dispatch_semaphore_signal(semaphore);
        } @catch (NSException *exception) {
            NSLog(@"ParseXML berror : %@",[exception reason]);
            //        dispatch_async(dispatch_get_main_queue(), ^{
            //            // メインスレッドで処理をしたい内容、UIを変更など。
            //            @throw exception;
            //        });
            dispatch_semaphore_signal(semaphore);
        }
        
    });
    dispatch_sync(reentrantAvoidanceQueue, ^{ });
    dispatch_semaphore_wait(semaphore, time);
    
}


//デリゲートメソッド(解析開始時)
-(void) parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"解析開始");
    
}

//デリゲートメソッド(要素の開始タグを読み込んだ時)
- (void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName
     attributes:(NSDictionary *)attributeDict{
    
//    NSLog(@"要素の開始タグを読み込んだ:%@",elementName);
    
    // コンフィグタグは読み込まない
    if ([elementName isEqualToString:@"config"]) {
        return;
    }
    
    parseElement = elementName;
    parseDict = attributeDict;
    
}

//デリゲートメソッド(タグ以外のテキストを読み込んだ時)
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    // 開始タグ~終了タグの文字列以外は弾く
    if (parseElement.length == 0) {
        return;
    }
    
//    NSLog(@"タグ以外のテキストを読み込んだ:%@", string);
    if ([parseElement isEqualToString:@"beacon_url"]) {
        parseResult[parseElement] = [parseDict objectForKey:@"default"];
    }else {
        parseResult[parseElement] = string;
    }
    
}

//デリゲートメソッド(要素の終了タグを読み込んだ時)
- (void) parser:(NSXMLParser *)parser
  didEndElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName{
    
//    NSLog(@"要素の終了タグを読み込んだ:%@",elementName);
    
    parseElement = nil;
    parseDict = nil;
}

//デリゲートメソッド(解析終了時)
-(void) parserDidEndDocument:(NSXMLParser *)parser{
    
    // 確認用
    NSLog(@"parse result : %@", [parseResult description]);
    
    NSLog(@"解析終了");
    
    // メモリ解放
    xmlParser.delegate = nil;
    xmlParser = nil;
    
    // ConfigFileクラスに結果をコールバック
    if (_listener) {
        _listener(parseResult, identity, filePath, date, isRemoteFile);
    }else {
        NSLog(@"Listener is nil");
    }
    
    
}


@end
