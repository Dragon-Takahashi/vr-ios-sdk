//
//  StateTests.m
//  Tests
//
//  Created by 髙橋和成 on 2/26/19.
//  Copyright © 2019 VideoResearch. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "../../VrInteractiveTracking/Logic/State.h"

@interface StateTests : XCTestCase

@end

@implementation StateTests

- (void)setUp {
}

- (void)tearDown {
}

- (void)testNormal {
    State *state = [State new];
    XCTAssertTrue([state.symbol isEqualToString:[State STAND_BY]]);
}


@end
