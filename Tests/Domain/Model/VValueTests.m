//
//  VValueTests.m
//  Tests
//
//  Created by 髙橋和成 on 2/3/21.
//  Copyright © 2021 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../../../VrInteractiveTracking/Domain/Model/VValues.h"

@interface VValueTests : XCTestCase

@end

@implementation VValueTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

/**
 目的：正しく変数を保持できていいるか確認する
 */
- (void)testInit {
    VValues *values = [VValues new];
    
    values.c = @"c";
    values.r = @"r";
    values.t = @"t";
    values.appid = @"appid";
    values.dcid = @"dcid";
    values.dnt = @"dnt";
    values.dctype = @"dctype";
    values.ref = @"ref";
    values.url = @"url";
    values.pf = @"pf";
    values.pcf = @"pcf";
    values.pcs = @"pcs";
    values.pct = @"pct";
    values.etime = @"etime";
    values.event = @"event";
    values.player = @"player";
    values.ad = @"ad";
    values.roll = @"roll";
    values.pod = @"pod";
    values.adev = @"adev";
    values.metrics = @"metrics";
    values.senderid = @"senderid";
    values.senderuuid = @"senderuuid";
    values.snederdcos = @"snederdcos";
    values.speed = @"speed";
    values.screen = @"screen";
    values.p = @"p";
    values.appver = @"appver";
    values.projectid = @"projectid";
    values.snsflg = @"snsflg";
    values.u1 = @"u1";
    values.u2 = @"u2";
    values.u3 = @"u3";
    values.u4 = @"u4";
    values.u5 = @"u5";
    values.u6 = @"u6";
    values.u7 = @"u7";
    values.u8 = @"u8";
    values.u9 = @"u9";
    values.ptag = @"ptag";
    values.hci = @"hci";
    values.hca = @"hca";
    values.hce = @"hce";
    values.hpc = @"hpc";
    values.hcr = @"hcr";
    values.hld = @"hld";
    
    
    // 前提：VValuesに全ての変数を追加している
    // 想定：全ての変数に変数名が入っている
    XCTAssertEqual(values.c, @"c");
    XCTAssertEqual(values.r, @"r");
    XCTAssertEqual(values.t, @"t");
    XCTAssertEqual(values.appid, @"appid");
    XCTAssertEqual(values.dcid, @"dcid");
    XCTAssertEqual(values.dnt, @"dnt");
    XCTAssertEqual(values.dctype, @"dctype");
    XCTAssertEqual(values.ref, @"ref");
    XCTAssertEqual(values.url, @"url");
    XCTAssertEqual(values.pf, @"pf");
    XCTAssertEqual(values.pcf, @"pcf");
    XCTAssertEqual(values.pcs, @"pcs");
    XCTAssertEqual(values.pct, @"pct");
    XCTAssertEqual(values.etime, @"etime");
    XCTAssertEqual(values.event, @"event");
    XCTAssertEqual(values.player, @"player");
    XCTAssertEqual(values.ad, @"ad");
    XCTAssertEqual(values.roll, @"roll");
    XCTAssertEqual(values.pod, @"pod");
    XCTAssertEqual(values.adev, @"adev");
    XCTAssertEqual(values.metrics, @"metrics");
    XCTAssertEqual(values.senderid, @"senderid");
    XCTAssertEqual(values.senderuuid, @"senderuuid");
    XCTAssertEqual(values.snederdcos, @"snederdcos");
    XCTAssertEqual(values.speed, @"speed");
    XCTAssertEqual(values.screen, @"screen");
    XCTAssertEqual(values.p, @"p");
    XCTAssertEqual(values.appver, @"appver");
    XCTAssertEqual(values.projectid, @"projectid");
    XCTAssertEqual(values.snsflg, @"snsflg");
    XCTAssertEqual(values.u1, @"u1");
    XCTAssertEqual(values.u2, @"u2");
    XCTAssertEqual(values.u3, @"u3");
    XCTAssertEqual(values.u4, @"u4");
    XCTAssertEqual(values.u5, @"u5");
    XCTAssertEqual(values.u6, @"u6");
    XCTAssertEqual(values.u7, @"u7");
    XCTAssertEqual(values.u8, @"u8");
    XCTAssertEqual(values.u9, @"u9");
    XCTAssertEqual(values.ptag, @"ptag");
    XCTAssertEqual(values.hci, @"hci");
    XCTAssertEqual(values.hca, @"hca");
    XCTAssertEqual(values.hce, @"hce");
    XCTAssertEqual(values.hpc, @"hpc");
    XCTAssertEqual(values.hcr, @"hcr");
    XCTAssertEqual(values.hld, @"hld");
}


/**
 目的：正しくビルドできていいるか確認する
 */
- (void)testBuild {
    VValues *values = [VValues new];
    
    values.c = @"c";
    values.r = @"r";
    values.t = @"t";
    values.appid = @"appid";
    values.dcid = @"dcid";
    values.dnt = @"dnt";
    values.dctype = @"dctype";
    values.ref = @"ref";
    values.url = @"url";
    values.pf = @"pf";
    values.pcf = @"pcf";
    values.pcs = @"pcs";
    values.pct = @"pct";
    values.etime = @"etime";
    values.event = @"event";
    values.player = @"player";
    values.ad = @"ad";
    values.roll = @"roll";
    values.pod = @"pod";
    values.adev = @"adev";
    values.metrics = @"metrics";
    values.senderid = @"senderid";
    values.senderuuid = @"senderuuid";
    values.snederdcos = @"snederdcos";
    values.speed = @"speed";
    values.screen = @"screen";
    values.p = @"p";
    values.appver = @"appver";
    values.projectid = @"projectid";
    values.snsflg = @"snsflg";
    values.u1 = @"u1";
    values.u2 = @"u2";
    values.u3 = @"u3";
    values.u4 = @"u4";
    values.u5 = @"u5";
    values.u6 = @"u6";
    values.u7 = @"u7";
    values.u8 = @"u8";
    values.u9 = @"u9";
    values.ptag = @"ptag";
    values.hci = @"hci";
    values.hca = @"hca";
    values.hce = @"hce";
    values.hpc = @"hpc";
    values.hcr = @"hcr";
    values.hld = @"hld";
    
    NSMutableDictionary *field = [values build];
    
    // 前提：VValuesに全ての変数を追加しbuildしている
    // 想定：全ての変数に変数名が入っている
    XCTAssertEqual([field objectForKey:@"c"], @"c");
    XCTAssertEqual([field objectForKey:@"r"], @"r");
    XCTAssertEqual([field objectForKey:@"t"], @"t");
    XCTAssertEqual([field objectForKey:@"appid"], @"appid");
    XCTAssertEqual([field objectForKey:@"dcid"], @"dcid");
    XCTAssertEqual([field objectForKey:@"dnt"], @"dnt");
    XCTAssertEqual([field objectForKey:@"dctype"], @"dctype");
    XCTAssertEqual([field objectForKey:@"ref"], @"ref");
    XCTAssertEqual([field objectForKey:@"url"], @"url");
    XCTAssertEqual([field objectForKey:@"pf"], @"pf");
    XCTAssertEqual([field objectForKey:@"pcf"], @"pcf");
    XCTAssertEqual([field objectForKey:@"pcs"], @"pcs");
    XCTAssertEqual([field objectForKey:@"pct"], @"pct");
    XCTAssertEqual([field objectForKey:@"etime"], @"etime");
    XCTAssertEqual([field objectForKey:@"event"], @"event");
    XCTAssertEqual([field objectForKey:@"player"], @"player");
    XCTAssertEqual([field objectForKey:@"ad"], @"ad");
    XCTAssertEqual([field objectForKey:@"roll"], @"roll");
    XCTAssertEqual([field objectForKey:@"pod"], @"pod");
    XCTAssertEqual([field objectForKey:@"adev"], @"adev");
    XCTAssertEqual([field objectForKey:@"metrics"], @"metrics");
    XCTAssertEqual([field objectForKey:@"senderid"], @"senderid");
    XCTAssertEqual([field objectForKey:@"senderuuid"], @"senderuuid");
    XCTAssertEqual([field objectForKey:@"snederdcos"], @"snederdcos");
    XCTAssertEqual([field objectForKey:@"speed"], @"speed");
    XCTAssertEqual([field objectForKey:@"screen"], @"screen");
    XCTAssertEqual([field objectForKey:@"p"], @"p");
    XCTAssertEqual([field objectForKey:@"appver"], @"appver");
    XCTAssertEqual([field objectForKey:@"projectid"], @"projectid");
    XCTAssertEqual([field objectForKey:@"snsflg"], @"snsflg");
    XCTAssertEqual([field objectForKey:@"u1"], @"u1");
    XCTAssertEqual([field objectForKey:@"u2"], @"u2");
    XCTAssertEqual([field objectForKey:@"u3"], @"u3");
    XCTAssertEqual([field objectForKey:@"u4"], @"u4");
    XCTAssertEqual([field objectForKey:@"u5"], @"u5");
    XCTAssertEqual([field objectForKey:@"u6"], @"u6");
    XCTAssertEqual([field objectForKey:@"u7"], @"u7");
    XCTAssertEqual([field objectForKey:@"u8"], @"u8");
    XCTAssertEqual([field objectForKey:@"u9"], @"u9");
    XCTAssertEqual([field objectForKey:@"ptag"], @"ptag");
    XCTAssertEqual([field objectForKey:@"hci"], @"hci");
    XCTAssertEqual([field objectForKey:@"hca"], @"hca");
    XCTAssertEqual([field objectForKey:@"hce"], @"hce");
    XCTAssertEqual([field objectForKey:@"hpc"], @"hpc");
    XCTAssertEqual([field objectForKey:@"hcr"], @"hcr");
    XCTAssertEqual([field objectForKey:@"hld"], @"hld");
}


/**
 目的：nilの場合でも問題ないか確認する
 */
- (void)testBuildNil {
    VValues *values = [VValues new];
    
    
    NSMutableDictionary *field = [values build];
    
//    NSLog(@"-----------------------");
//    NSLog(@"%@", [field allKeys]);
//    NSLog(@"-----------------------");
    
    // 前提：VValuesを初期状態のままbuildしている
    // 想定：全ての変数に変数名が入っていない
    XCTAssertNil([field objectForKey:@"c"]);
    XCTAssertNil([field objectForKey:@"r"]);
    XCTAssertNil([field objectForKey:@"t"]);
    XCTAssertNil([field objectForKey:@"appid"]);
    XCTAssertNil([field objectForKey:@"dcid"]);
    XCTAssertNil([field objectForKey:@"dnt"]);
    XCTAssertNil([field objectForKey:@"dctype"]);
    XCTAssertNil([field objectForKey:@"ref"]);
    XCTAssertNil([field objectForKey:@"url"]);
    XCTAssertNil([field objectForKey:@"pf"]);
    XCTAssertNil([field objectForKey:@"pcf"]);
    XCTAssertNil([field objectForKey:@"pcs"]);
    XCTAssertNil([field objectForKey:@"pct"]);
    XCTAssertNil([field objectForKey:@"etime"]);
    XCTAssertNil([field objectForKey:@"event"]);
    XCTAssertNil([field objectForKey:@"player"]);
    XCTAssertNil([field objectForKey:@"ad"]);
    XCTAssertNil([field objectForKey:@"roll"]);
    XCTAssertNil([field objectForKey:@"pod"]);
    XCTAssertNil([field objectForKey:@"adev"]);
    XCTAssertNil([field objectForKey:@"metrics"]);
    XCTAssertNil([field objectForKey:@"senderid"]);
    XCTAssertNil([field objectForKey:@"senderuuid"]);
    XCTAssertNil([field objectForKey:@"snederdcos"]);
    XCTAssertNil([field objectForKey:@"speed"]);
    XCTAssertNil([field objectForKey:@"screen"]);
    XCTAssertNil([field objectForKey:@"p"]);
    XCTAssertNil([field objectForKey:@"appver"]);
    XCTAssertNil([field objectForKey:@"projectid"]);
    XCTAssertNil([field objectForKey:@"snsflg"]);
    XCTAssertNil([field objectForKey:@"u1"]);
    XCTAssertNil([field objectForKey:@"u2"]);
    XCTAssertNil([field objectForKey:@"u3"]);
    XCTAssertNil([field objectForKey:@"u4"]);
    XCTAssertNil([field objectForKey:@"u5"]);
    XCTAssertNil([field objectForKey:@"u6"]);
    XCTAssertNil([field objectForKey:@"u7"]);
    XCTAssertNil([field objectForKey:@"u8"]);
    XCTAssertNil([field objectForKey:@"u9"]);
    XCTAssertNil([field objectForKey:@"ptag"]);
    XCTAssertNil([field objectForKey:@"hci"]);
    XCTAssertNil([field objectForKey:@"hca"]);
    XCTAssertNil([field objectForKey:@"hce"]);
    XCTAssertNil([field objectForKey:@"hpc"]);
    XCTAssertNil([field objectForKey:@"hcr"]);
    XCTAssertNil([field objectForKey:@"hld"]);
    XCTAssertNil([field objectForKey:@"nodata"]);
    
    // 前提：VValuesを初期状態のままbuildしている
    // 想定：そもそもkeyが入っていない
    XCTAssertFalse([[field allKeys] containsObject:@"c"]);
    
}


@end
