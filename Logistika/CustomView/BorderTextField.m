//
//  BorderTextField.m
//  Logistika
//
//  Created by BoHuang on 6/22/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BorderTextField.h"
#import "CGlobal.h"

#define ACCEPTABLE_CHARECTERS @"0123456789."
@implementation BorderTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        //[self customInit];
    }
    return self;
}
-(void)setBackMode:(NSInteger)backMode{
    switch (backMode) {
        case 2:{
            self.textColor = [CGlobal colorWithHexString:@"626262" Alpha:1.0f];
            break;
        }
        case 1:{
            // only bottom border
            if (_bottomLine==nil) {
                CALayer *border = [CALayer layer];
                CGFloat borderWidth = g_txtBorderWidth;
                border.borderColor = [UIColor darkGrayColor].CGColor;
                CGRect frame =CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
                border.frame = frame;
                border.borderWidth = borderWidth;
                [self.layer addSublayer:border];
                self.layer.masksToBounds = YES;
                
                UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
                self.leftView = paddingView;
                self.leftViewMode = UITextFieldViewModeAlways;
                
                _bottomLine = border;
                
                self.delegate = self;
            }
            
            break;
        }
        default:
        {
            break;
        }
    }
    _backMode = backMode;
}

-(void)addBotomLayer:(CGRect)param{
    if (_bottomLine!=nil) {
        [_bottomLine removeFromSuperlayer];
        _bottomLine = nil;
    }
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = g_txtBorderWidth;
    if(self.backMode==2){
//        border.borderColor = [UIColor darkGrayColor].CGColor;
        border.borderColor = [CGlobal colorWithHexString:@"#bdaaad" Alpha:1.0f].CGColor;
        
    }else if(self.backMode == 1){
        border.borderColor = self.cl_normal.CGColor;
    }else{
//        border.borderColor = [UIColor darkGrayColor].CGColor;
        border.borderColor = [CGlobal colorWithHexString:@"#bdaaad" Alpha:1.0f].CGColor;
    }
    
    CGRect frame =CGRectMake(0, param.size.height - borderWidth, param.size.width, param.size.height);
    border.frame = frame;
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
    
    if(self.backMode == 2){
        if([self.paddingView superview]!=nil){
            [self.paddingView removeFromSuperview];
        }
        if([self.lblRequired superview]!=nil){
            [self.lblRequired removeFromSuperview];
        }
        
        self.paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, param.size.height)];
        UIImageView*img = [[UIImageView alloc] init];
        [self.paddingView addSubview:img];
        img.frame = CGRectMake(2, 5, 20, 20);
        img.contentMode = UIViewContentModeScaleAspectFit;
        if (self.imageName!=nil) {
            img.image = [UIImage imageNamed:self.imageName];
        }
        self.leftView = self.paddingView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.lblRequired = [[UILabel alloc] init];
        UIFont* font = [UIFont fontWithName:@"HelveticaNeue-Italic" size:13.0f];
//        UIFont* font = [UIFont fontWithName:@"HoeflerText-Italic" size:14.0f];
        
        self.lblRequired.font = font;
        self.lblRequired.text = @"(required)";
        [self addSubview:self.lblRequired];
        self.lblRequired.frame = CGRectMake(param.size.width - 50, 5, 80, 25);
        self.lblRequired.textAlignment = NSTextAlignmentRight;
        self.lblRequired.textColor = [CGlobal colorWithHexString:@"#626262" Alpha:1.0f];
//        self.lblRequired.frame = CGRectMake(param.size.width - 80, 5, 80, 25);
        
        self.rightView = self.lblRequired;
        self.rightViewMode = UITextFieldViewModeUnlessEditing;
    }else{
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
        self.leftView = paddingView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    
    
//    self.textColor = [CGlobal colorWithHexString:@"#626262" Alpha:1.0f];
    _bottomLine = border;
    
    self.delegate = self;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (_bottomLine != nil) {
        CALayer *border = _bottomLine;
        if (self.backMode == 2) {
//            border.borderColor = COLOR_PRIMARY.CGColor;
        }else if (self.backMode == 1) {
            border.borderColor = self.cl_selected.CGColor;
        }else{
//            border.borderColor = COLOR_PRIMARY.CGColor;
        }
        
        border.borderWidth = g_txtBorderWidth;
    }
    self.lblRequired.hidden = true;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (_bottomLine != nil) {
        CALayer *border = _bottomLine;
        if (self.backMode == 2) {
//            border.borderColor = [UIColor darkGrayColor].CGColor;
        }else if (self.backMode == 1) {
            border.borderColor = self.cl_normal.CGColor;
        }else{
//            border.borderColor = [UIColor darkGrayColor].CGColor;
        }
        
        border.borderWidth = g_txtBorderWidth;
    }
    self.lblRequired.hidden = false;
}
-(void)checkString{
    switch (self.validateMode) {
        case 2:{
            NSString* tmp = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (tmp.length>0) {
                // go ahead
            }else{
                self.text = @"+91";
            }
            break;
        }
        default:{
            break;
        }
            
    }
}
-(NSString*)getValidString:(int)output{
    switch (self.validateMode) {
        case 2:
        {
            NSString* tmp = self.text;
            if (self.text.length>5) {
                if([self.text containsString:@"+91"]){
                    tmp = [self.text stringByReplacingOccurrencesOfString:@"+91" withString:@""];
                }
                tmp = [tmp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }
            if(output == 1){
                // return phone include +91
                return self.text;
            }
            // return phone exclude +91
            return tmp;
        }
        default:{
            
        }
    }
    return self.text;
}
-(BOOL)isValid{
    switch (self.validateMode) {
        case 2:
        {
            NSString* ppp = [self.text stringByReplacingOccurrencesOfString:@"+91" withString:@""];
            ppp = [ppp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (ppp.length == self.validateLength) {
                return true;
            }
        }
        default:{
            break;
        }
    }
    return false;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    switch (self.validateMode) {
        case 2:{
            if (textField.text.length <= 3) {
                if (range.location < 3) {
                    return NO;
                }
            }
            NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
            
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            
            return [string isEqualToString:filtered];
        }
        default:{
            break;
        }
            
    }
    return YES;
}
@end
