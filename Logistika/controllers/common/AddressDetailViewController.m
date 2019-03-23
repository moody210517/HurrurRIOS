//
//  AddressDetailViewController.m
//  Logistika
//
//  Created by BoHuang on 4/22/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "AddressDetailViewController.h"
#import "PickAddressProfileViewController.h"
#import "CGlobal.h"
#import "NSArray+BVJSONString.h"
#import "NetworkParser.h"
#import "AppDelegate.h"
#import "PersonalMainViewController.h"
#import "DateTimeViewController.h"
#import "MyTextDelegate.h"
#import "TblArea.h"
#import "PickupLocationViewController.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "Logistika-Swift.h"

@interface AddressDetailViewController ()
@property (nonatomic,assign) int distance_apicalls;
@property (nonatomic,strong) MyTextDelegate * textDelegate;
@property (nonatomic,strong) AddressModel * addressModel;

@property (nonatomic,assign) int address_savestatus;
@end

@implementation AddressDetailViewController{
    IQKeyboardReturnKeyHandler* handler;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TODO: Remove this
    
    // TMP
    
//    self.txtPickLandMark.text = @"123";
//    self.txtPickPhone.text = @"9144460003";
//    
//    self.txtDesName.text = @"Test";
//    self.txtDesPhone.text = @"9144460003";
//    self.txtDesLandMark.text = @"123";
    
    // END
    if([self.type isEqualToString:@"exceed"]){
        self.lblChooseSource.text = @"Enter the address of pickup business place";
    }else{
//        self.lblChooseSource.text = @"";
    }
    
    self.view.backgroundColor = COLOR_SECONDARY_THIRD;
    self.viewScrollBelow.backgroundColor = COLOR_SECONDARY_THIRD;
    _address_savestatus = 0;
    if (g_addressModel!=nil) {
        self.addressModel = g_addressModel;
    }else{
        self.addressModel = [[AddressModel alloc] init];
    }
    
    EnvVar* env = [CGlobal sharedId].env;
    env.order_id = @"0";
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recvNoti:) name:GLOBALNOTIFICATION_ADDRESSPICKUP object:nil];
    
    if(g_isii){
        _txtPickName.text = @"sender";
        _txtPickAddress.text = @"pickadd";
//        _txtPickAddress1
        _txtPickCity.text = @"pickcity";
        _txtPickState.text = @"pickstate";
        _txtPickPincode.text = @"110041";
        _txtPickPhone.text = @"9340258895";
        _txtPickLandMark.text = @"landpick";
        _txtPickInstruction.text = @"pickinst";
        
        _txtDesName.text = @"receiver";
        _txtDesCity.text = @"city";
        _txtDesPhone.text = @"9999977777";
        _txtDesState.text = @"state";
        _txtDesAddress.text = @"address3";
        _txtDesPincode.text = @"1111111111";
        _txtDesLandMark.text = @"landmark";
        _txtDesInstruction.text = @"sss";
        _txtPickInstruction.text = @"aaww";
        _txtDesName.text = @"name";
        
//        self.addressModel.sourceLat = [@"41.822099999999999" doubleValue];
//        self.addressModel.sourceLng = [@"123.4665" doubleValue];

    }
    
    if (env.lastLogin == 0) {
        self.viewChooseFromProfile.hidden = true;
        self.viewChooseFromProfile2.hidden = true;
    }
    

    
    
    self.title = @"Address Details";
    CGFloat height_Addr = 30;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        height_Addr = 30;
    }else{
        height_Addr = 45;
    }
    NSArray* fields = @[self.txtPickAddress,self.txtPickState,self.txtPickPhone,self.txtPickLandMark,self.txtPickInstruction,self.txtDesAddress,self.txtDesState,self.txtDesLandMark,self.txtDesInstruction,self.txtPickArea,self.txtPickCity,self.txtPickPincode,self.txtDesArea,self.txtDesCity,self.txtDesPincode,self.txtDesPhone,self.txtDesName,self.txtPickName];
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect frame = CGRectMake(0, 0, screenRect.size.width-16, 30);
    for (int i=0; i<fields.count; i++) {
        if ([fields[i] isKindOfClass:[BorderTextField class]]) {
            BorderTextField*field = fields[i];
            [field addBotomLayer:frame];
            if (field == self.txtPickPhone || field == self.txtDesPhone) {
                field.validateMode = 2;
                field.validateLength = 10;
            }
        }else if([fields[i] isKindOfClass:[CAAutoFillTextField class]]){
            CAAutoFillTextField* ca = fields[i];
            [ca.txtField addBotomLayer:frame];
            ca.delegate = ca;
        }else if([fields[i] isKindOfClass:[MultilineTextField class]]){
            MultilineTextField*field = fields[i];
            CGRect tmp = frame;
            tmp.size.height = height_Addr;
            [field addBottomLayerWithParam:tmp];
        }
    }
    
    self.constraint_Address_H1.constant = height_Addr;
    self.constraint_Address_H2.constant = height_Addr;
    
//    self.txtPickPhone.delegate = self;
//    self.txtDesPhone.delegate = self;
    
    [_txtPickPhone addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_txtDesPhone addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_txtPickName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_txtDesName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.txtPickPincode setKeyboardType:UIKeyboardTypeNumberPad];
    [self.txtDesPincode setKeyboardType:UIKeyboardTypeNumberPad];
    
    NSAttributedString* attr_str = self.txtPickName.attributedPlaceholder;
    [attr_str enumerateAttributesInRange:NSMakeRange(0, [attr_str length])
                                       options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                                    usingBlock:^(NSDictionary *attributes, NSRange range, BOOL *stop) {
                                        UIColor *fgColor = [attributes objectForKey:NSForegroundColorAttributeName];
                                        self.lblSenderPhone.textColor = fgColor;
                                        self.lblReceiverPhone.textColor = fgColor;
                                        self.txtPickAddress.placeholderColor = fgColor;
                                        self.txtDesAddress.placeholderColor = fgColor;
                                        NSLog(@"attributed done");
                                    }];
    
    
//    self.txtPickLandMark.returnKeyType = UIReturnKeyDone;
    
//    handler =[[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
//    handler.delegate = self;
    
    [self showAddressDetails];
    [self hideAddressFields];
    
    [self updateHintText];
    
    self.txtPickAddress.backgroundColor = [UIColor clearColor];
    self.txtDesAddress.backgroundColor = [UIColor clearColor];
    self.viewQuote.backgroundColor = [UIColor clearColor];
    
    if(g_isii){
        
        _txtPickPhone.text =  @"+919340258895";
        _txtDesPincode.text = @"+911111111111";
    }
}
-(void)hideAddressFields{
    _txtPickArea.hidden = true;
    _txtPickCity.hidden = true;
    _txtPickState.hidden = true;
    _txtPickPincode.hidden = true;
    
    _txtDesArea.hidden = true;
    _txtDesCity.hidden = true;
    _txtDesState.hidden = true;
    _txtDesPincode.hidden = true;
    
}
-(void)dealloc{
    handler = nil;
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
        self.txtPickArea.placeholder = @"Area,Locality";
        self.pkPickArea = pkView;
        self.txtPickArea.inputView= pkView;
        
        pkView = [[UIPickerView alloc] init];
        pkView.delegate = self;
        pkView.dataSource = self;
        self.txtDesArea.placeholder = @"Area,Locality";
        self.pkDesArea = pkView;
        self.txtDesArea.inputView= pkView;
        self.dataArea = tempArray;
        
        NSInteger found = [tempArray indexOfObject:self.txtPickArea.text];
        if (found!=NSNotFound) {
            [self.pkPickArea selectRow:found inComponent:0 animated:false];
        }
        
        found = [tempArray indexOfObject:self.txtDesArea.text];
        if (found!=NSNotFound) {
            [self.pkDesArea selectRow:found inComponent:0 animated:false];
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
        self.txtPickCity.placeholder = @"City";
        self.pkPickCity = pkView;
        self.txtPickCity.inputView= pkView;
        
        pkView = [[UIPickerView alloc] init];
        pkView.delegate = self;
        pkView.dataSource = self;
        self.txtDesCity.placeholder = @"City";
        self.pkDesCity = pkView;
        self.txtDesCity.inputView= pkView;
        self.dataCity = tempArray;
        
        NSInteger found = [tempArray indexOfObject:self.txtPickCity.text];
        if (found!=NSNotFound) {
            [self.pkPickCity selectRow:found inComponent:0 animated:false];
        }
        
        found = [tempArray indexOfObject:self.txtDesCity.text];
        if (found!=NSNotFound) {
            [self.pkDesCity selectRow:found inComponent:0 animated:false];
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
        self.txtPickPincode.placeholder = @"Pincode";
        self.pkPickPin = pkView;
        self.txtPickPincode.inputView= pkView;
        
        pkView = [[UIPickerView alloc] init];
        pkView.delegate = self;
        pkView.dataSource = self;
        self.txtDesPincode.placeholder = @"Pincode";
        self.pkDesPin = pkView;
        self.txtDesPincode.inputView= pkView;
        self.dataPin = tempArray;
        
        NSInteger found = [tempArray indexOfObject:self.txtPickPincode.text];
        if (found!=NSNotFound) {
            [self.pkPickPin selectRow:found inComponent:0 animated:false];
        }
        
        found = [tempArray indexOfObject:self.txtDesPincode.text];
        if (found!=NSNotFound) {
            [self.pkDesPin selectRow:found inComponent:0 animated:false];
        }
    }
}
-(void)showAddressDetails{
    self.txtPickPhone.text = @"+91";
    self.txtDesPhone.text = @"+91";
    if (g_addressModel.desAddress!=nil) {
        _txtPickAddress.text = g_addressModel.sourceAddress;
        _txtPickCity.text = g_addressModel.sourceCity;
        _txtPickState.text = g_addressModel.sourceState;
        _txtPickPincode.text = g_addressModel.sourcePinCode;
        _txtPickPhone.text = [CGlobal getValidPhoneNumber:g_addressModel.sourcePhonoe Output:1 Prefix:@"+91" Length:10];
        _txtPickLandMark.text = g_addressModel.sourceLandMark;
        _txtPickInstruction.text = g_addressModel.sourceInstruction;
        _txtPickArea.text = g_addressModel.sourceArea;
        _txtPickName.text = g_addressModel.sourceName;
        
        
        _txtDesAddress.text = g_addressModel.desAddress;
        _txtDesCity.text = g_addressModel.desCity;
        _txtDesState.text = g_addressModel.desState;
        _txtDesPincode.text = g_addressModel.desPinCode;
        _txtDesPhone.text =  [CGlobal getValidPhoneNumber:g_addressModel.desPhone Output:1 Prefix:@"+91" Length:10];
        _txtDesLandMark.text = g_addressModel.desLandMark;
        _txtDesInstruction.text = g_addressModel.desInstruction;
        _txtDesArea.text = g_addressModel.desArea;
        _txtDesName.text = g_addressModel.desName;
        
        self.viewChooseFromProfile.hidden = true;
        self.viewChooseFromProfile2.hidden = true;
        
        if ([g_addressModel.sourceAddress length]>0 && [g_addressModel.sourceCity length]>0 && [g_addressModel.sourceState length]>0 && [g_addressModel.sourceArea length]>0) {
            _viewlay1.hidden = true;
            
            _txtPickArea.textColor = [UIColor grayColor];
            _txtPickCity.textColor = [UIColor grayColor];
            _txtPickState.textColor = [UIColor grayColor];
            _txtPickPincode.textColor = [UIColor grayColor];
        }
        
        if ([g_addressModel.desAddress length]>0 && [g_addressModel.desCity length]>0 && [g_addressModel.desState length]>0 && [g_addressModel.desArea length]>0) {
            _viewlay2.hidden = true;
            
            _txtDesArea.textColor = [UIColor grayColor];
            _txtDesCity.textColor = [UIColor grayColor];
            _txtDesState.textColor = [UIColor grayColor];
            _txtDesPincode.textColor = [UIColor grayColor];
        }

        [self updateBelowBackground];
    }
    
    
}
-(void)updateBelowBackground{
    if (self.viewlay1.hidden && self.viewlay2.hidden) {
        //self.viewScrollBelow.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.scrollParent.backgroundColor = [UIColor clearColor];
    }else{
        //self.scrollParent.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.type isEqualToString:@"exceed"]) {
        self.viewQuote.hidden = false;
    }else{
        self.viewQuote.hidden = true;
    }
    g_priceType = [[PriceType alloc] initWithDictionary:nil];
    
    self.navigationController.navigationBar.hidden = false;
    
    _txtPickArea.userInteractionEnabled = false;
    _txtPickCity.userInteractionEnabled = false;
    _txtPickState.userInteractionEnabled = false;
    _txtPickPincode.userInteractionEnabled = false;
    
    _txtDesArea.userInteractionEnabled = false;
    _txtDesCity.userInteractionEnabled = false;
    _txtDesState.userInteractionEnabled = false;
    _txtDesPincode.userInteractionEnabled = false;
    
    _txtPickAddress.userInteractionEnabled = false;
    _txtDesAddress.userInteractionEnabled = false;
    
    _txtPickAddress.textColor = [UIColor grayColor];
    _txtDesAddress.textColor = [UIColor grayColor];
    [_txtPickAddress setEditable:false];
    [_txtDesAddress setEditable:false];
    
    //self.borderview1.backgroundColor = [UIColor clearColor];
    //self.borderview2.backgroundColor = [UIColor clearColor];
    
    //self.borderview1.layer.backgroundColor = [UIColor clearColor].CGColor;
    //self.borderview2.layer.backgroundColor = [UIColor clearColor].CGColor;
    //self.borderview1.
}
-(void)recvNoti:(NSNotification*)noti{
    if(noti.object!=nil && [noti.object isKindOfClass:[NSDictionary class]]){
        NSDictionary* dict = (NSDictionary*)noti.object;
        if ([dict[@"type"] isEqualToString:@"1"]) {
            _txtPickAddress.text = dict[@"address"];
            _txtPickCity.text = dict[@"city"];
            _txtPickState.text = dict[@"state"];
            _txtPickPincode.text = dict[@"pincode"];
            _txtPickLandMark.text = dict[@"landmark"];
            _txtPickPhone.text = dict[@"phone"];
            _txtPickArea.text = dict[@"area"];
            
            
            self.viewChooseFromProfile.hidden = true;
            self.viewChooseFromProfile2.hidden = true;
            
            self.viewlay1.hidden = true;
            
            _txtPickArea.userInteractionEnabled = false;
            _txtPickCity.userInteractionEnabled = false;
            _txtPickState.userInteractionEnabled = false;
            _txtPickPincode.userInteractionEnabled = false;
            _txtPickArea.textColor = [UIColor grayColor];
            _txtPickCity.textColor = [UIColor grayColor];
            _txtPickState.textColor = [UIColor grayColor];
            _txtPickPincode.textColor = [UIColor grayColor];
            
        }else if ([dict[@"type"] isEqualToString:@"2"]){
            _txtDesAddress.text = dict[@"address"];
            _txtDesCity.text = dict[@"city"];
            _txtDesState.text = dict[@"state"];
            _txtDesPincode.text = dict[@"pincode"];
            _txtDesLandMark.text = dict[@"landmark"];
            _txtDesArea.text = dict[@"area"];
            _txtDesPhone.text = dict[@"phone"];
            
            self.viewChooseFromProfile.hidden = true;
            self.viewChooseFromProfile2.hidden = true;
            self.viewlay2.hidden = true;
            
            _txtDesArea.userInteractionEnabled = false;
            _txtDesCity.userInteractionEnabled = false;
            _txtDesState.userInteractionEnabled = false;
            _txtDesPincode.userInteractionEnabled = false;
            
            _txtDesArea.textColor = [UIColor grayColor];
            _txtDesCity.textColor = [UIColor grayColor];
            _txtDesState.textColor = [UIColor grayColor];
            _txtDesPincode.textColor = [UIColor grayColor];
        }else if ([dict[@"type"] isEqualToString:@"3"]){
            self.addressModel.sourceLat = [dict[@"lat"] doubleValue];
            self.addressModel.sourceLng = [dict[@"lng"] doubleValue];
            self.lblChooseSource.text = dict[@"location"];
            self.txtPickAddress.text = dict[@"address"];
            self.txtPickPincode.text = dict[@"pincode"];
            self.txtPickState.text = dict[@"state"];
            self.txtPickArea.text = dict[@"area"];
            self.txtPickCity.text = dict[@"city"];
            
            self.viewlay1.hidden = true;
            
            _txtPickArea.userInteractionEnabled = false;
            _txtPickCity.userInteractionEnabled = false;
            _txtPickState.userInteractionEnabled = false;
            _txtPickPincode.userInteractionEnabled = false;
            
            _txtPickArea.textColor = [UIColor grayColor];
            _txtPickCity.textColor = [UIColor grayColor];
            _txtPickState.textColor = [UIColor grayColor];
            _txtPickPincode.textColor = [UIColor grayColor];
        }else if ([dict[@"type"] isEqualToString:@"4"]){
            self.addressModel.desLat = [dict[@"lat"] doubleValue];
            self.addressModel.desLng = [dict[@"lng"] doubleValue];
            self.lblChooseDes.text = dict[@"location"];
            self.txtDesAddress.text = dict[@"address"];
            self.txtDesPincode.text = dict[@"pincode"];
            self.txtDesState.text = dict[@"state"];
            self.txtDesArea.text = dict[@"area"];
            self.txtDesCity.text = dict[@"city"];
            
            self.viewlay2.hidden = true;
            
            _txtDesArea.userInteractionEnabled = false;
            _txtDesCity.userInteractionEnabled = false;
            _txtDesState.userInteractionEnabled = false;
            _txtDesPincode.userInteractionEnabled = false;
            _txtDesArea.textColor = [UIColor grayColor];
            _txtDesCity.textColor = [UIColor grayColor];
            _txtDesState.textColor = [UIColor grayColor];
            _txtDesPincode.textColor = [UIColor grayColor];
        }
        
        [self updateBelowBackground];
    }
}
- (IBAction)clickChoose:(id)sender {
    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
    PickAddressProfileViewController* vc = [ms instantiateViewControllerWithIdentifier:@"PickAddressProfileViewController"];
    vc.type = @"1";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:vc animated:true];
    });
}
- (IBAction)clickChoose2:(id)sender {
    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
    PickAddressProfileViewController* vc = [ms instantiateViewControllerWithIdentifier:@"PickAddressProfileViewController"];
    vc.type = @"2";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:vc animated:true];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickContinue:(id)sender {
    if (_viewlay1.hidden == false || _viewlay2.hidden == false) {
        return;
    }
    AddressModel*data = [self checkInput];
    if (data!=nil) {
        g_addressModel = data;
        _address_savestatus = 1;
        EnvVar* env = [CGlobal sharedId].env;
        if (env.mode == c_CORPERATION) {
            UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
            DateTimeViewController* vc = [ms instantiateViewControllerWithIdentifier:@"DateTimeViewController"];
            [self.navigationController pushViewController:vc animated:true];
            return;
        }else if([self.type isEqualToString:@"exceed"] && env.mode == c_PERSONAL){
            if ([CGlobal isPostCode:data.sourcePinCode] && [CGlobal isPostCode:data.desPinCode]) {
                if ([_swQuote isOn]) {
                    [self order_quote];
                }else{
                    [CGlobal AlertMessage:@"Please enable Get Quote" Title:nil];
                }
            }else{
                [CGlobal AlertMessage:@"Invalid Post Code" Title:nil];
            }
        }else{
            if ([CGlobal isPostCode:data.sourcePinCode] && [CGlobal isPostCode:data.desPinCode]) {
                _distance_apicalls = 0;
                [self getDistanceWebService];
            }else{
                [CGlobal AlertMessage:@"Invalid Post Code" Title:nil];
            }
        }
    }
}
-(void)getDistanceWebService{
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    EnvVar* env = [CGlobal sharedId].env;
    params[@"user_id"] = env.user_id;
    params[@"org"] = g_addressModel.sourcePinCode;
    params[@"des"] = g_addressModel.desPinCode;
    params[@"weight"] = [NSString stringWithFormat:@"%d", [CGlobal getTotalWeight]];
    
    NetworkParser* manager = [NetworkParser sharedManager];
    [CGlobal showIndicator:self];
    [manager ontemplateGeneralRequest2:params BasePath:BASE_URL Path:@"getDistance" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            if (dict!=nil && dict[@"result"] != nil) {
                //
                if([dict[@"result"] intValue] == 200){
                    
                    
                    g_priceType.expeditied_price = [dict[@"expedited"] stringValue] ;
                    g_priceType.express_price = [dict[@"express"] stringValue];
                    g_priceType.economy_price = [dict[@"economy"] stringValue];
                    
                    
                }
                if (g_priceType.expeditied_price!=nil && [g_priceType.expeditied_price length]>0) {
                    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
                    DateTimeViewController* vc = [ms instantiateViewControllerWithIdentifier:@"DateTimeViewController"];
                    [self.navigationController pushViewController:vc animated:true];
                    [CGlobal stopIndicator:self];
                    return;
                }
            }
        }
        // error
        if (_distance_apicalls<2) {
            [self getDistanceWebService];
            return;
        }else{
            [CGlobal AlertMessage:@"Google api call failed. Retry" Title:nil];
        }
        [CGlobal stopIndicator:self];
    } method:@"POST"];
}
-(void)order_quote{
    EnvVar* env = [CGlobal sharedId].env;
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    params[@"user_id"] = env.user_id;
    params[@"weight"] = [NSString stringWithFormat:@"%d", [CGlobal getTotalWeight]];
    params[@"distance"] = @"";
    params[@"quote_type"] = @"1";
    params[@"device_id"] = [CGlobal getDeviceID];
    params[@"device_type"] = [CGlobal getDeviceName];
    
    NSDictionary*jsonMap = @{@"s_address":g_addressModel.sourceAddress
                             ,@"s_area":g_addressModel.sourceArea
                             ,@"s_city":g_addressModel.sourceCity
                             ,@"s_state":g_addressModel.sourceState
                             ,@"s_pincode":g_addressModel.sourcePinCode
                             ,@"s_phone":[NSString stringWithFormat:@"%@:%@",g_addressModel.sourcePhonoe,g_addressModel.sourceName]
                             ,@"s_landmark":g_addressModel.sourceLandMark
                             ,@"s_instruction":g_addressModel.sourceInstruction
                             ,@"s_lat":[[NSNumber numberWithDouble:g_addressModel.sourceLat] stringValue]
                             ,@"s_lng":[[NSNumber numberWithDouble:g_addressModel.sourceLng] stringValue]
                             ,@"d_address":g_addressModel.desAddress
                             ,@"d_area":g_addressModel.desArea
                             ,@"d_city":g_addressModel.desCity
                             ,@"d_state":g_addressModel.desState
                             ,@"d_pincode":g_addressModel.desPinCode
                             ,@"d_landmark":g_addressModel.desLandMark
                             ,@"d_instruction":g_addressModel.desInstruction
                             ,@"d_name":g_addressModel.desName
                             ,@"d_lat":[[NSNumber numberWithDouble:g_addressModel.desLat] stringValue]
                             ,@"d_lng":[[NSNumber numberWithDouble:g_addressModel.desLng] stringValue]
                             ,@"d_phone":g_addressModel.desPhone};
    
    NSArray*addressArray = @[jsonMap];
    params[@"orderaddress"] = [addressArray bv_jsonStringWithPrettyPrint:true];
    
    NSMutableArray* productsArrays = [[NSMutableArray alloc] init];
    if (g_ORDER_TYPE == g_CAMERA_OPTION) {

        
        NSMutableArray* images = [[NSMutableArray alloc] init];
        for (int i=0; i<g_cameraOrderModel.itemModels.count; i++) {
            ItemModel* imodel = g_cameraOrderModel.itemModels[i];
            NSData*imageData = UIImageJPEGRepresentation(imodel.image_data, 0.7);
            if (imageData!=nil) {
                [images addObject:imageData];
                continue;
            }
            imageData = UIImagePNGRepresentation(imodel.image_data);
            if (imageData!=nil) {
                [images addObject:imageData];
                continue;
            }
            
        }
        
        
        for (int i=0; i<g_cameraOrderModel.itemModels.count; i++) {
            NSMutableDictionary* cameraMap = [[NSMutableDictionary alloc] init];
            ItemModel* model = g_cameraOrderModel.itemModels[i];
            cameraMap[@"image"] = model.image;
            cameraMap[@"quantity"] = model.quantity;
            cameraMap[@"weight"] = model.weight;
            cameraMap[@"weight_value"] = [NSString stringWithFormat:@"%d",model.weight_value];
            cameraMap[@"product_type"] = [NSString stringWithFormat:@"%d", g_CAMERA_OPTION];
            cameraMap[@"package"] = model.mPackage;
            [productsArrays addObject:cameraMap];
        }
        
        //upload image
        NSArray* temp = [NSArray arrayWithArray:productsArrays];
        params[@"products"] = [temp bv_jsonStringWithPrettyPrint:true];
        
        
        
        NetworkParser* manager = [NetworkParser sharedManager];
        [CGlobal showIndicator:self];
        NSString* url = [NSString stringWithFormat:@"%@%@%@",g_baseUrl,BASE_URL,@"order_quote"];
        [manager uploadImage2:params Data:images Path:url withCompletionBlock:^(NSDictionary *dict, NSError *error) {
            if (error == nil) {
                if (dict!=nil && dict[@"result"] != nil) {
                    //
                    if([dict[@"result"] intValue] == 400){
                        [CGlobal AlertMessage:@"Thank you. A quote will be sent to your registered email address in 30 minutes. Alternatively you can check Quotes section in Menu." Title:nil];
                    }else if ([dict[@"result"] intValue] == 200){
                        NSString* order_id = dict[@"order_id"];
                        NSString* mm = [[NSBundle mainBundle] localizedStringForKey:@"quote_message" value:@"" table:nil];
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:mm delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                        alert.tag = 200;
                        [alert show];
                    }
                }
            }else{
                NSLog(@"Error");
            }
            [CGlobal stopIndicator:self];
        }];
        return;
    }else if(g_ORDER_TYPE == g_ITEM_OPTION){
        for (int i=0; i<g_itemOrderModel.itemModels.count; i++) {
            NSMutableDictionary* cameraMap = [[NSMutableDictionary alloc] init];
            ItemModel* model = g_itemOrderModel.itemModels[i];
            cameraMap[@"title"] = model.title;
            cameraMap[@"dimension"] = [model getDimetion];
            cameraMap[@"quantity"] = model.quantity;
            cameraMap[@"weight"] = model.weight;
            cameraMap[@"product_type"] = [NSString stringWithFormat:@"%d", g_ITEM_OPTION];
            cameraMap[@"package"] = model.mPackage;
            [productsArrays addObject:cameraMap];
        }
    }else if(g_ORDER_TYPE == g_PACKAGE_OPTION){
        for (int i=0; i<g_packageOrderModel.itemModels.count; i++) {
            NSMutableDictionary* cameraMap = [[NSMutableDictionary alloc] init];
            ItemModel* model = g_packageOrderModel.itemModels[i];
            cameraMap[@"title"] = model.title;
            cameraMap[@"quantity"] = model.quantity;
            cameraMap[@"weight"] = model.weight;
            cameraMap[@"product_type"] = [NSString stringWithFormat:@"%d", g_PACKAGE_OPTION];
            cameraMap[@"package"] = model.mPackage;
            [productsArrays addObject:cameraMap];
        }
    }
    NSArray* temp = [NSArray arrayWithArray:productsArrays];
    params[@"products"] = [temp bv_jsonStringWithPrettyPrint:true];
    
    NetworkParser* manager = [NetworkParser sharedManager];
    [CGlobal showIndicator:self];
    [manager ontemplateGeneralRequest2:params BasePath:BASE_URL Path:@"order_quote" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            if (dict!=nil && dict[@"result"] != nil) {
                //
                if([dict[@"result"] intValue] == 400){
                    [CGlobal AlertMessage:@"Thank you. A quote will be sent to your registered email address in 30 minutes" Title:nil];
                }else if ([dict[@"result"] intValue] == 200){
                    NSString* order_id = dict[@"order_id"];
                    NSString* mm = [[NSBundle mainBundle] localizedStringForKey:@"quote_message" value:@"" table:nil];
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:mm delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                    alert.tag = 200;
                    [alert show];
                }
            }
        }else{
            NSLog(@"Error");
        }
        [CGlobal stopIndicator:self];
    } method:@"POST"];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_address_savestatus == 0) {
        NSString* mPickAddress = _txtPickAddress.text;
        NSString* mPickCity = _txtPickCity.text;
        NSString* mPickState = _txtPickState.text;
        NSString* mPickPincode = _txtPickPincode.text;
        NSString* mPickPhone = _txtPickPhone.text;
        NSString* mPickLandMark = _txtPickLandMark.text;
        NSString* mPickInstruction = _txtPickInstruction.text;
        NSString* mPickArea = _txtPickArea.text;
        NSString* mPickName = _txtPickName.text;
        
        NSString* mDesAddress = _txtDesAddress.text;
        NSString* mDesCity = _txtDesCity.text;
        NSString* mDesState = _txtDesState.text;
        NSString* mDesPincode = _txtDesPincode.text;
        NSString* mDesPhone = _txtDesPhone.text;
        NSString* mDesLandMark = _txtDesLandMark.text;
        NSString* mDesInstruction = _txtDesInstruction.text;
        NSString* mDesName = _txtDesName.text;
        NSString* mDesArea = _txtDesArea.text;
        
        AddressModel* model = g_addressModel;
        model.sourceName = mPickName;
        model.sourceAddress = mPickAddress;
        model.sourceCity = mPickCity;
        model.sourceState = mPickState;
        model.sourcePinCode = mPickPincode;
        model.sourcePhonoe = mPickPhone;
        model.sourceLandMark = mPickLandMark;
        model.sourceInstruction = mPickInstruction;
        
        model.desAddress = mDesAddress;
        model.desCity = mDesCity;
        model.desState = mDesState;
        model.desPinCode = mDesPincode;
        model.desLandMark = mDesLandMark;
        model.desInstruction = mDesInstruction;
        model.desName = mDesName;
        
        model.sourceArea = mPickArea;
        model.desArea = mDesArea;
        model.desPhone = mDesPhone;
    }
}
-(AddressModel*)checkInput{
    NSString* mPickAddress = _txtPickAddress.text;
    NSString* mPickCity = _txtPickCity.text;
    NSString* mPickState = _txtPickState.text;
    NSString* mPickPincode = _txtPickPincode.text;
    NSString* mPickPhone = [_txtPickPhone getValidString:1];
    NSString* mPickLandMark = _txtPickLandMark.text;
    NSString* mPickInstruction = _txtPickInstruction.text;
    NSString* mPickArea = _txtPickArea.text;
    NSString* mPickName = _txtPickName.text;
    
    NSString* mDesAddress = _txtDesAddress.text;
    NSString* mDesCity = _txtDesCity.text;
    NSString* mDesState = _txtDesState.text;
    NSString* mDesPincode = _txtDesPincode.text;
    NSString* mDesPhone = [_txtDesPhone getValidString:1];
    NSString* mDesLandMark = _txtDesLandMark.text;
    NSString* mDesInstruction = _txtDesInstruction.text;
    NSString* mDesName = _txtDesName.text;
    NSString* mDesArea = _txtDesArea.text;
    
    
    NSArray* controls = @[_txtPickAddress,_txtPickCity,_txtPickState,_txtPickPincode,_txtPickPhone,
                          _txtDesAddress,_txtDesCity,_txtDesState,_txtDesPincode,_txtDesArea,_txtPickArea,_txtDesPhone,_txtPickLandMark,_txtDesLandMark,_txtDesName,_txtPickName,
                          ];
    for (UITextField*ctrl in controls) {
        NSString* label = ctrl.text;
        if ([label isEqualToString:@""]) {
            [CGlobal AlertMessage:@"Please enter all info" Title:nil];
            [ctrl becomeFirstResponder];
            return nil;
        }
    }
    if (mPickInstruction == nil) {
        mPickInstruction = @" ";
    }
    if (mPickLandMark == nil) {
        mPickLandMark = @" ";
    }
    if (mDesLandMark == nil) {
        mDesLandMark = @" ";
    }
    if (mDesArea == nil) {
        mDesArea = @" ";
    }
    if (mDesName == nil) {
        mDesName = @" ";
    }
    if (mPickName == nil) {
        mPickName = @" ";
    }
    
    if (self.addressModel.sourceLat==0||self.addressModel.sourceLng==0||self.addressModel.desLat==0||self.addressModel.desLng==0) {
        [CGlobal AlertMessage:@"Please enter all info" Title:nil];
        return nil;
    }
    
    if (![self.txtPickPhone isValid]) {
        [CGlobal AlertMessage:@"Please enter valid phone number" Title:nil];
        [self.txtPickPhone becomeFirstResponder];
        return nil;
    }
    if (![self.txtDesPhone isValid]) {
        [CGlobal AlertMessage:@"Please enter valid phone number" Title:nil];
        [self.txtDesPhone becomeFirstResponder];
        return nil;
    }
    
    AddressModel* model = [[AddressModel alloc] initWithDictionary:nil];
    model.sourceAddress = mPickAddress;
    model.sourceCity = mPickCity;
    model.sourceState = mPickState;
    model.sourcePinCode = mPickPincode;
    model.sourcePhonoe = mPickPhone;
    model.sourceLandMark = mPickLandMark;
    model.sourceInstruction = mPickInstruction;
    model.sourceName = mPickName;
    
    model.desAddress = mDesAddress;
    model.desCity = mDesCity;
    model.desState = mDesState;
    model.desPinCode = mDesPincode;
    model.desLandMark = mDesLandMark;
    model.desInstruction = mDesInstruction;
    model.desName = mDesName;
    
    model.sourceArea = mPickArea;
    model.desArea = mDesArea;
    
    model.sourceLat = self.addressModel.sourceLat;
    model.sourceLng = self.addressModel.sourceLng;
    model.desLat = self.addressModel.desLat;
    model.desLng = self.addressModel.desLng;
    model.desPhone = mDesPhone;
    
    return model;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    int tag = (int)alertView.tag;
    if (tag == 200) {
        if (buttonIndex == 0) {
            g_page_type = @"";
            // go home
            AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [delegate goHome:self];
        }
    }
}
- (void) CAAutoTextFillBeginEditing:(CAAutoFillTextField *) textField {
    
}

- (void) CAAutoTextFillEndEditing:(CAAutoFillTextField *) textField {
    
}

- (BOOL) CAAutoTextFillWantsToEdit:(CAAutoFillTextField *) textField {
    return YES;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == self.pkPickArea || pickerView == self.pkDesArea) {
        return self.dataArea.count;
    }else if (pickerView == self.pkPickCity || pickerView == self.pkDesCity) {
        return self.dataCity.count;
    }
    return self.dataPin.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == self.pkPickArea || pickerView == self.pkDesArea) {
        return self.dataArea[row];
    }else if (pickerView == self.pkPickCity || pickerView == self.pkDesCity) {
        return self.dataCity[row];
    }
    return self.dataPin[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == self.pkPickArea) {
        self.txtPickArea.text = _dataArea[row];
    }else if (pickerView == self.pkPickCity) {
        self.txtPickCity.text = _dataCity[row];
    }else if (pickerView == self.pkPickPin) {
        self.txtPickPincode.text = _dataPin[row];
    }else if (pickerView == self.pkDesArea) {
        self.txtDesArea.text = _dataArea[row];
    }else if (pickerView == self.pkDesCity) {
        self.txtDesCity.text = _dataCity[row];
    }else if (pickerView == self.pkDesPin) {
        self.txtDesPincode.text = _dataPin[row];
    }
}
- (IBAction)clickMapPickup:(id)sender {
    
    [self showAddressPicker];
//    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
//    PickupLocationViewController* vc = [ms instantiateViewControllerWithIdentifier:@"PickupLocationViewController"];
//    vc.type = @"3";
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //[self.navigationController pushViewController:vc animated:true];
//        [self presentViewController:vc animated:true completion:nil];
//    });
}
- (IBAction)clickMapDrop:(id)sender {
//    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
//    PickupLocationViewController* vc = [ms instantiateViewControllerWithIdentifier:@"PickupLocationViewController"];
//    vc.type = @"4";
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //[self.navigationController pushViewController:vc animated:true];
//        [self presentViewController:vc animated:true completion:nil];
//    });
}

-(void)showAddressPicker{
 
    
    UIViewController* vc = self;
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"ViewPhotoFull" owner:vc options:nil];
    RescheduleDateInput* view = array[1];
    [view firstProcess:@{@"vc":vc,@"model":self,@"aDelegate":vc,@"view":self}];
    
    MyPopupDialog* dialog = [[MyPopupDialog alloc] init];
    [dialog setup:view backgroundDismiss:true backgroundColor:[UIColor darkGrayColor]];
    if ([vc isKindOfClass:[OrderFrameViewController class]]) {
        OrderFrameViewController*vcc = vc;
        if(vcc.rootVC!=nil)
            [dialog showPopup:vcc.rootVC.view];
    }else{
        [dialog showPopup:vc.view];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.txtDesPhone || textField == self.txtPickPhone) {
        if (textField.text.length <= 3) {
            if (range.location < 3) {
                return NO;
            }
        }
    }
    return YES;
}
#pragma -mark textFields
-(void)textFieldDidChange:(UITextField*)textField{
    if (textField == self.txtDesPhone || textField == self.txtPickPhone) {
        [self updateHintText];
        textField.text = (textField.text.length > 13 ? [textField.text substringToIndex:13]:textField.text);
    }
    NSString *ACCEPTABLE_CHARACTERS = @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    
    if(textField == self.txtDesName ){
        NSString *mFirst = _txtDesName.text;
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        
        NSString *filtered = [[mFirst componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        _txtDesName.text = filtered;//[mFirst substringToIndex:[mFirst length] - 1];
        
    }
    
    if(textField == self.txtPickName){
        NSString *mLastName = _txtPickName.text;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        
        NSString *filtered = [[mLastName componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        _txtPickName.text = filtered;// [mLastName substringToIndex:[mLastName length] - 1];
        
        
    }
    
}
-(void)updateHintText{
    if (self.txtDesPhone.text.length>3) {
        self.lblReceiverPhone.hidden = true;
    }else{
        self.lblReceiverPhone.hidden = false;
    }
    
    if (self.txtPickPhone.text.length>3) {
        self.lblSenderPhone.hidden = true;
    }else{
        self.lblSenderPhone.hidden = false;
    }
}
@end
