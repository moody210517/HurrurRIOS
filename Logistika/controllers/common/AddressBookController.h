//
//  AddressBookController.h
//  Logistika
//
//  Created by Venu Talluri on 01/01/1941 Saka.
//  Copyright © 1941 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"
#import "CAAutoFillTextField.h"
#import "CAAutoCompleteObject.h"
#import "MenuViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface AddressBookController : MenuViewController

@property(nonatomic,strong) NSMutableArray* addresses;
@property (weak, nonatomic) IBOutlet UIView *viewRoot;

@end

NS_ASSUME_NONNULL_END
