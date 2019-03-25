//
//  SelectImageCell.h
//  Logistika
//
//  Created by BoHuang on 4/20/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionDelegate.h"
#import "MyPopupDialog.h"

@interface SelectImageCell : UIView

@property (nonatomic,weak) IBOutlet UIImageView* imgContent;
@property (nonatomic,weak) IBOutlet UIButton* btnClose;

@property (strong, nonatomic) MyPopupDialog* dialog;

@property (strong, nonatomic) id<ActionDelegate> aDelegate;
@property (strong, nonatomic) NSNumber* mode;

@property (strong, nonatomic) NSString* filePath;
@property (strong, nonatomic) UIImage* image;
-(void)setStyleWithData:(NSMutableDictionary*)data Mode:(int)mode;
@end
