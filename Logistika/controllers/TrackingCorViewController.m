//
//  TrackingCorViewController.m
//  Logistika
//
//  Created by BoHuang on 5/2/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "TrackingCorViewController.h"
#import "CGlobal.h"
#import "NetworkParser.h"
#import "AppDelegate.h"
#import "ReviewCameraTableViewCell.h"
#import "ReviewItemTableViewCell.h"
#import "ReviewPackageTableViewCell.h"
#import "NetworkParser.h"
#import "TopBarView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TrackMapViewController.h"

@interface TrackingCorViewController ()

@end

@implementation TrackingCorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self firstProcess:0 Data:self.data VC:self];
    [self setModelData:self.data VC:self];
    
    self.view.backgroundColor = COLOR_PRIMARY;
    [self hideAddressFields];
}
-(void)hideAddressFields{
    //_lblPickAddress.hidden = true;
    _lblPickCity.hidden = true;
    _lblPickState.hidden = true;
    _lblPickPincode.hidden = true;
    
    //    _lblDestAddress.hidden = true;
    _lblDestCity.hidden = true;
    _lblDestState.hidden = true;
    _lblDestPincode.hidden = true;
    
    _lblPickAddress.numberOfLines = 0;
    _lblDestAddress.numberOfLines = 0;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"Tracking Information";
    self.navigationController.navigationBar.hidden = false;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)firstProcess:(int)mode Data:(OrderCorporateHisModel*)model VC:(UIViewController*)vc{
    self.modelSet = false;
    
    switch (mode) {
        case 1:
        {
            // cancel mode
            //            self.viewNewDate.hidden = true;
            break;
        }
            
        default:{
            break;
        }
    }
    self.mode = mode;
    
    _viewAdditional.hidden = true;
    self.vc = vc;
    self.data = model;
    
    self.lblTracking.text = self.trackID;
    self.lblOrderNumber.text = model.orderId;
    
    int state = [model.state intValue];
    switch (state) {
        case 0:
        {
            _lblStatus.text = @"Cancel";
            break;
        }
        case 1:
        {
            _lblStatus.text = @"Processing";
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            break;
        }
        case 2:
        {
            _lblStatus.text = @"On the way for pickup";
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            break;
        }
        case 3:
        {
            _lblStatus.text = @"On the way to destination";
            [self showCarriers];
            break;
        }
        case 4:
        {
            _lblStatus.text = @"Order Delivered";
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            [self showCarriers];
            break;
        }
        case 5:
        {
            _lblStatus.text = @"Order on hold";
            [self showCarriers];
            break;
        }
        case 6:
        {
            _lblStatus.text = @"Returned Order";
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            [self showCarriers];
            break;
        }
        default:
            break;
    }
    self.imgPos.hidden = true;
    self.btnPos.hidden = true;
}
- (IBAction)toggleShow:(id)sender {
    
    BOOL hidden =  self.viewContent.hidden;
    if (self.modelSet == false ) {
        [self setModelData:self.data VC:self.vc];
    }
    self.viewContent.hidden = !hidden;
    if (!hidden) {
        self.imgDrop.image = [UIImage imageNamed:@"down.png"];
    }else{
        self.imgDrop.image = [UIImage imageNamed:@"up.png"];
    }
}

- (IBAction)clickAction:(id)sender {
    switch (self.mode) {
        case 1:
        {
            // cancel
            [CGlobal showIndicator:self.vc];
            NetworkParser* manager = [NetworkParser sharedManager];
            NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
            params[@"id"] = self.data.orderId;
            
            [manager ontemplateGeneralRequest2:params BasePath:BASE_URL Path:@"cancel_order" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
                if (error == nil) {
                    if (dict!=nil && dict[@"result"] != nil) {
                        //
                        if([dict[@"result"] intValue] == 400){
                            NSString* message = @"Fail";
                            [CGlobal AlertMessage:message Title:nil];
                        }else if ([dict[@"result"] intValue] == 200){
                            NSString* message = @"Success";
                            [CGlobal AlertMessage:message Title:nil];
                            
                            // change page
                            AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                            [delegate goHome:self.vc];
                        }
                    }
                }else{
                    NSLog(@"Error");
                }
                [CGlobal stopIndicator:self];
            } method:@"POST"];
            return;
        }
        default:{
            
            return;
        }
    }
    
}

-(void)setModelData:(OrderCorporateHisModel*)model VC:(UIViewController*)vc{
    g_addressModel = model.addressModel;
    if (model.addressModel.desAddress!=nil) {
        _lblPickAddress.text = model.addressModel.sourceAddress;
        _lblPickCity.text = model.addressModel.sourceCity;
        _lblPickState.text = model.addressModel.sourceState;
        _lblPickPincode.text = model.addressModel.sourcePinCode;
        _lblPickPhone.text = model.addressModel.sourcePhonoe;
        _lblPickLandMark.text = model.addressModel.sourceLandMark;
        _lblPickInst.text = model.addressModel.sourceInstruction;
        _lblPickName.text = model.addressModel.sourceName;
        
        _lblDestAddress.text = model.addressModel.desAddress;
        _lblDestCity.text = model.addressModel.desCity;
        _lblDestState.text = model.addressModel.desState;
        _lblDestPincode.text = model.addressModel.desPinCode;
        _lblDestPhone.text = model.addressModel.desPhone;
        _lblDestLandMark.text = model.addressModel.desLandMark;
        _lblDestInst.text = model.addressModel.desInstruction;
        _lblDestName.text = model.addressModel.desName;
        
        NSString* sin = [model.addressModel.sourceInstruction stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([sin length]>0) {
            _lblPickInst.text = model.addressModel.sourceInstruction;
        }else{
            _lblPickInst.hidden = true;
        }
        sin = [model.addressModel.desInstruction stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([sin length]>0) {
            _lblDestInst.text = model.addressModel.desInstruction;
        }else{
            _lblDestInst.hidden = true;
        }
    }
//    _lblDestPhone.hidden = true;
    
    self.lblServiceLevel.text = [NSString stringWithFormat:@"%@, %@%@, %@",model.serviceModel.name,symbol_dollar,model.serviceModel.price,model.serviceModel.time_in];
    
    self.lblPaymentMethod.text = @"Cash on Pick Up";
    
    self.lblPickDate.text = [NSString stringWithFormat:@"%@ %@",model.dateModel.date,model.dateModel.time];
    
    self.lblDeliver.text = model.deliver;
    self.lblType.text = [CGlobal getTruck:model.loadType];
    
    
    self.dateModel = [[DateModel alloc] initWithDictionary:nil];
    [self showItemLists:model];
    
    
    
    self.modelSet = true;
}

-(void)showItemLists:(OrderCorporateHisModel*)model{
    self.viewHeader.hidden = true;
    //    self.orderModel = model.orderModel;
    //    if (model.orderModel.product_type == g_CAMERA_OPTION) {
    //
    //        self.viewHeader_CAMERA.hidden = false;
    //        self.viewHeader_ITEM.hidden = true;
    //        self.viewHeader_PACKAGE.hidden = true;
    //
    //        UINib* nib = [UINib nibWithNibName:@"ReviewCameraTableViewCell" bundle:nil];
    //        [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    //        self.cellHeight = 40;
    //        self.tableView.delegate = self;
    //        self.tableView.dataSource = self;
    //    }else if(model.orderModel.product_type == g_ITEM_OPTION){
    //        self.viewHeader_CAMERA.hidden = true;
    //        self.viewHeader_ITEM.hidden = false;
    //        self.viewHeader_PACKAGE.hidden = true;
    //
    //        UINib* nib = [UINib nibWithNibName:@"ReviewItemTableViewCell" bundle:nil];
    //        [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    //        self.cellHeight = 40;
    //        self.tableView.delegate = self;
    //        self.tableView.dataSource = self;
    //    }else if(model.orderModel.product_type == g_PACKAGE_OPTION){
    //        self.viewHeader_CAMERA.hidden = true;
    //        self.viewHeader_ITEM.hidden = true;
    //        self.viewHeader_PACKAGE.hidden = false;
    //
    //        UINib* nib = [UINib nibWithNibName:@"ReviewPackageTableViewCell" bundle:nil];
    //        [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    //        self.cellHeight = 40;
    //        self.tableView.delegate = self;
    //        self.tableView.dataSource = self;
    //    }
    //
    //    [self.tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CGFloat height = self.cellHeight * self.orderModel.itemModels.count;
    self.constraint_TH.constant = height;
    [self.tableView setNeedsUpdateConstraints];
    [self.tableView layoutIfNeeded];
    return self.orderModel.itemModels.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.orderModel.product_type == g_CAMERA_OPTION) {
        ReviewCameraTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
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
    }else if(self.orderModel.product_type == g_ITEM_OPTION){
        ReviewItemTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        [cell initMe:self.orderModel.itemModels[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.aDelegate = self;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else{
        ReviewPackageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        [cell initMe:self.orderModel.itemModels[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.aDelegate = self;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}
-(void)showCarriers{
    if (self.data.carrierModel!=nil && self.data.carrierModel.order_id!=nil && [self.data.carrierModel.order_id length]>0) {
        CarrierModel* cm = self.data.carrierModel;
        _lblFrieght.text = cm.freight;
        _lblLoadType.text = cm.load_type;
        _lblScanCon.text = cm.consignment;
        _lblDateTime.text = [NSString stringWithFormat:@"%@ %@",cm.date,cm.time];
        _lblVehicleNumber.text = cm.vehicle;
        _lblDriverID.text = cm.driver_id;
        _lblDriverName.text = cm.driver_name;
        
        NSString* path1 = [NSString stringWithFormat:@"%@%@%@",g_baseUrl,PHOTO_URL,cm.signature];
        [_imgSignature sd_setImageWithURL:[NSURL URLWithString:path1]
                         placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                }];
        
        NSString* path2 = [NSString stringWithFormat:@"%@%@%@",g_baseUrl,PHOTO_URL,self.data.receiver_signature];
        [_imgSignature sd_setImageWithURL:[NSURL URLWithString:path2]
                         placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                }];
    }
}
- (IBAction)clickPos:(id)sender {
    [self orderTracking:self.trackID];
}



@end
