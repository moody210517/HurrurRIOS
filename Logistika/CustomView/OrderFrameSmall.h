//
//  OrderFrameSmall.h
//  Logistika
//
//  Created by BoHuang on 7/11/18.
//  Copyright © 2018 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderBaseView.h"
@interface OrderFrameSmall : OrderBaseView
@property (weak, nonatomic) IBOutlet UILabel *lblOrderNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblTracking;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UIButton* btnCancel;
@property (weak, nonatomic) IBOutlet UIButton* btnReschedule;
@property (weak, nonatomic) IBOutlet UIButton* btnPos;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_Height;


-(void)firstProcess:(NSDictionary*)data;
@end
