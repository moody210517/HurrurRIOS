//
//  AutoCompleteTextField.h
//  AutoCompleteTextField
//
//  Created by Chandan on 5/6/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BorderTextField.h"
@protocol CAAutoFillDelegate;
@class CAAutoCompleteObject;

@interface CAAutoFillTextField : UIView <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray <CAAutoCompleteObject *> *dataSourceArray;
@property (nonatomic, strong) BorderTextField * txtField;
@property (nonatomic, assign) id<CAAutoFillDelegate>delegate;
@property (nonatomic,strong) UIView* viewParent;
@property (nonatomic,strong) UIScrollView* scrollParent;
@end


@protocol CAAutoFillDelegate <NSObject>
@optional
- (void) CAAutoTextFillBeginEditing:(CAAutoFillTextField *) textField;
- (void) CAAutoTextFillEndEditing:(CAAutoFillTextField *) textField;
- (BOOL) CAAutoTextFillWantsToEdit:(CAAutoFillTextField *) textField;
- (void) CAAutoTextFillDidSelectRow:(CAAutoCompleteObject *) row;

@end
