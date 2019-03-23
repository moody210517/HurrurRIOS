//
//  ActionDelegate.h
//  Logistika
//
//  Created by BoHuang on 4/20/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#ifndef ActionDelegate_h
#define ActionDelegate_h


#endif /* ActionDelegate_h */

#import "WNAActionType.h"

@protocol ActionDelegate <NSObject>

@optional
-(void)clickAction:(WNAActionType*) action;
-(void)didSubmit:(id) obj View:(UIView*)view;
-(void)didCancel:(UIView*) view;

@end
