//
//  TrackingViewController.m
//  Logistika
//
//  Created by BoHuang on 4/24/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "TrackingViewController.h"
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

@interface TrackingViewController ()
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,strong) NSMutableDictionary* height_dict;
@property (nonatomic,assign) CGFloat totalHeight;
@end

@implementation TrackingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setModelData:self.inputData VC:self];
    self.view.backgroundColor = COLOR_PRIMARY;

    [self hideAddressFields];
}
-(void)hideAddressFields{
//    _lblPickAddress.hidden = true;
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
-(void)setModelData:(OrderHisModel*)model VC:(UIViewController*)vc{
    if (model==nil) {
        return;
    }
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
    UIFont* font = [UIFont boldSystemFontOfSize:_lblServiceLevel.font.pointSize];
    _lblServiceLevel.font = font;
    self.lblPaymentMethod.text = @"Cash on Pick Up";
    
    self.lblPickDate.text = [NSString stringWithFormat:@"%@ %@",model.dateModel.date,model.dateModel.time];
    
    
    
    [self showItemLists:model];
    
    
    self.lblOrderNumber.text = model.orderId;
    
    int state = [model.state intValue];
    switch (state) {
        case 0:
        {
            _lblTracking.text = @"Cancel";
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            break;
        }
        case 1:
        {
            _lblTracking.text = @"In Process";
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            break;
        }
        case 2:
        {
            _lblTracking.text = @"On the way for pickup";
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            break;
        }
        case 3:
        {
            _lblTracking.text = @"On the way to destination";
            break;
        }
        case 4:
        {
            _lblTracking.text = @"Order Delivered";
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            break;
        }
        case 5:
        {
            _lblTracking.text = @"Order on hold";
            break;
        }
        case 6:
        {
            _lblTracking.text = @"Returned Order";
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            break;
        }
        default:
            break;
    }
    self.imgPos.hidden = true;
    self.btnPos.hidden = true;
    _lblTracking.text = self.trackID;
}

-(void)showItemLists:(OrderHisModel*)model{
    self.orderModel = model.orderModel;
    if (model.orderModel.product_type == g_CAMERA_OPTION) {
        
        self.viewHeader_CAMERA.hidden = false;
        self.viewHeader_ITEM.hidden = true;
        self.viewHeader_PACKAGE.hidden = true;
        
        UINib* nib = [UINib nibWithNibName:@"ReviewCameraTableViewCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"cell1"];
        self.cellHeight = 40;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }else if(model.orderModel.product_type == g_ITEM_OPTION){
        self.viewHeader_CAMERA.hidden = true;
        self.viewHeader_ITEM.hidden = false;
        self.viewHeader_PACKAGE.hidden = true;
        
        UINib* nib = [UINib nibWithNibName:@"ReviewItemTableViewCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
        self.cellHeight = 40;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }else if(model.orderModel.product_type == g_PACKAGE_OPTION){
        self.viewHeader_CAMERA.hidden = true;
        self.viewHeader_ITEM.hidden = true;
        self.viewHeader_PACKAGE.hidden = false;
        
        UINib* nib = [UINib nibWithNibName:@"ReviewPackageTableViewCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"cell3"];
        self.cellHeight = 40;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    [self calculateRowHeight:model];
    [self.tableView reloadData];
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
    if (self.orderModel.product_type == g_CAMERA_OPTION) {
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
    }else if(self.orderModel.product_type == g_ITEM_OPTION){
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
- (IBAction)clickPos:(id)sender {
    [self orderTracking:self.trackID];
}
-(void)calculateRowHeight:(OrderHisModel*)model{
    self.height_dict = [[NSMutableDictionary alloc] init];
    self.totalHeight = 0;
    for (int i=0; i<self.orderModel.itemModels.count; i++) {
        NSIndexPath*path = [NSIndexPath indexPathForRow:i inSection:0];
        CGFloat height = [CGlobal tableView1:self.tableView heightForRowAtIndexPath:path DefaultHeight:self.cellHeight Data:self.orderModel OrderType:model.orderModel.product_type Padding:16 Width:0];
        NSString*key = [NSString stringWithFormat:@"%d",i];
        NSString*value = [NSString stringWithFormat:@"%f",height];
        self.height_dict[key] = value;
        self.totalHeight = self.totalHeight + height;
    }
}

@end
