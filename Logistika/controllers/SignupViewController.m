//
//  SignupViewController.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "SignupViewController.h"
#import "CGlobal.h"
#import "NSArray+BVJSONString.h"
#import "NSDictionary+BVJSONString.h"
#import "NetworkParser.h"
#import "TblAddress.h"
#import "TblUser.h"
#import "PersonalMainViewController.h"
#import "MyNavViewController.h"
#import "AppDelegate.h"
#import "MyTextDelegate.h"
#import "TermViewController.h"
#import "AreaTableViewCell.h"
#import "TblArea.h"
#import "CAAutoCompleteObject.h"

@interface SignupViewController ()<UIComboBoxDelegate,UIPickerViewDelegate,UIPickerViewDataSource,CAAutoFillDelegate>
@property(nonatomic,assign) BOOL isChange;
@property(nonatomic,assign) NSInteger selrow;
@property(nonatomic,strong) MyTextDelegate* textDelegate;

@property(nonatomic,strong) NSMutableArray* area_item;
@property(nonatomic,strong) NSMutableArray* area_item1;
@property(nonatomic,strong) NSMutableArray* area_item2;
@end

@implementation SignupViewController
- (IBAction)swBusiness:(id)sender {
    if([_swBusiness isOn]){
        
         [_swIndividual setOn:NO animated:NO];
        
    }else{
       [_swIndividual setOn:YES animated:NO];
    }
}
- (IBAction)swIndividual:(id)sender {
    if([_swIndividual isOn]){
       
      [_swBusiness setOn:NO animated:NO];
    }else{
          [_swBusiness setOn:YES animated:NO];
        
        
    }
}
- (IBAction)clickOptResend:(id)sender {
    [self sendPhone:self.txtPhoneNumber.text];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [_btnCreate addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    _btnCreate.tag = 200;
    //
    [_btnCreate setTitle:@"CREATE" forState:UIControlStateNormal];
    _btnCreate.tag = 200;
    
    [_btnTerms addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    _btnTerms.tag = 300;
    
    self.selrow = 0;
    self.lblPicker1.text = g_securityList[0];
    
//    MyTextDelegate* textDelegate = [[MyTextDelegate alloc] init];
//    textDelegate.mode = 1;
//    textDelegate.length = 10;
//    self.txtPhoneNumber.delegate = textDelegate;
//    self.textDelegate = textDelegate;
    
    
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
//    g_areaData = [[LoginResponse alloc] init];
    
    
    NSArray* fields = @[self.txtFirstName,self.txtLastName,self.txtPhoneNumber,self.txtAddress,self.txtState,self.txtLandMark,self.txtEmail,self.txtPassword,self.txtRePassword,self.txtAnswer,self.txtArea,self.txtCity,self.txtPin,self.txtOtpCode];
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect frame = CGRectMake(0, 0, screenRect.size.width-40, 30);
    for (int i=0; i<fields.count; i++) {
        if ([fields[i] isKindOfClass:[BorderTextField class]]) {
            BorderTextField*field = fields[i];
            [field addBotomLayer:frame];
            if (field == self.txtPhoneNumber) {
                field.validateMode = 2;
                field.validateLength = 10;
            }
        }else if([fields[i] isKindOfClass:[CAAutoFillTextField class]]){
            CAAutoFillTextField* ca = fields[i];
            [ca.txtField addBotomLayer:frame];
            ca.txtField.delegate = ca;
        }
    }
    [self.txtPin setKeyboardType:UIKeyboardTypeNumberPad];
    
    
    self.txtPhoneNumber.text = @"+91";
    self.txtPhoneNumber.placeholder = @"Phone Number";
    self.txtOtpCode.placeholder = @"Otp Code";
    self.lblReceiverPhone.text = @"Phone Number";
    [self.txtOtpCode setKeyboardType:UIKeyboardTypeNumberPad];
    self.txtOtpCode.hidden = true;
    
    NSAttributedString* attr_str = self.txtEmail.attributedPlaceholder;
    [attr_str enumerateAttributesInRange:NSMakeRange(0, [attr_str length])
                                 options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                              usingBlock:^(NSDictionary *attributes, NSRange range, BOOL *stop) {
                                  UIColor *fgColor = [attributes objectForKey:NSForegroundColorAttributeName];
                                  self.lblReceiverPhone.textColor = fgColor;
                              }];
    
    
    [self.txtPhoneNumber addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.txtFirstName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [self.txtLastName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self updateHintText];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"Create Profile";
}
-(void)setAreaDatas{
    
    if (true) {//g_areaData.area.count > 0
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (int i = 0; i<g_areaData.area.count; i++) {
            TblArea* item = g_areaData.area[i];
            [tempArray addObject:item.title];
        }
        UIPickerView* pkView = [[UIPickerView alloc] init];
        pkView.delegate = self;
        pkView.dataSource = self;
        self.txtArea.placeholder = @"Area,Locality";
        self.pkArea = pkView;
        self.txtArea.inputView= pkView;
        self.dataArea = tempArray;
    }
    
    if (true) {//g_areaData.area.count > 0
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (int i = 0; i<g_areaData.city.count; i++) {
            TblArea* item = g_areaData.city[i];
            [tempArray addObject:item.title];
        }
        UIPickerView* pkView = [[UIPickerView alloc] init];
        pkView.delegate = self;
        pkView.dataSource = self;
        self.txtCity.placeholder = @"City";
        self.pkCity = pkView;
        self.txtCity.inputView= pkView;
        self.dataCity = tempArray;
    }
    
    if (true) {//g_areaData.area.count > 0
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (int i = 0; i<g_areaData.pincode.count; i++) {
            TblArea* item = g_areaData.pincode[i];
            [tempArray addObject:item.title];
        }
        UIPickerView* pkView = [[UIPickerView alloc] init];
        pkView.delegate = self;
        pkView.dataSource = self;
        self.txtPin.placeholder = @"Pincode";
        self.pkPin = pkView;
        self.txtPin.inputView= pkView;
        self.dataPin = tempArray;
    }
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
}
-(void)textChange:(UITextField*)field{
    self.isChange = true;
}
-(NSMutableDictionary*)checkInput{
    
    NSString* mBusinessType = @"0";
    if([_swBusiness isOn])
        mBusinessType = @"1";
    NSString* mFirst = _txtFirstName.text;
    NSString* mLast = _txtLastName.text;
    NSString* mPhone = [CGlobal getValidPhoneNumber:_txtPhoneNumber.text Output:1 Prefix:@"+91" Length:10];
    NSString* mAddress1 = _txtAddress.text;
    //    NSString* mAddress2 = _txtad.text;
    NSString* mCity = _txtCity.text;
    NSString* mState = _txtState.text;
    NSString* mPinCode = _txtPin.text;
    NSString* mLandMark = _txtLandMark.text;
    NSString* mEmail = _txtEmail.text;
    NSString* mPassword = _txtPassword.text;
    NSString* mConfirmPassword = _txtRePassword.text;
    NSString* mAnswer = _txtAnswer.text;
    NSString* mArea = _txtArea.text;
    
    NSArray* ctrls = @[_txtFirstName,_txtLastName,_txtPhoneNumber,_txtAddress,_txtCity,_txtState,_txtPin,_txtLandMark,_txtEmail,_txtPassword,_txtRePassword,_txtAnswer,_txtArea];
    for (UITextField*ctrl in ctrls) {
        NSString*label = ctrl.text;
        if ([label isEqualToString:@""]) {
            [CGlobal AlertMessage:@"Please enter all info" Title:nil];
            [ctrl becomeFirstResponder];
            return nil;
        }
    }
    
    // check special
    if (![CGlobal validatePassword:mPassword]) {
        [CGlobal AlertMessage:@"Password must be minimum 8 characters with a combo of alphanumeric characters" Title:nil];
        [_txtPassword becomeFirstResponder];
        return nil;
    }
    if (![mPassword isEqualToString:mConfirmPassword]) {
        [CGlobal AlertMessage:@"Password doesn't match" Title:nil];
        [_txtPassword becomeFirstResponder];
        return nil;
    }
    if (![CGlobal isPostCode:mPinCode]) {
        [CGlobal AlertMessage:@"Invalid Post Code" Title:nil];
        [_txtPin becomeFirstResponder];
        return nil;
    }
    
   
    
//    if ([self.txtPhoneNumber.text length] != 10) {
//        [CGlobal AlertMessage:@"Phone Number should be 10 characters" Title:nil];
//        return nil;
//    }
    if (![self.swTerm isOn]) {
        _swTermView.borderWidth = 1;
        return nil;
    }else{
        _swTermView.borderWidth = 0;
    }
    if (![self.swPolicy isOn]) {
        _swPolicyView.borderWidth = 1;
        return nil;
    }else{
        _swPolicyView.borderWidth = 0;
    }
    if (![CGlobal isValidEmail:mEmail]) {
        [CGlobal AlertMessage:@"Invalid Email" Title:nil];
        [_txtEmail becomeFirstResponder];
        return nil;
    }
    NSString*dp = [CGlobal encrypt:mPassword];
    NSString*usertype = @"0";
    if (self.segIndex == 0) {
        usertype = [NSString stringWithFormat:@"%d",c_PERSONAL];
    }else{
        usertype = [NSString stringWithFormat:@"%d",c_CORPERATION];
    }
    NSString*question = g_securityList[self.selrow];
    
    NSDictionary* tdata = @{@"firstName":mFirst
                            ,@"lastName":mLast
                            ,@"email":mEmail
                            ,@"password":dp
                            ,@"phone":mPhone
                            ,@"question":question
                            ,@"answer":mAnswer
                            ,@"term":@"1"
                            ,@"policy":@"1"
                            ,@"business_type":mBusinessType
                            ,@"user_type":usertype};
    NSMutableDictionary * data = [[NSMutableDictionary alloc] initWithDictionary:tdata];
    if (self.inputData == nil) {
        NSDictionary*jsonMap = @{@"address1":mAddress1
                                 ,@"address2":mArea
                                 ,@"city":mCity
                                 ,@"state":mState
                                 ,@"pincode":mPinCode
                                 ,@"landmark":mLandMark};
        NSArray*addressArray = @[jsonMap];
        data[@"address"] = [addressArray bv_jsonStringWithPrettyPrint:true];
    }else{
        EnvVar* env = [CGlobal sharedId].env;
        NSDictionary*jsonMap = @{@"address1":mAddress1
                                 ,@"address2":@""
                                 ,@"city":mCity
                                 ,@"state":mState
                                 ,@"pincode":mPinCode
                                 ,@"landmark":mLandMark
                                 ,@"id":env.address_id};
        NSArray*addressArray = @[jsonMap];
        data[@"address"] = [addressArray bv_jsonStringWithPrettyPrint:true];
    }
    
    data[@"device_type"] = [CGlobal getDeviceName];
    data[@"device_id"] = [CGlobal getDeviceID];
    
    return data;
}
-(void)clickView:(UIView*)sender{
    

    
    int tag = (int)sender.tag;
    switch (tag) {
        case 300:{
            UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
            TermViewController* vc =  [ms instantiateViewControllerWithIdentifier:@"TermViewController"];
            [self.navigationController pushViewController:vc animated:true];
            break;
        }
        case 200:
        {
            if (self.txtOtpCode.hidden == false) {
                if ([self.txtOtpCode.text  length]>0) {
                    // verify txtoptcode
                    [self verification:self.txtPhoneNumber.text Otp:self.txtOtpCode.text];
                    return;
                }else{
                    [CGlobal AlertMessage:@"Please enter valid OTP" Title:nil];
                    [self.txtOtpCode becomeFirstResponder];
                    return;
                }
            }else{
                if ([self.txtPhoneNumber isValid]) {
                    self.btnCreate.enabled = false;
//                    [self checkPhoneRecord:self.txtPhoneNumber.text];
                    [self sendPhone:self.txtPhoneNumber.text];
                    return;
                }else{
                    [CGlobal AlertMessage:@"Please enter a valid phone number" Title:nil];
                    [self.txtPhoneNumber becomeFirstResponder];
                    return;
                }
            }
            
//            if (![CGlobal validatePassword:self.txtPassword.text]) {
//                [CGlobal AlertMessage:@"Password must be minium 8 characters with a combo of alphanumeric characters" Title:nil];
//                [_txtPassword becomeFirstResponder];
//            }
            break;
        }
            
        default:
            break;
    }
}
//-(void)checkPhoneRecord:(NSString*)phone{
//    NSMutableDictionary* data =[[NSMutableDictionary alloc] init];
//    data[@"phone"] = phone;
//    NetworkParser* manager = [NetworkParser sharedManager];
//    [CGlobal showIndicator:self];
//    [manager ontemplateGeneralRequest2:data BasePath:BASE_DATA_URL Path:@"getOtpSignup" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
//        [CGlobal stopIndicator:self];
//        if (error == nil) {
//            if (dict!=nil && dict[@"result"] != nil) {
//                //
//                int ret = [dict[@"result"] intValue] ;
//                if (ret == 200) {
//                    if(g_isii){
//                        [self sendPhone:@"16234695657"];
//                    }else{
//                        [self sendPhone:phone];
//                    }
//
//                    return;
//                }
//            }
//        }
//        [CGlobal AlertMessage:@"Phone Number is already registered" Title:nil];
//        NSLog(@"Error");
//        _btnCreate.enabled = true;
//    } method:@"POST"];
//}
-(void)sendPhone:(NSString*)phone{
    NSMutableDictionary* data =[[NSMutableDictionary alloc] init];
    data[@"phone"] = phone;
    NetworkParser* manager = [NetworkParser sharedManager];
    [CGlobal showIndicator:self];
    [manager ontemplateGeneralRequest2:data BasePath:BASE_DATA_URL Path:@"getOtpSignup" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            if (dict!=nil && dict[@"result"] != nil) {
                //
                int ret = [dict[@"result"] intValue] ;
                if (ret == 200) {
                    self.txtPhoneNumber.userInteractionEnabled = false;
                    self.txtPhoneNumber.textColor = [UIColor lightGrayColor];
                    self.txtOtpCode.hidden = false;
                    self.txtOtpCode.text = @"";
                    [self.txtOtpCode becomeFirstResponder];
                    self.btnOptResend.hidden = false;
                    
                      [CGlobal AlertMessage:@"OPT Code Sent" Title:nil];
                    
                    
                }
            }
        }else{
            [CGlobal AlertMessage:@"Phone Number is already registered" Title:nil];
            NSLog(@"Error");
        }
        [CGlobal stopIndicator:self];
        _btnCreate.enabled = true;
    } method:@"POST"];
}
-(void)verification:(NSString*)phone Otp:(NSString*)otp{
    NSMutableDictionary* data =[[NSMutableDictionary alloc] init];
    data[@"phone"] = phone;
    data[@"otp"] = otp;
    NetworkParser* manager = [NetworkParser sharedManager];
    [CGlobal showIndicator:self];
    [manager ontemplateGeneralRequest2:data BasePath:BASE_DATA_URL Path:@"otpValidation" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        [CGlobal stopIndicator:self];
        if (error == nil) {
            if (dict!=nil && dict[@"result"] != nil) {
                //
                int ret = [dict[@"result"] intValue] ;
                if (ret == 200) {
                    // success
                    [self goSignup:otp];
                    return;
                }
            }
        }
        if (g_isii) {
            [self goSignup:otp];
            return;
        }
        [CGlobal AlertMessage:@"Please enter valid OTP" Title:nil];
        NSLog(@"Error");
    } method:@"POST"];
}
-(void)goSignup:(NSString*)otp{
    NSMutableDictionary* data = [self checkInput];
    if (data != nil) {
        data[@"otp"] = otp;
        NetworkParser* manager = [NetworkParser sharedManager];
        [CGlobal showIndicator:self];
        [manager ontemplateGeneralRequest2:data BasePath:BASE_URL Path:@"register" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
            if (error == nil) {
                // succ
                NSString* ret;
                if ([dict[@"result"] isKindOfClass:[NSNumber class]]) {
                    ret = [dict[@"result"] stringValue];
                }else{
                    ret = dict[@"result"];
                }
                if ([ret isEqualToString:@"400"]) {
                    //
                    [CGlobal AlertMessage:@"Username already exists" Title:nil];
                    [CGlobal stopIndicator:self];
                    return;
                }else if ([ret isEqualToString:@"600"]) {
                    //
//                    [CGlobal AlertMessage:@"Error" Title:nil];
                    [CGlobal stopIndicator:self];
                    return;
                }else if(![ret isEqualToString:@"200"]){
                    [CGlobal stopIndicator:self];
                    return;
                }
                
                [CGlobal AlertMessage:@"Profile successfully created" Title:nil];
                
                TblUser* user = [[TblUser alloc] initWithDictionary:dict];
                [user saveResponse:_segIndex Password:_txtPassword.text];
                
                if (_segIndex == 0) {
                    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                    PersonalMainViewController*vc = [ms instantiateViewControllerWithIdentifier:@"PersonalMainViewController"] ;
                    MyNavViewController* nav = [[MyNavViewController alloc] initWithRootViewController:vc];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                        delegate.window.rootViewController = nav;
                    });
                }else{
                    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Cor" bundle:nil];
                    PersonalMainViewController*vc = [ms instantiateViewControllerWithIdentifier:@"CorMainViewController"] ;
                    MyNavViewController* nav = [[MyNavViewController alloc] initWithRootViewController:vc];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                        delegate.window.rootViewController = nav;
                    });
                }
                
            }else{
                // error
                [CGlobal AlertMessage:@"Register Fail" Title:nil];
            }
            
            [CGlobal stopIndicator:self];
        } method:@"POST"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)donePicker:(UIView*)view{
    UIPickerView* pickerview = [self.viewPickerContainer1 viewWithTag:200];
    if (pickerview!= nil) {
        self.selrow  =[pickerview selectedRowInComponent:0];
        NSString*answer = g_securityList[self.selrow];
        self.lblPicker1.text = answer;
        [self.viewPickerContainer1 removeFromSuperview];
        self.isChange = true;
    }
}
-(void)tapPickerContainer:(UITapGestureRecognizer*)gesture{
    if (gesture.view!=nil) {
        int tag = (int)gesture.view.tag;
        switch (tag) {
            case 999:
            {
                [self showPicker1:nil];
                break;
            }
            default:
                break;
        }
    }
}
- (IBAction)showPicker1:(id)sender {
    UIView* superview = [self.viewPickerContainer1 superview];
    if (superview == nil) {
        CGRect main = [UIScreen mainScreen].bounds;
        CGRect rt = self.view.frame;
        CGFloat topPadding = [UIApplication sharedApplication].statusBarFrame.size.height;
        if (self.navigationController.navigationBar!=nil && self.navigationController.navigationBar.hidden == false) {
            topPadding = self.navigationController.navigationBar.frame.size.height + topPadding;
        }
        if ([self isKindOfClass:[MenuViewController class]]) {
            MenuViewController* vc = self;
            topPadding =  vc.topBarView.constraint_Height.constant + topPadding;
        }
        rt = CGRectMake(0, topPadding, rt.size.width, rt.size.height - topPadding);
        CGFloat height = 266;
        CGFloat h_toolbar = 44;
        CGFloat h_picker = height - h_toolbar;
        CGFloat top = rt.size.height - height;
        
        self.viewPickerContainer1 = [[UIView alloc]initWithFrame:CGRectMake(0, topPadding, rt.size.width, rt.size.height)];
        
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, top, rt.size.width, h_toolbar)];
        
        
        UIBarButtonItem *temp2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicker:)];
        
        toolBar.barStyle = UIBarStyleDefault;
        toolBar.translucent = true;
        toolBar.tintColor = [UIColor darkGrayColor];
        [toolBar setItems:@[temp2,btn]];
        [self.viewPickerContainer1 addSubview:toolBar];
        
        
        UIPickerView* valuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, top+h_toolbar, rt.size.width, h_picker)];
        valuePicker.delegate=self;
        valuePicker.dataSource=self;
        valuePicker.showsSelectionIndicator=YES;
        valuePicker.tag = 200;
        valuePicker.backgroundColor = [UIColor whiteColor];
        
        [self.viewPickerContainer1 addSubview:valuePicker];
        
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPickerContainer:)];
        [self.viewPickerContainer1 addGestureRecognizer:gesture];
        self.viewPickerContainer1.tag = 999;
        
        [self.view addSubview:self.viewPickerContainer1];
    }else{
        [self.viewPickerContainer1 removeFromSuperview];
    }
    
    
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == self.pkArea) {
        return self.dataArea.count;
    }else if (pickerView == self.pkCity) {
        return self.dataCity.count;
    }else if (pickerView == self.pkPin) {
        return self.dataPin.count;
    }
    return g_securityList.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == self.pkArea) {
        return _dataArea[row];
    }else if (pickerView == self.pkCity) {
        return _dataCity[row];
    }else if (pickerView == self.pkPin) {
        return _dataPin[row];
    }
    return g_securityList[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == self.pkArea) {
        self.txtArea.text = _dataArea[row];
    }else if (pickerView == self.pkCity) {
        self.txtCity.text = _dataCity[row];
    }else if (pickerView == self.pkPin) {
        self.txtPin.text = _dataPin[row];
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void) CAAutoTextFillBeginEditing:(CAAutoFillTextField *) textField {
    
}

- (void) CAAutoTextFillEndEditing:(CAAutoFillTextField *) textField {
    
}

- (BOOL) CAAutoTextFillWantsToEdit:(CAAutoFillTextField *) textField {
    return YES;
}
-(void)textFieldDidChange:(UITextField*)textField{
    if (textField == self.txtPhoneNumber ) {
        [self updateHintText];
        textField.text = (textField.text.length > 13 ? [textField.text substringToIndex:13]:textField.text);
    }
    

    NSString *ACCEPTABLE_CHARACTERS = @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    
    if(textField == self.txtFirstName ){
        NSString *mFirst = _txtFirstName.text;
      
            NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
            
            NSString *filtered = [[mFirst componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            
        _txtFirstName.text = filtered;//[mFirst substringToIndex:[mFirst length] - 1];
        
    }
    
    if(textField == self.txtLastName){
         NSString *mLastName = _txtLastName.text;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        
        NSString *filtered = [[mLastName componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        _txtLastName.text = filtered;// [mLastName substringToIndex:[mLastName length] - 1];
            
        
    }
}

-(void)updateHintText{
    if (self.txtPhoneNumber.text.length>3) {
        self.lblReceiverPhone.hidden = true;
    }else{
        self.lblReceiverPhone.hidden = false;
    }
}
@end
