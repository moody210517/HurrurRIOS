//
//  PaymentViewController.m
//  Logistika
//
//  Created by BoHuang on 4/24/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "tmpPaymentViewController.h"
#import "CGlobal.h"
#import "Stripe.h"
#import "NSArray+BVJSONString.h"
#import "NetworkParser.h"
#import "AFNetworking.h"
#import "DoneViewController.h"
#import "MyTextDelegate.h"

@interface tmpPaymentViewController()<UIPickerViewDelegate,UIPickerViewDataSource> 
@property (nonatomic,strong) UIPickerView* pkWeight;
@property (nonatomic,copy) NSString* mPayment;

@property (nonatomic,strong) NSArray* PREFIXES_AMERICAN_EXPRESS;
@property (nonatomic,strong) NSArray* PREFIXES_DISCOVER;
@property (nonatomic,strong) NSArray* PREFIXES_JCB;
@property (nonatomic,strong) NSArray* PREFIXES_DINERS_CLUB;
@property (nonatomic,strong) NSArray* PREFIXES_VISA;
@property (nonatomic,strong) NSArray* PREFIXES_MASTERCARD;
@property (nonatomic,copy) NSString* AMERICAN_EXPRESS ;
@property (nonatomic,copy) NSString* DISCOVER ;
@property (nonatomic,copy) NSString* JCB ;
@property (nonatomic,copy) NSString* DINERS_CLUB ;
@property (nonatomic,copy) NSString* VISA ;
@property (nonatomic,copy) NSString* MASTERCARD ;
@property (nonatomic,copy) NSString* UNKNOWN ;

@property (nonatomic,strong) MyTextDelegate* aTextDelegate;
@property (nonatomic,strong) MyTextDelegate* textDelegate;

@end

@implementation tmpPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.view.backgroundColor = COLOR_SECONDARY_THIRD;
    // Do any additional setup after loading the view.
    
    self.aTextDelegate = [[MyTextDelegate alloc] init];
    self.txtMM.delegate = self.aTextDelegate;
    self.txtCVC.delegate = self.aTextDelegate;
    self.txtYYYY.delegate = self.aTextDelegate;
    
    MyTextDelegate* textDelegate = [[MyTextDelegate alloc] init];
    textDelegate.mode = 1;
    textDelegate.length = 16;
    self.txtCardNumber.delegate = textDelegate;
    self.textDelegate = textDelegate;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"Payment";
}
-(void)initData{
    self.PREFIXES_AMERICAN_EXPRESS = @[@"34", @"37" ];
    self.PREFIXES_DISCOVER = @[@"60", @"62", @"64", @"65" ];
    self.PREFIXES_JCB = @[@"35" ];
    self.PREFIXES_DINERS_CLUB = @[@"300", @"301", @"302",
        @"303", @"304", @"305", @"309", @"36", @"38", @"37", @"39" ];
    self.PREFIXES_VISA = @[@"4" ];
    self.PREFIXES_MASTERCARD = @[@"50", @"51", @"52",
        @"53", @"54", @"55" ];
    self.AMERICAN_EXPRESS = @"American Express";
    self.DISCOVER = @"Discover";
    self.JCB = @"JCB";
    self.DINERS_CLUB = @"Diners Club";
    self.VISA = @"Visa";
    self.MASTERCARD = @"MasterCard";
    self.UNKNOWN = @"Unknown";
    
    self.pkWeight = [[UIPickerView alloc] init];
    self.pkWeight.delegate = self;
    self.pkWeight.dataSource = self;
    UIToolbar* tb_weight = [[UIToolbar alloc] init];
    tb_weight.barStyle = UIBarStyleDefault;
    tb_weight.translucent = true;
    tb_weight.tintColor = [UIColor darkGrayColor];
    [tb_weight sizeToFit];
    UIBarButtonItem *temp1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    [tb_weight setItems:@[temp1,done1]];
    tb_weight.userInteractionEnabled = true;
    done1.tag = 200;
    
    _txtPaymentCard.inputView = self.pkWeight;
    _txtPaymentCard.inputAccessoryView = tb_weight;
    
    self.mPayment = @"Pay using Card";
    
    [_txtCardNumber addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventValueChanged];
    self.txtCardNumber.tag = 200;
}
-(void)textChanged:(UITextField*)field{
    if (field == self.txtCardNumber) {
        NSString* type = [self getType:field.text];
        if ([type isEqualToString:_VISA]) {
            self.imgCard.image = [UIImage imageNamed:@"ub_creditcard_visa.png"];
        }else if ([type isEqualToString:_MASTERCARD]) {
            self.imgCard.image = [UIImage imageNamed:@"ub_creditcard_mastercard.png"];
        }else if ([type isEqualToString:_AMERICAN_EXPRESS]) {
            self.imgCard.image = [UIImage imageNamed:@"ub_creditcard_amex.png"];
        }else if ([type isEqualToString:_DISCOVER]) {
            self.imgCard.image = [UIImage imageNamed:@"ub_creditcard_discover.png"];
        }else if ([type isEqualToString:_DINERS_CLUB]) {
            self.imgCard.image = [UIImage imageNamed:@"ub_creditcard_discover.png"];
        }
    }else if(field == self.txtYYYY){
        NSString* text = self.txtYYYY.text;
        if ([text length] == 4) {
            [_txtCVC becomeFirstResponder];
        }
    }else if(field == self.txtMM){
        NSString* text = self.txtYYYY.text;
        if ([text length] == 2) {
            [_txtYYYY becomeFirstResponder];
        }
    }
}
-(NSString*)getType:(NSString*)number{
    if ([number length]>0) {
        for (NSString*term in self.PREFIXES_AMERICAN_EXPRESS) {
            if ([number hasPrefix:term]) {
                return self.AMERICAN_EXPRESS;
            }
        }
        for (NSString*term in self.PREFIXES_DISCOVER) {
            if ([number hasPrefix:term]) {
                return self.DISCOVER;
            }
        }
        for (NSString*term in self.PREFIXES_JCB) {
            if ([number hasPrefix:term]) {
                return self.JCB;
            }
        }
        for (NSString*term in self.PREFIXES_DINERS_CLUB) {
            if ([number hasPrefix:term]) {
                return self.DINERS_CLUB;
            }
        }
        for (NSString*term in self.PREFIXES_VISA) {
            if ([number hasPrefix:term]) {
                return self.VISA;
            }
        }
        for (NSString*term in self.PREFIXES_MASTERCARD) {
            if ([number hasPrefix:term]) {
                return self.MASTERCARD;
            }
        }
    }
    return self.UNKNOWN;
}
-(void)done:(UIView*)sender{
    NSLog(@"done");
    int tag = (int)sender.tag;
    if (tag == 200) {
        //
        [self.pkWeight removeFromSuperview];
        [self.txtPaymentCard resignFirstResponder];
        NSInteger row = [self.pkWeight selectedRowInComponent:0];
        _txtPaymentCard.text = c_paymentWay[row];
        
        if (row == 0) {
            // show
            self.viewPayment.hidden = false;
        }else{
            // hide
            self.viewPayment.hidden = true;
            self.mPayment = c_paymentWay[1];
            
            curPaymentWay = self.mPayment;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return c_paymentWay.count;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return c_paymentWay[row];
}



-(id)isValidate{
    NSString* t1 = _txtCardNumber.text;
    NSString* t2 = _txtCVC.text;
    NSString* t3 = _txtMM.text;
    NSString* t4 = _txtYYYY.text;
    NSArray* array = @[t1,t2,t3,t4];
    for (NSString*t in array) {
        if ([t length] == 0) {
            return nil;
        }
    }
    
    if ([self.txtCardNumber.text length] != 16) {
        [CGlobal AlertMessage:@"Card Number should be 16 characters" Title:nil];
        return nil;
    }
    
    return [NSNumber numberWithInt:1];
}
-(void)saveCreditCard{
    STPCardParams* param = [[STPCardParams alloc]init];
    param.number = _txtCardNumber.text;
    param.cvc = _txtCVC.text;
    param.expMonth = [self.txtMM.text intValue];
    param.expYear = [self.txtYYYY.text intValue];
    
    
    int ret = [[self validateCustomerInfo] intValue];
    if (ret == 0) {
        [[STPAPIClient sharedClient] createTokenWithCard:param
                                              completion:^(STPToken *token, NSError *error) {
                                                  if (error) {
                                                      //                                           [self handleError:error];
                                                      NSLog(@"ERRRRR = %@",error);
                                                      UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Please try again"
                                                                                                       message:[NSString stringWithFormat:@"%@",error.localizedDescription]
                                                                                                      delegate:nil
                                                                                             cancelButtonTitle:@"OK"
                                                                                             otherButtonTitles:nil];
                                                      [alert show];
                                                  } else {
                                                      
                                                      //when credit card details is correct code here
                                                      // move another
                                                      [self showOrderConfirm];
                                                  }
                                              }];
    }else{
        switch (ret) {
            case 1:
            {
                [CGlobal AlertMessage:@"The CVC code that you entered is invalid" Title:nil];
                break;
            }
            case 2:
            {
                [CGlobal AlertMessage:@"The card number that you entered is invalid" Title:nil];
                break;
            }
            default:{
                [CGlobal AlertMessage:@"The card details that you entered is invalid" Title:nil];
//                if([STPCardValidator validationStateForExpirationYear:_txtYYYY.text inMonth:_txtMM.text] == STPCardValidationStateInvalid){
//                    
//                }
                break;
            }
                
        }
    }
}
- (NSNumber*)validateCustomerInfo {
    
    //2. Validate card number, CVC, expMonth, expYear
    [STPCardValidator validationStateForExpirationMonth:self.txtMM.text];
    [STPCardValidator validationStateForExpirationYear:self.txtYYYY.text inMonth:self.txtMM.text];
    NSString* type = [self getType:_txtCardNumber.text];
    if ([type isEqualToString:_VISA]) {
        if([STPCardValidator validationStateForCVC:_txtCVC.text cardBrand:STPCardBrandVisa] != STPCardValidationStateValid){
            
            return [NSNumber numberWithInt:1];
        }
        if([STPCardValidator validationStateForNumber:_txtCardNumber.text validatingCardBrand:STPCardBrandVisa] != STPCardValidationStateValid){
            return [NSNumber numberWithInt:2];
        }
    }else if ([type isEqualToString:_MASTERCARD]) {
        if([STPCardValidator validationStateForCVC:_txtCVC.text cardBrand:STPCardBrandMasterCard]!= STPCardValidationStateValid){
            return [NSNumber numberWithInt:1];
        }
        if([STPCardValidator validationStateForNumber:_txtCardNumber.text validatingCardBrand:STPCardBrandMasterCard]!= STPCardValidationStateValid){
            return [NSNumber numberWithInt:2];
        }
    }else if ([type isEqualToString:_AMERICAN_EXPRESS]) {
        if([STPCardValidator validationStateForCVC:_txtCVC.text cardBrand:STPCardBrandAmex]!= STPCardValidationStateValid){
            return [NSNumber numberWithInt:1];
        }
        if([STPCardValidator validationStateForNumber:_txtCardNumber.text validatingCardBrand:STPCardBrandAmex]!= STPCardValidationStateValid){
            return [NSNumber numberWithInt:2];
        }
    }else if ([type isEqualToString:_DISCOVER]) {
        if([STPCardValidator validationStateForCVC:_txtCVC.text cardBrand:STPCardBrandDiscover]!= STPCardValidationStateValid){
            return [NSNumber numberWithInt:1];
        }
        if([STPCardValidator validationStateForNumber:_txtCardNumber.text validatingCardBrand:STPCardBrandDiscover]!= STPCardValidationStateValid){
            return [NSNumber numberWithInt:2];
        }
    }else if ([type isEqualToString:_DINERS_CLUB]) {
        if([STPCardValidator validationStateForCVC:_txtCVC.text cardBrand:STPCardBrandDinersClub]!= STPCardValidationStateValid){
            return [NSNumber numberWithInt:1];
        }
        if([STPCardValidator validationStateForNumber:_txtCardNumber.text validatingCardBrand:STPCardBrandDinersClub]!= STPCardValidationStateValid){
            return [NSNumber numberWithInt:2];
        }
    }
    else if ([type isEqualToString:_JCB]) {
        if([STPCardValidator validationStateForCVC:_txtCVC.text cardBrand:STPCardBrandJCB]!= STPCardValidationStateValid){
            return [NSNumber numberWithInt:1];
        }
        if([STPCardValidator validationStateForNumber:_txtCardNumber.text validatingCardBrand:STPCardBrandJCB]!= STPCardValidationStateValid){
            return [NSNumber numberWithInt:2];
        }
    }else if ([type isEqualToString:_UNKNOWN]) {
        if([STPCardValidator validationStateForCVC:_txtCVC.text cardBrand:STPCardBrandUnknown]!= STPCardValidationStateValid){
            return [NSNumber numberWithInt:1];
        }
        if([STPCardValidator validationStateForNumber:_txtCardNumber.text validatingCardBrand:STPCardBrandUnknown]!= STPCardValidationStateValid){
            return [NSNumber numberWithInt:2];
        }
    }
    
    return [NSNumber numberWithInt:0];
}
- (IBAction)clickContinue:(id)sender {
    
    //    /// Procced for Payment
    //    [PayUManager proceedForPayment:self
    //                        withAmount:g_serviceModel.price
    //                    AndProductInfo:g_serviceModel.name
    //               withCompletionBlock:^(NSDictionary *paymentResponse, NSError *error, id extraParam) {
    //
    //                   __weak __typeof__(self) weakSelf = self;
    //
    //                   if (weakSelf != nil) {
    //
    //                       if (error != nil) {
    //                           [CGlobal AlertMessage:error.localizedDescription Title:nil];
    //                       } else {
    //
    //
    //                       }
    //                   }
    //               }];
    
    if (_viewPayment.isHidden == false) {
        id data = [self isValidate];
        if (data!=nil) {
            [self saveCreditCard];
        }
    }else{
        [self showOrderConfirm];
    }
}
-(void)showOrderConfirm{
    
    EnvVar* env = [CGlobal sharedId].env;
    if (env.quote) {
        if(env.mode == c_PERSONAL){
            env.order_id = g_quote_order_id;
            [self update_order:g_quote_order_id];
        }else{
            env.order_id = g_quote_order_id;
            [self update_corporate_order:g_quote_order_id];
        }
    }else{
        [self order];
    }
}
-(void)order{
    EnvVar* env = [CGlobal sharedId].env;
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    params[@"id"] = env.order_id;
    
    if (g_mode == c_PERSONAL) {
        params[@"user_id"] = env.user_id;
    }else if(g_mode == c_GUEST){
        params[@"user_id"] = @"0";
    }
    params[@"date"] = g_dateModel.date;
    params[@"time"] = g_dateModel.time;
    
    params[@"service_name"] = g_serviceModel.name;
    params[@"service_price"] = g_serviceModel.price;
    params[@"service_timein"] = g_serviceModel.time_in;
    params[@"distance"] = g_addressModel.distance;
    params[@"weight"] = [NSString stringWithFormat:@"%d",[CGlobal getTotalWeight]];
    params[@"quote_type"] = @"0";
    params[@"payment"] = self.mPayment;
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
                             ,@"d_lat":[[NSNumber numberWithDouble:g_addressModel.desLat] stringValue]
                             ,@"d_lng":[[NSNumber numberWithDouble:g_addressModel.desLng] stringValue]
                             
                             
                             ,@"duration":g_addressModel.duration
                             ,@"distance":g_addressModel.distance
                             ,@"device_id":[CGlobal getDeviceID]
                             ,@"d_phone":g_addressModel.desPhone
                             ,@"d_name":g_addressModel.desName
                             };
    
    NSArray*addressArray = @[jsonMap];
    params[@"orderaddress"] = [addressArray bv_jsonStringWithPrettyPrint:true];
    
    // here
    
    
    NSMutableArray* productsArrays = [[NSMutableArray alloc] init];
    if (g_ORDER_TYPE == g_CAMERA_OPTION) {
        //
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
        NSString* url = [NSString stringWithFormat:@"%@%@%@",g_baseUrl,BASE_URL,@"order"];
        [manager uploadImage2:params Data:images Path:url withCompletionBlock:^(NSDictionary *dict, NSError *error) {
            if (error == nil) {
                if (dict!=nil && dict[@"result"] != nil) {
                    //
                    if([dict[@"result"] intValue] == 400){
                        [CGlobal AlertMessage:@"Fail" Title:nil];
                    }else if([dict[@"result"] intValue] == 300){
                        [CGlobal AlertMessage:@"Already Exist" Title:nil];
                    }else {
                        NSString* order_id = [dict[@"order_id"] stringValue];
                        NSString* track_id = dict[@"track_id"];
                        EnvVar* env = [CGlobal sharedId].env;
                        env.order_id = order_id;
                        g_track_id = track_id;
                        //hgcneed
                        
                        UIStoryboard *ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                        DoneViewController* vc = [ms instantiateViewControllerWithIdentifier:@"DoneViewController"];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [self.navigationController pushViewController:vc animated:true];
                        });
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
    [manager ontemplateGeneralRequest2:params BasePath:BASE_URL Path:@"order" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            if (dict!=nil && dict[@"result"] != nil) {
                //
                if([dict[@"result"] intValue] == 400){
                    [CGlobal AlertMessage:@"Fail" Title:nil];
                }else if([dict[@"result"] intValue] == 300){
                    [CGlobal AlertMessage:@"Already Exist" Title:nil];
                }else {
                    NSString* order_id = [dict[@"order_id"] stringValue];
                    NSString* track_id = dict[@"track_id"];
                    EnvVar* env = [CGlobal sharedId].env;
                    env.order_id = order_id;
                    g_track_id = track_id;
                    
                    UIStoryboard *ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                    DoneViewController* vc = [ms instantiateViewControllerWithIdentifier:@"DoneViewController"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self.navigationController pushViewController:vc animated:true];
                    });
                    
                }
            }
        }else{
            NSLog(@"Error");
        }
        [CGlobal stopIndicator:self];
    } method:@"POST"];
}
-(void)update_order:(NSString*)orderid{
    EnvVar* env = [CGlobal sharedId].env;
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    params[@"id"] = orderid;
    
    params[@"user_id"] = env.user_id;
    params[@"date"] = g_dateModel.date;
    params[@"time"] = g_dateModel.time;
    
    params[@"service_name"] = g_serviceModel.name;
    params[@"service_price"] = g_serviceModel.price;
    params[@"service_timein"] = g_serviceModel.time_in;
    params[@"distance"] = g_addressModel.distance;
    
    params[@"weight"] = [NSString stringWithFormat:@"%d",[CGlobal getTotalWeight]];
    params[@"payment"] = self.mPayment;
    
    
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
                             ,@"d_lat":[[NSNumber numberWithDouble:g_addressModel.desLat] stringValue]
                             ,@"d_lng":[[NSNumber numberWithDouble:g_addressModel.desLng] stringValue]
                             ,@"d_phone":g_addressModel.desPhone
                             ,@"d_name":g_addressModel.desName
                             };
    
    NSArray*addressArray = @[jsonMap];
    params[@"orderaddress"] = [addressArray bv_jsonStringWithPrettyPrint:true];
    
    // here
    
    
    NSMutableArray* productsArrays = [[NSMutableArray alloc] init];
    if (g_ORDER_TYPE == g_CAMERA_OPTION) {
        //
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
    [manager ontemplateGeneralRequest2:params BasePath:BASE_URL_ORDER Path:@"update_order" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            if (dict!=nil && dict[@"result"] != nil) {
                //
                if([dict[@"result"] intValue] == 400){
                    [CGlobal AlertMessage:@"Fail" Title:nil];
                }else if ([dict[@"result"] intValue] == 200){
                    
                    
                    EnvVar* env = [CGlobal sharedId].env;
                    env.order_id = orderid;
                    
                    g_track_id = dict[@"track_id"];
                    
                    UIStoryboard *ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                    DoneViewController* vc = [ms instantiateViewControllerWithIdentifier:@"DoneViewController"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self.navigationController pushViewController:vc animated:true];
                    });
                }
            }
        }else{
            NSLog(@"Error");
        }
        [CGlobal stopIndicator:self];
    } method:@"POST"];
}
-(void)update_corporate_order:(NSString*)orderid{
    EnvVar* env = [CGlobal sharedId].env;
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    params[@"id"] = orderid;
    
    params[@"user_id"] = env.user_id;
    params[@"date"] = g_dateModel.date;
    params[@"time"] = g_dateModel.time;
    
    params[@"service_name"] = g_serviceModel.name;
    params[@"service_price"] = g_serviceModel.price;
    params[@"service_timein"] = g_serviceModel.time_in;
    
    params[@"payment"] = self.mPayment;
    
    NetworkParser* manager = [NetworkParser sharedManager];
    [CGlobal showIndicator:self];
    [manager ontemplateGeneralRequest2:params BasePath:BASE_URL_ORDER Path:@"update_corporate_order" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            if (dict!=nil && dict[@"result"] != nil) {
                //
                if([dict[@"result"] intValue] == 400){
                    [CGlobal AlertMessage:@"Fail" Title:nil];
                }else if ([dict[@"result"] intValue] == 200){
                    EnvVar* env = [CGlobal sharedId].env;
                    env.order_id = orderid;
                    g_track_id = dict[@"track_id"];
                    
                    UIStoryboard *ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                    DoneViewController* vc = [ms instantiateViewControllerWithIdentifier:@"DoneViewController"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self.navigationController pushViewController:vc animated:true];
                    });
                }
            }
        }else{
            NSLog(@"Error");
        }
        [CGlobal stopIndicator:self];
    } method:@"POST"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
