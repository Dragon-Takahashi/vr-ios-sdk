//
//  Acceptor.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/13/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#ifndef Acceptor_h
#define Acceptor_h

@protocol Acceptor <NSObject>
@required

- (BOOL)isOKWithIdentity:(NSString *)identity;

@end

#endif /* Acceptor_h */
