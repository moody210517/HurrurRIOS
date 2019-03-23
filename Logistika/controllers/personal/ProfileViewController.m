//
//  ProfileViewController.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ProfileViewController.h"
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
#import "TblArea.h"
#import "AreaTableViewCell.h"
#import "CAAutoCompleteObject.h"
#import "TermViewController.h"

@interface ProfileViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,CAAutoFillDelegate>
@property(nonatomic,assign) BOOL isChange;
@property(nonatomic,assign) NSInteger selrow;
@property(nonatomic,strong) MyTextDelegate* textDelegate;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_btnCreate addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    _btnCreate.tag = 200;
    //
    self.scrollParent.backgroundColor = [UIColor whiteColor];
    
    
    [_btnCreate setTitle:@"SAVE CHANGES" forState:UIControlStateNormal];
    _btnCreate.tag = 201;
    self.inputData = [NSNumber numberWithInteger:1];
    [self initData:self.inputData];
    _isChange = false;
    
    MyTextDelegate* textDelegate = [[MyTextDelegate alloc] init];
    textDelegate.mode = 1;
    textDelegate.length = 10;
    self.txtPhoneNumber.delegate = textDelegate;
    self.textDelegate = textDelegate;
    
    
    
    NSArray* fields = @[self.txtFirstName,self.txtLastName,self.txtPhoneNumber,self.txtAddress,self.txtState,self.txtLandMark,self.txtEmail,self.txtPassword,self.txtRePassword,self.txtAnswer,self.txtArea,self.txtCity,self.txtPin];
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect frame = CGRectMake(0, 0, screenRect.size.width-40, 30);
    for (int i=0; i<fields.count; i++) {
        if ([fields[i] isKindOfClass:[BorderTextField class]]) {
            BorderTextField*field = fields[i];
            [field addBotomLayer:frame];
        }else if([fields[i] isKindOfClass:[CAAutoFillTextField class]]){
            CAAutoFillTextField* ca = fields[i];
            [ca.txtField addBotomLayer:frame];
            ca.txtField.delegate = ca;
        }
    }
    [self.txtPin setKeyboardType:UIKeyboardTypeNumberPad];
    
    UIFont* font = self.testFont.font;
    NSLog(@"%@",font.fontName);
    
    [_txtFirstName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_txtFirstName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}
- (IBAction)clickTerm:(id)sender {
    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
    TermViewController*vc = [ms instantiateViewControllerWithIdentifier:@"TermViewController"] ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:vc animated:true];
    });
    
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
        
        NSInteger found = [tempArray indexOfObject:self.txtArea.text];
        if (found!=NSNotFound) {
            [pkView selectRow:found inComponent:0 animated:false];
        }
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
        
        NSInteger found = [tempArray indexOfObject:self.txtCity.text];
        if (found!=NSNotFound) {
            [pkView selectRow:found inComponent:0 animated:false];
        }
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
        
        NSInteger found = [tempArray indexOfObject:self.txtPin.text];
        if (found!=NSNotFound) {
            [pkView selectRow:found inComponent:0 animated:false];
        }
    }
    
}
-(void)initData:(NSMutableDictionary*)data{
    EnvVar*env = [CGlobal sharedId].env;
    NSUInteger found = [g_securityList indexOfObject:env.question];
    if (found!=NSNotFound) {
        self.selrow = found;
        self.lblPicker1.text = g_securityList[found];
    }else{
        self.selrow = 0;
        self.lblPicker1.text = g_securityList[0];
    }
    self.txtAnswer.text = env.answer;
    self.txtFirstName.text = env.first_name;
    self.txtLastName.text = env.last_name;
    self.txtPhoneNumber.text = env.phone;
    self.txtAddress.text = env.address1;
    self.txtArea.text = env.address2;
    self.txtCity.text = env.city;
    self.txtState.text = env.state;
    self.txtPin.text = env.pincode;
    self.txtLandMark.text = env.landmark;
    if (env.mode == c_CORPERATION) {
        self.txtEmail.text = env.cor_email;
        self.txtPassword.text = env.cor_password;
        self.txtRePassword.text = env.cor_password;
    }else{
        self.txtEmail.text = env.email;
        self.txtPassword.text = env.password;
        self.txtRePassword.text = env.password;
    }
    
    NSArray* controls = @[self.txtFirstName,self.txtLastName,self.txtPhoneNumber,self.txtAddress,self.txtState,self.txtLandMark,self.txtEmail,self.txtPassword,self.txtRePassword,self.txtAnswer];
    for (UITextField*text in controls) {
        [text addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    self.txtPhoneNumber.userInteractionEnabled = false;
    self.txtPhoneNumber.textColor = [UIColor grayColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"Profile";
    self.navigationController.navigationBar.hidden = false;
}
-(void)textChange:(UITextField*)field{
    self.isChange = true;
}
-(NSMutableDictionary*)checkInput{
    NSString* mFirst = _txtFirstName.text;
    NSString* mLast = _txtLastName.text;
    NSString* mPhone = _txtPhoneNumber.text;
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
        NSString* label = ctrl.text;
        if ([label isEqualToString:@""]) {
            [CGlobal AlertMessage:@"Please enter all info" Title:nil];
            [ctrl becomeFirstResponder];
            return nil;
        }
    }
    
    // check special
    if (![CGlobal validatePassword:mPassword]) {
        [CGlobal AlertMessage:@"Password must be minmium 8 characters with a combo of alphanumeric characters" Title:nil];
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
    
    if (![CGlobal isValidEmail:mEmail]) {
        [CGlobal AlertMessage:@"Invalid Email" Title:nil];
        [_txtEmail becomeFirstResponder];
        return nil;
    }
    
//    if ([self.txtPhoneNumber.text length] != 10) {
//        [CGlobal AlertMessage:@"Phone Number should be 10 characters" Title:nil];
//        return nil;
//    }
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
                                 ,@"address2":mArea
                                 ,@"city":mCity
                                 ,@"state":mState
                                 ,@"pincode":mPinCode
                                 ,@"landmark":mLandMark
                                 ,@"id":env.address_id};
        NSArray*addressArray = @[jsonMap];
        data[@"address"] = [addressArray bv_jsonStringWithPrettyPrint:true];
    }
    
    
    
    
    return data;
}
-(void)clickView:(UIView*)sender{
    int tag = (int)sender.tag;
    switch (tag) {
        
        case 201:{
            _isChange = true;
            NSMutableDictionary* data = [self checkInput];
            if (data != nil && _isChange) {
                EnvVar* env = [CGlobal sharedId].env;
                if (env.mode == c_PERSONAL) {
                    data[@"id"] = env.user_id;
                }else{
                    data[@"id"] = env.corporate_user_id;
                }
                
                
                NetworkParser* manager = [NetworkParser sharedManager];
                [CGlobal showIndicator:self];
                [manager ontemplateGeneralRequest2:data BasePath:BASE_URL Path:@"update" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
                    if (error == nil) {
                        // succ
                        NSString* ret = @"";
                        if ([dict[@"result"] isKindOfClass:[NSNumber class]]) {
                            ret = [dict[@"result"] stringValue];
                        }else{
                            ret = dict[@"result"];
                        }
                        if ([ret isEqualToString:@"400"]) {
                            //
                            [CGlobal AlertMessage:@"Fail" Title:nil];
                            [CGlobal stopIndicator:self];
                            return;
                        }
                        
                        TblUser* user = [[TblUser alloc] initWithDictionary:dict];
                        EnvVar* env = [CGlobal sharedId].env;
                        
                        [user saveResponse:env.mode Password:_txtPassword.text];
                        
                        [CGlobal AlertMessage:@"Changes updated successfully" Title:nil];
                        self.isChange = false;
                    }else{
                        // error
                        [CGlobal AlertMessage:@"Fail" Title:nil];
                    }
                    
                    [CGlobal stopIndicator:self];
                } method:@"POST"];
            }
            break;
        }
        default:
            break;
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
        
        [valuePicker selectRow:self.selrow inComponent:0 animated:false];
        
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
    _isChange = true;
}

- (void) CAAutoTextFillBeginEditing:(CAAutoFillTextField *) textField {
    
}

- (void) CAAutoTextFillEndEditing:(CAAutoFillTextField *) textField {
    
}

- (BOOL) CAAutoTextFillWantsToEdit:(CAAutoFillTextField *) textField {
    return YES;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


-(void)textFieldDidChange:(UITextField*)textField{
    
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

@end
