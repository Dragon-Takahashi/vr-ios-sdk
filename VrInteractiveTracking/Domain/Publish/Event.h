//
//  Event.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 2018/10/04.
//  Copyright © 2018年 VideoResearch. All rights reserved.
//

#ifndef Event_h
#define Event_h

/**
 イベントInterface
 */
@protocol Event <NSObject>
@required
- (NSString*) getEventIdentity;
- (NSDate*) occurredOn;
@end

#endif /* Event_h */
