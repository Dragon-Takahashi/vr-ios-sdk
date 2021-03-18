//
//  Validator.h
//  VrInteractiveTracking
//
//  Created by 髙橋和成 on 11/11/18.
//  Copyright © 2018 VideoResearch. All rights reserved.
//

#ifndef Validator_h
#define Validator_h

/**
 検証抽象クラス
 
 Androidのinterfaceと同じ実装はできないので、
 iOSではprotocolという仕組みを利用して実装しています。
 
 また、Java特有のinterfaceを型として使用できる機能の代替処理として
 カテゴリとして継承した各クラスをインスタンス化するなどして対応しています。
 
 */
@protocol Validator <NSObject>
@required

- (void)validate;

@end


#endif /* Validator_h */
