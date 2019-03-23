//
//  PaymentViewController.m
//  Logistika
//
//  Created by BoHuang on 4/24/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "PaymentViewController.h"
#import "CGlobal.h"
#import "Stripe.h"
#import "NSArray+BVJSONString.h"
#import "NetworkParser.h"
#import "AFNetworking.h"
#import "DoneViewController.h"
#import "MyTextDelegate.h"
#import "BorderTextField.h"

@interface PaymentViewController()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) UIPickerView* pkWeight;
@property (nonatomic,copy) NSString* mPayment;

@end

@implementation PaymentViewController

// MARK: Properties

int selectedRow = 2;
bool isPaymentCompleted = false;

// MARK: Defaults

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    
    self.view.backgroundColor = COLOR_SECONDARY_THIRD;
    // Do any additional setup after loading the view.
    
    EnvVar *env = [CGlobal sharedId].env;
    NSString *phone = [CGlobal getValidPhoneNumber:g_addressModel.sourcePhonoe Output:0 Prefix:@"+91" Length:10];
    
    if (env.mode == c_GUEST) {
        phone = [CGlobal getValidPhoneNumber:g_addressModel.sourcePhonoe Output:0 Prefix:@"+91" Length:10];
    } else {
        phone = [CGlobal getValidPhoneNumber:env.phone Output:0 Prefix:@"+91" Length:10];
    }
    NSLog(@"phone = %@",phone);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"Payment";
    
}

-(void)initData{
    
    EnvVar* env = [CGlobal sharedId].env;
    if (env.quote) {
        c_paymentWay = @[@"Pay using Card",
                         @"Net Banking"];
        selectedRow = 0;
    }else{
        c_paymentWay = @[@"Pay using Card",
                         @"Net Banking",
                         @"Cash on Pick up"];
        selectedRow = 2;
    }
    
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
    
    self.txtPaymentCard.inputView = self.pkWeight;
    self.txtPaymentCard.inputAccessoryView = tb_weight;
    
    self.mPayment = c_paymentWay[selectedRow];
    self.txtPaymentCard.text = self.mPayment;
    
    /// Adding target to select payment options
    [self.txtPaymentCard addTarget:self action:@selector(txtPaymentCardDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
}

-(void)txtPaymentCardDidBeginEditing:(UIView*)sender {
    
    [self.txtPaymentCard becomeFirstResponder];
    [self.pkWeight selectRow:selectedRow inComponent:0 animated:true];
}

-(void)done:(UIView*)sender{
    
    [self.pkWeight removeFromSuperview];
    [self.txtPaymentCard resignFirstResponder];
    NSInteger row = [self.pkWeight selectedRowInComponent:0];
    
    selectedRow = (int) row;
    self.mPayment = c_paymentWay[row];
    self.txtPaymentCard.text = c_paymentWay[row];
    curPaymentWay = self.mPayment;
    
    /*
    if (row == 0 || row == 1) {
        // show
        
     
        
    }else{
        // hide
        
        selectedRow = (int) row;
        self.mPayment = c_paymentWay[row];
        self.txtPaymentCard.text = c_paymentWay[row];
        curPaymentWay = self.mPayment;
    }
     */
}

-(void)goOnlinePayment{
    EnvVar *env = [CGlobal sharedId].env;
    
    NSString *email = @"";
    NSString *phone = [CGlobal getValidPhoneNumber:g_addressModel.sourcePhonoe Output:0 Prefix:@"+91" Length:10];
    
    if (env.mode == c_GUEST) {
        email = g_guestEmail;
        phone = [CGlobal getValidPhoneNumber:g_addressModel.sourcePhonoe Output:0 Prefix:@"+91" Length:10];
    } else {
        if (env.mode == c_PERSONAL) {
            email = env.email;
        }else if (env.mode == c_CORPERATION) {
            email = env.cor_email;
        }else  {
            return;
        }
        
        phone = [CGlobal getValidPhoneNumber:env.phone Output:0 Prefix:@"+91" Length:10];
    }
    
    /// Procced for Payment
    double price = [g_serviceModel.price doubleValue];
    g_serviceModel.price = [NSString stringWithFormat:@"%.02f",price];
    
 
    
    [PayUManager proceedForPayment:self
                        withAmount:g_serviceModel.price
                             email:email
                            mobile:phone
                         firstName:env.first_name
                    AndProductInfo:g_serviceModel.name
                   isForNetbanking: (selectedRow == 1)
               withCompletionBlock:^(NSDictionary *paymentResponse, NSError *error, id extraParam) {
                   
                   __weak __typeof__(self) weakSelf = self;
                   
                   if (weakSelf != nil) {
                       
                       if (error != nil) {
                           [CGlobal AlertMessage:error.localizedDescription Title:nil];
                       } else {
                           
                           NSString *message;
                           NSString *paymentId;
                           if ([paymentResponse objectForKey:@"result"] && [[paymentResponse objectForKey:@"result"] isKindOfClass:[NSDictionary class]] ) {
                               
                               message = [[paymentResponse objectForKey:@"result"] valueForKey:@"error_Message"];
                               paymentId = [[paymentResponse objectForKey:@"result"] valueForKey:@"paymentId"];
                               
                               if ([message isEqual:[NSNull null]] || [message length] == 0 || [message isEqualToString:@"No Error"]) {
                                   //[self showOrderConfirm];
                                   UIStoryboard *ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                                   DoneViewController* vc = [ms instantiateViewControllerWithIdentifier:@"DoneViewController"];
                                   vc.mPayment  = self.mPayment;
                                   vc.transaction_id = paymentId;
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       [self.navigationController pushViewController:vc animated:false];
                                   });
                               }else{
                                 [CGlobal AlertMessage:@"We regret to inform you that your transaction with HurryR has failed." Title:nil];
                               }
                           }
                           

                          
                           
                       }
                   }
               }];
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


-(IBAction)clickContinue:(id)sender {
    if (selectedRow == 2) {
        [self showOrderConfirm];
    }else{
        [self goOnlinePayment];
    }
}

-(void)showOrderConfirm{
    
    self.mPayment = c_paymentWay[selectedRow];
    self.txtPaymentCard.text = c_paymentWay[selectedRow];
    curPaymentWay = c_paymentWay[selectedRow];
    
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
    
    params[@"transaction_id"] = @"0";
    params[@"id"] = env.order_id;
    
    NSString*duration = @"";
    if (g_mode == c_PERSONAL) {
        params[@"user_id"] = env.user_id;
    }else if(g_mode == c_GUEST){
        params[@"user_id"] = @"0";
    }
    if (g_mode == c_GUEST) {
        duration = eamil_guest;
    }else{
        duration = g_addressModel.duration;
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
                             
                             
                             ,@"duration":duration
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
            
           
            
        NSData*data = UIImageJPEGRepresentation(imodel.image_data, 1);
            NSData*imageData ;
            
            if([data length] > 1024000){
                 imageData = UIImageJPEGRepresentation(imodel.image_data, 0.4);
            }else{
                imageData = UIImageJPEGRepresentation(imodel.image_data, 0.7);
            }
           
            
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
        
        params[@"products"] = [[[NSArray alloc] init] bv_jsonStringWithPrettyPrint:true];
        params[@"products"] = [temp bv_jsonStringWithPrettyPrint:true];
        
        NetworkParser* manager = [NetworkParser sharedManager];
        [CGlobal showIndicator:self];
        NSString* url = [NSString stringWithFormat:@"%@%@%@",g_baseUrl,BASE_URL,@"order"];
        
        [manager uploadImage2:params Data:images Path:url withCompletionBlock:^(NSDictionary *dict, NSError *error) {
            NSMutableDictionary* preserveParams = params;
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
                        vc.mPayment = @"";
                        vc.transaction_id = @"0";
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
                     vc.mPayment = @"";
                    vc.transaction_id = @"0";
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
    
    params[@"transaction_id"] = @"0";
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
                    vc.mPayment = @"";
                    vc.transaction_id = @"0";
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
                    vc.mPayment = @"";
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
