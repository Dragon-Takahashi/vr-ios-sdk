//
//  ValidationHandler.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/11/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#ifndef ValidationHandler_h
#define ValidationHandler_h

/**
 検証例外HandlerInterface
 */
@protocol ValidationHandler <NSObject>
@required

- (void)handleError:(NSString *)msg;
- (BOOL)errors;

@end


#endif /* ValidationHandler_h */
