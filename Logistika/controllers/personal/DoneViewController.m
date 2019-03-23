//
//  DoneViewController.m
//  Logistika
//
//  Created by BoHuang on 4/24/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "DoneViewController.h"
#import "CGlobal.h"
#import "ReviewCameraTableViewCell.h"
#import "ReviewItemTableViewCell.h"
#import "ReviewPackageTableViewCell.h"
#import "CameraOrderViewController.h"
#import "SelectItemViewController.h"
#import "SelectPackageViewController.h"
#import "AddressDetailViewController.h"
#import "DateTimeViewController.h"
#import "PaymentViewController.h"
#import "NetworkParser.h"
#import "RescheduleViewController.h"
#import "CancelPickViewController.h"
#import "OrderHistoryViewController2.h"
#import "Logistika-Swift.h"
#import "NSArray+BVJSONString.h"

@interface DoneViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong) OrderModel* orderModel;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,strong) NSMutableDictionary* height_dict;
@property (nonatomic,assign) CGFloat totalHeight;
@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView.backgroundColor = [UIColor whiteColor];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self initView];
    EnvVar* env = [CGlobal sharedId].env;
    if(env.mode!=c_CORPERATION){
        [self showItemLists];
    }else{
        self.viewHeader.hidden = true;
        self.viewQuote_Corporate.hidden = false;
        
        QuoteCoperationModel* model = g_quoteCoperationModel;
        self.lblDeliver.text = model.ddescription;
        self.lblLoadType.text = [CGlobal getTruck:model.loadtype];
    }
    [self showAddressDetails];
    self.lblPickDate.text = [NSString stringWithFormat:@"%@ %@",g_dateModel.date,g_dateModel.time];
    self.lblServiceLevel.text = [NSString stringWithFormat:@"%@, %@%@, %@",g_serviceModel.name,symbol_dollar,g_serviceModel.price,g_serviceModel.time_in];
    UIFont* font = [UIFont boldSystemFontOfSize:_lblServiceLevel.font.pointSize];
    _lblServiceLevel.font = font;

    
    if([_mPayment isEqualToString:@""]){
        if (env.mode!= c_CORPERATION) {
            [self done_order];
        }
    }else{
        [self showOrderConfirm];
    }
    
    

    
    _lblPaymentMethod.text = [NSString stringWithFormat:@"%@", curPaymentWay];
    _lblOrderNumber.text = env.order_id;
    _lblTrackingNumber.text = g_track_id;
    
    _btnReschedule.tag = 200;
    
    if (env.mode == c_GUEST || env.mode == c_CORPERATION) {
        _viewSchedule.hidden = true;
        _viewCancel.hidden = true;
    }else{
        _viewSchedule.hidden = false;
        _viewCancel.hidden = false;
    }

    
    
    
    
    
    [self hideAddressFields];
}
-(void)calculateRowHeight{
    self.height_dict = [[NSMutableDictionary alloc] init];
    self.totalHeight = 0;
    for (int i=0; i<self.orderModel.itemModels.count; i++) {
        NSIndexPath*path = [NSIndexPath indexPathForRow:i inSection:0];
        CGFloat height = [CGlobal tableView1:self.tableView heightForRowAtIndexPath:path DefaultHeight:self.cellHeight Data:self.orderModel OrderType:g_ORDER_TYPE Padding:16 Width:0];
        NSString*key = [NSString stringWithFormat:@"%d",i];
        NSString*value = [NSString stringWithFormat:@"%f",height];
        self.height_dict[key] = value;
        self.totalHeight = self.totalHeight + height;
    }
}
-(void)hideAddressFields{
//    _lblPickAddress.hidden = true;
    _lblPickCity.hidden = true;
    _lblPickState.hidden = true;
    _lblPickPincode.hidden = true;
    
//    _lblDestArea.hidden = true;
    _lblDestCity.hidden = true;
    _lblDestState.hidden = true;
    _lblDestPincode.hidden = true;
    
    _lblPickAddress.numberOfLines = 0;
    _lblDestAddress.numberOfLines = 0;
}
- (IBAction)clickContinue:(id)sender {
    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
    PaymentViewController*vc = [ms instantiateViewControllerWithIdentifier:@"PaymentViewController"] ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:vc animated:true];
    });
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.confirmBar.caption.text = @"Order Confirmed";
}
-(void)showAddressDetails{
    
      EnvVar* env = [CGlobal sharedId].env;
    _lblOrderNumber.text = env.order_id;
    _lblTrackingNumber.text = g_track_id;
        
    if (g_addressModel.desAddress!=nil) {
        _lblPickAddress.text = g_addressModel.sourceAddress;
        _lblPickCity.text = g_addressModel.sourceCity;
        _lblPickState.text = g_addressModel.sourceState;
        _lblPickPincode.text = g_addressModel.sourcePinCode;
        _lblPickPhone.text = g_addressModel.sourcePhonoe;
        _lblPickLandMark.text = g_addressModel.sourceLandMark;
        _lblPickInst.text = g_addressModel.sourceInstruction;
        _lblPickName.text = g_addressModel.sourceName;
        
        _lblDestAddress.text = g_addressModel.desAddress;
        _lblDestCity.text = g_addressModel.desCity;
        _lblDestState.text = g_addressModel.desState;
        _lblDestPincode.text = g_addressModel.desPinCode;
        _lblDestPhone.text = g_addressModel.desPhone;
        _lblDestLandMark.text = g_addressModel.desLandMark;
        _lblDestInst.text = g_addressModel.desInstruction;
        _lblDestName.text = g_addressModel.desName;
        
        NSString* sin = [g_addressModel.sourceInstruction stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([sin length]>0) {
            _lblPickInst.text = g_addressModel.sourceInstruction;
        }else{
            _lblPickInst.hidden = true;
        }
        sin = [g_addressModel.desInstruction stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([sin length]>0) {
            _lblDestInst.text = g_addressModel.desInstruction;
        }else{
            _lblDestInst.hidden = true;
        }
    }
//    _lblDestPhone.hidden = true;
}
-(void)initView{
    
    [_btnReschedule addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [_btnCancelPick addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [_btnCall addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnReschedule.tag = 200;
    self.btnCancelPick.tag = 201;
    self.btnCall.tag = 202;
}
-(void)clickView:(UIView*)sender{
    int tag = (int)sender.tag;
    switch (tag) {
        case 200:
        {
            // reschedule
            UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
            OrderHistoryViewController*vc = [ms instantiateViewControllerWithIdentifier:@"OrderHistoryViewController"] ;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                vc.param1 = 1;
                self.navigationController.navigationBar.hidden = true;
                self.navigationController.viewControllers = @[vc];
            });
            break;
        }
        case 201:{
            // cancel pickup
            UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
            OrderHistoryViewController*vc = [ms instantiateViewControllerWithIdentifier:@"OrderHistoryViewController"] ;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                vc.param1 = 1;
                self.navigationController.navigationBar.hidden = true;
                self.navigationController.viewControllers = @[vc];
            });
            
            
            break;
        }
        case 202:{
            // call
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:support_phone]];
            break;
        }
        default:
            break;
    }
}
-(void)showItemLists{
    EnvVar* env = [CGlobal sharedId].env;
    if (g_ORDER_TYPE == g_CAMERA_OPTION) {
        self.orderModel = g_cameraOrderModel;
        self.viewHeader_CAMERA.hidden = false;
        self.viewHeader_ITEM.hidden = true;
        self.viewHeader_PACKAGE.hidden = true;
        
        UINib* nib = [UINib nibWithNibName:@"ReviewCameraTableViewCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"cell1"];
        self.cellHeight = 40;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }else if(g_ORDER_TYPE == g_ITEM_OPTION){
        self.orderModel = g_itemOrderModel;
        self.viewHeader_CAMERA.hidden = true;
        self.viewHeader_ITEM.hidden = false;
        self.viewHeader_PACKAGE.hidden = true;
        
        UINib* nib = [UINib nibWithNibName:@"ReviewItemTableViewCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
        self.cellHeight = 40;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }else if(g_ORDER_TYPE == g_PACKAGE_OPTION){
        self.orderModel = g_packageOrderModel;
        self.viewHeader_CAMERA.hidden = true;
        self.viewHeader_ITEM.hidden = true;
        self.viewHeader_PACKAGE.hidden = false;
        
        UINib* nib = [UINib nibWithNibName:@"ReviewPackageTableViewCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"cell3"];
        self.cellHeight = 40;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    
    [self calculateRowHeight];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.constraint_TH.constant = self.totalHeight;
    [self.tableView setNeedsUpdateConstraints];
    [self.tableView layoutIfNeeded];
    return self.orderModel.itemModels.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (g_ORDER_TYPE == g_CAMERA_OPTION) {
        ReviewCameraTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        NSMutableDictionary* inputData = [[NSMutableDictionary alloc] init];
        inputData[@"vc"] = self;
        inputData[@"indexPath"] = indexPath;
        inputData[@"aDelegate"] = self;
        inputData[@"tableView"] = tableView;
        inputData[@"model"] = self.orderModel.itemModels[indexPath.row];
        
        
        [cell setData:inputData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else if(g_ORDER_TYPE == g_ITEM_OPTION){
        ReviewItemTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        [cell initMe:self.orderModel.itemModels[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.aDelegate = self;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else{
        ReviewPackageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        
        [cell initMe:self.orderModel.itemModels[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.aDelegate = self;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* key = [NSString stringWithFormat:@"%d",indexPath.row];
    if(self.height_dict[key]!=nil){
        NSString* value = self.height_dict[key];
        return [value floatValue];
    }
    return self.cellHeight;
}

-(void)done_order{
    
    [self showItemLists];
    [self showAddressDetails];
    
    EnvVar* env = [CGlobal sharedId].env;
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    params[@"order_id"] = env.order_id;
    
    NetworkParser* manager = [NetworkParser sharedManager];
    [CGlobal showIndicator:self];
    [manager ontemplateGeneralRequest2:params BasePath:BASE_URL_ORDER Path:@"done_order" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            if (dict!=nil && dict[@"result"] != nil) {
                //
                if([dict[@"result"] intValue] == 400){
                    [CGlobal AlertMessage:@"Fail" Title:nil];
                }
            }
        }else{
            NSLog(@"Error");
        }
        [CGlobal stopIndicator:self];
    } method:@"POST"];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    int tag = (int)alertView.tag;
    switch (tag) {
        case 200:
        {
            // Reschedule
            if (buttonIndex == 0) {
//                UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
//                RescheduleViewController*vc = [ms instantiateViewControllerWithIdentifier:@"RescheduleViewController"] ;
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.navigationController setViewControllers:@[vc] animated:true];
//                });
                
                UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
                OrderHistoryViewController*vc = [ms instantiateViewControllerWithIdentifier:@"OrderHistoryViewController"] ;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    vc.param1 = 1;
                    self.navigationController.navigationBar.hidden = true;
                    self.navigationController.viewControllers = @[vc];
                });
            }
            break;
        }
        case 201:{
            if (buttonIndex == 0) {
                UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
                OrderHistoryViewController*vc = [ms instantiateViewControllerWithIdentifier:@"OrderHistoryViewController"] ;
                dispatch_async(dispatch_get_main_queue(), ^{
                    vc.param1 = 1;
                    self.navigationController.navigationBar.hidden = true;
                    self.navigationController.viewControllers = @[vc];
                });
            }
            break;
        }
            
            
        default:
            break;
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


-(void)showOrderConfirm{
    
    EnvVar* env = [CGlobal sharedId].env;
    if (env.quote) {
        if(env.mode == c_PERSONAL){
            env.order_id = g_quote_order_id;
            [self update_order:g_quote_order_id];
        }
    }else{
        [self order];
    }
}

-(void)order{
    EnvVar* env = [CGlobal sharedId].env;
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    params[@"transaction_id"] = _transaction_id;
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
                        
                        [self done_order];
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
                    
                    [self done_order];
                    
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
    params[@"transaction_id"] = _transaction_id;
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
                    
                  
                    [self done_order];
                }
            }
        }else{
            NSLog(@"Error");
        }
        [CGlobal stopIndicator:self];
    } method:@"POST"];
}

@end
