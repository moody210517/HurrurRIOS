//
//  ProductCellCamera.h
//  Logistika
//
//  Created by BoHuang on 4/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIComboBox.h"
#import "ActionDelegate.h"
#import "ItemModel.h"

@protocol StackSizeProtocol <NSObject>

@required
@property (strong,nonatomic) NSLayoutConstraint* cons_h;
@property (strong,nonatomic) NSLayoutConstraint* cons_w;
-(CGFloat)getHeight;

@end

@interface ProductCellCamera : UIView<UIComboBoxDelegate,StackSizeProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *imgContent;
@property (weak, nonatomic) IBOutlet UIComboBox *cbQuantity;
@property (weak, nonatomic) IBOutlet UIComboBox *cbWeight;

@property (strong,nonatomic) id<ActionDelegate> aDelegate;
@property (strong,nonatomic) ItemModel*data;
-(void)initMe:(NSDictionary*)data;

@property (weak, nonatomic) IBOutlet UIButton *btnRemove;

@property (strong,nonatomic) NSLayoutConstraint* cons_h;
@property (strong,nonatomic) NSLayoutConstraint* cons_w;

@end
