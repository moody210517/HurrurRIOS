//
//  RescheduleDateInput.h
//  Logistika
//
//  Created by BoHuang on 7/5/18.
//  Copyright © 2018 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPopupDialog.h"
#import "DateModel.h"
#import "OrderHisModel.h"
#import "ColoredView.h"
#import "BorderTextField.h"

@interface RescheduleDateInput : ColoredView

@property (weak, nonatomic) IBOutlet BorderTextField *txtNewDate;
@property (nonatomic,strong) id<ViewDialogDelegate> aDelegate;
@property (nonatomic,strong) UIViewController*vc;
-(void)firstProcess:(NSDictionary*)data;
@property (strong, nonatomic) UIDatePicker *datePicker;

@property (strong, nonatomic) DateModel* dateModel;

@property (strong, nonatomic) OrderHisModel* data;
@property (strong, nonatomic) NSDictionary*orginal_data;
@end
