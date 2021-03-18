//
//  Tests.m
//  Tests
//
//  Created by 髙橋和成 on 10/19/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EventIdentity.h"

@interface EventIdentityTests : XCTestCase

@end

@implementation EventIdentityTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// 単体でIDがユニークかテスト
- (void)testUniqueIdentity {
    XCTAssertTrue([EventIdentity new].eventIdentity != nil);
}

// 複数生成した際に重複しないかテスト
- (void)testMultiIdentity {
    EventIdentity *eid = [EventIdentity new];
    EventIdentity *eid2 = [EventIdentity new];
    XCTAssertTrue(eid.eventIdentity != eid2.eventIdentity);
}

@end
