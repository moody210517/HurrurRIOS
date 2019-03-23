//
//  PreDefinedTableViewCell.h
//  Logistika
//
//  Created by BoHuang on 4/26/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"
#import "ActionDelegate.h"


@interface PreDefinedTableViewCell : UITableViewCell<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *cview;

@property (weak, nonatomic) IBOutlet UITextField *txtItem;
@property (weak, nonatomic) IBOutlet UITextField *txtQuantity;
@property (weak, nonatomic) IBOutlet UITextField *txtWeight;

@property (strong,nonatomic) id<ActionDelegate> aDelegate;
@property (strong,nonatomic) ItemModel*data;
-(void)initMe:(ItemModel*)model;

@property (weak, nonatomic) IBOutlet UIButton *btnRemove;
@property (strong, nonatomic) UIPickerView*pkItem;
@property (strong, nonatomic) UIPickerView*pkWeight;
@property (strong, nonatomic) UIPickerView*pkQuantity;
@property (weak, nonatomic) IBOutlet UISwitch *swPackage;

@end
