//
//  AddressDetailViewController.h
//  Logistika
//
//  Created by BoHuang on 4/22/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BasicViewController.h"
#import "UIUnderlinedButton.h"
#import "OrderModel.h"
#import "CAAutoFillTextField.h"
#import "CAAutoCompleteObject.h"
#import "BorderTextField.h"
#import "ColoredLabel.h"
#import "BorderView.h"

@class MultilineTextField;

@interface AddressDetailViewController : BasicViewController<UIAlertViewDelegate,CAAutoFillDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet BorderTextField *txtPickName;
@property (weak, nonatomic) IBOutlet MultilineTextField *txtPickAddress;
//@property (weak, nonatomic) IBOutlet MultilineTextField *txtPickAddress1;
@property (weak, nonatomic) IBOutlet BorderTextField *txtPickState;
@property (weak, nonatomic) IBOutlet BorderTextField *txtPickPhone;
@property (weak, nonatomic) IBOutlet BorderTextField *txtPickLandMark;
@property (weak, nonatomic) IBOutlet BorderTextField *txtPickInstruction;
@property (weak, nonatomic) IBOutlet MultilineTextField *txtDesAddress;
@property (weak, nonatomic) IBOutlet BorderTextField *txtDesState;
@property (weak, nonatomic) IBOutlet BorderTextField *txtDesLandMark;
@property (weak, nonatomic) IBOutlet BorderTextField *txtDesInstruction;
@property (weak, nonatomic) IBOutlet BorderTextField *txtDesName;

@property (weak, nonatomic) IBOutlet UIView *viewChooseFromProfile;
@property (weak, nonatomic) IBOutlet UIUnderlinedButton *btnChoose;

@property (weak, nonatomic) IBOutlet UIView *viewChooseFromProfile2;
@property (weak, nonatomic) IBOutlet UIUnderlinedButton *btnChoose2;


@property (weak, nonatomic) IBOutlet BorderTextField *txtDesPhone;


@property (copy, nonatomic) NSString* type;
@property (weak, nonatomic) IBOutlet UISwitch *swQuote;
@property (weak, nonatomic) IBOutlet UIView *viewQuote;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_Address_H1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_Address_H2;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollParent;
@property (weak, nonatomic) IBOutlet BorderTextField *txtPickArea;
@property (weak, nonatomic) IBOutlet BorderTextField *txtPickCity;
@property (weak, nonatomic) IBOutlet BorderTextField *txtPickPincode;
@property (weak, nonatomic) IBOutlet BorderTextField *txtDesArea;
@property (weak, nonatomic) IBOutlet BorderTextField *txtDesCity;
@property (weak, nonatomic) IBOutlet BorderTextField *txtDesPincode;

@property (strong, nonatomic) UIPickerView *pkPickArea;
@property (strong, nonatomic) UIPickerView *pkPickCity;
@property (strong, nonatomic) UIPickerView *pkPickPin;
@property (strong, nonatomic) UIPickerView *pkDesArea;
@property (strong, nonatomic) UIPickerView *pkDesCity;
@property (strong, nonatomic) UIPickerView *pkDesPin;

@property (strong, nonatomic) NSMutableArray *dataArea;
@property (strong, nonatomic) NSMutableArray *dataCity;
@property (strong, nonatomic) NSMutableArray *dataPin;

@property (weak, nonatomic) IBOutlet ColoredLabel *lblChooseSource;
@property (weak, nonatomic) IBOutlet ColoredLabel *lblChooseDes;
@property (weak, nonatomic) IBOutlet UIView *viewlay1;
@property (weak, nonatomic) IBOutlet UIView *viewlay2;
@property (weak, nonatomic) IBOutlet BorderView *borderview1;
@property (weak, nonatomic) IBOutlet BorderView *borderview2;
@property (weak, nonatomic) IBOutlet UIView *viewScrollBelow;
@property (weak, nonatomic) IBOutlet UILabel *lblSenderPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblReceiverPhone;

@end
