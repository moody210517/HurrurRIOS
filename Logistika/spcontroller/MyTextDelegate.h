//
//  MyTextDelegate.h
//  Logistika
//
//  Created by BoHuang on 5/16/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyTextDelegate : NSObject<UITextFieldDelegate>

@property (nonatomic,assign) int mode;
@property (nonatomic,assign) int length;

@property (nonatomic,strong) NSMutableArray* controllers;

-(void)addTextField:(UITextField*)textField;
-(BOOL)isValid:(NSString*)text;
@end
