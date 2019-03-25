//
//  BorderTextField.h
//  Logistika
//
//  Created by BoHuang on 6/22/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BorderTextField : UITextField<UITextFieldDelegate>


@property (nonatomic) IBInspectable NSInteger backMode;
@property (nonatomic) IBInspectable NSString* imageName;
@property (nonatomic) IBInspectable UIColor* cl_selected;
@property (nonatomic) IBInspectable UIColor* cl_normal;
@property (nonatomic) IBInspectable UIColor* cl_placeholder;

@property (nonatomic,strong) CALayer*bottomLine;

@property (nonatomic,assign) int validateMode;
@property (nonatomic,assign) int validateLength;
//@property (weak, nonatomic) IBOutlet UILabel *lblRequired;

@property (strong, nonatomic) UILabel *lblRequired;
@property (strong, nonatomic) UIView *paddingView;


-(void)addBotomLayer:(CGRect)param;
-(BOOL)isValid;
-(NSString*)getValidString:(int)output;
-(void)checkString;
@end
