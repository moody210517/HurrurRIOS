//
//  OrderFrameContainer.h
//  Logistika
//
//  Created by BoHuang on 7/11/18.
//  Copyright © 2018 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderFrameSmall.h"
#import "OrderFrameExpand.h"

@interface OrderFrameContainer : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_Container_Height;

@property (strong,nonatomic) OrderFrameSmall* vc_Small;
@property (strong,nonatomic) OrderFrameExpand* vc_Expand;

@property (strong,nonatomic) UIView* vc_Current;
@property (strong,nonatomic) NSDictionary* original_data;
-(void)addMyView:(UIView*)sender;
@end
