//
//  OrderBaseView.h
//  Logistika
//
//  Created by BoHuang on 6/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderHisModel.h"
#import "MyPopupDialog.h"

@interface OrderBaseView : UIView
@property (strong, nonatomic) UIViewController* vc;

-(void)orderTracking:(NSString*)orderId Employee:(NSString*)employeeId;

@property (strong, nonatomic) NSDictionary*original_data;
@property (strong, nonatomic) OrderHisModel* data;
@property (strong, nonatomic) id<ViewDialogDelegate> aDelegate;

@property (strong, nonatomic) MyPopupDialog *dialog;
@end
