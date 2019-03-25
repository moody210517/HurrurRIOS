//
//  ReviewCameraTableViewCell.h
//  Logistika
//
//  Created by BoHuang on 4/26/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//


#import "ItemModel.h"
#import "ActionDelegate.h"
#import "MyPopupDialog.h"
#import "BaseTableViewCell.h"

@interface ReviewCameraTableViewCell : BaseTableViewCell<ViewDialogDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgContent;
@property (weak, nonatomic) IBOutlet UILabel *lblQuantity;
@property (weak, nonatomic) IBOutlet UILabel *lblWeight;

@property (strong,nonatomic) MyPopupDialog* dialog;

@property (weak, nonatomic) IBOutlet UIButton *btnImage;

//@property (strong,nonatomic) ItemModel*data;
-(void)initMe:(ItemModel*)model;
-(void)setData:(NSMutableDictionary *)data;
-(void)setFontSizeForReviewOrder:(CGFloat)fontsize;
-(CGFloat)getHeight:(CGFloat)padding Width:(CGFloat)width;
@end
