//
//  CameraOrderTableViewCell.h
//  Logistika
//
//  Created by BoHuang on 4/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIComboBox.h"
#import "ActionDelegate.h"
#import "ItemModel.h"
#import "MyPopupDialog.h"

@interface CameraOrderTableViewCell : UITableViewCell<UIComboBoxDelegate,UIPickerViewDelegate,UIPickerViewDataSource,ViewDialogDelegate>
@property (weak, nonatomic) IBOutlet UIView *cview;
@property (weak, nonatomic) IBOutlet UIImageView *imgContent;
@property (weak, nonatomic) IBOutlet UITextField *txtQuantity;
@property (weak, nonatomic) IBOutlet UITextField *txtWeight;

@property (strong,nonatomic) id<ActionDelegate> aDelegate;

@property (strong,nonatomic) ItemModel*data;
-(void)initMe:(ItemModel*)model;

@property (weak, nonatomic) IBOutlet UIButton *btnRemove;
@property (strong, nonatomic) UIPickerView*pkWeight;
@property (strong, nonatomic) UIPickerView*pkQuantity;

@property (strong, nonatomic) MyPopupDialog*dialog;

@property (weak, nonatomic) IBOutlet UISwitch *swPackaging;

@end
