//
//  OrderItemCorView.m
//  Logistika
//
//  Created by BoHuang on 4/27/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "OrderItemCorView.h"
#import "ReviewCameraTableViewCell.h"
#import "ReviewItemTableViewCell.h"
#import "ReviewPackageTableViewCell.h"
#import "NetworkParser.h"
#import "TopBarView.h"
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "OrderCorTableViewCell.h"

@implementation OrderItemCorView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
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
    
    
    self.vc = vc;
    self.data = model;
    
    self.lblTracking.text = model.trackId;
    self.lblOrderNumber.text = model.orderId;
    
    int state = [model.state intValue];
    switch (state) {
        case 0:
        {
            _lblStatus.text = @"Order Cancel";
            break;
        }
        case 2:
        {
            _lblStatus.text = @"Associate on the way for pickup";
            _viewAdditional.hidden = true;
            
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            self.imgStep.image = [UIImage imageNamed:@"step1.png"];
            break;
        }
        case 3:
        {
            _lblStatus.text = @"On the way to destination";
            self.imgStep.image = [UIImage imageNamed:@"step2.png"];
            break;
        }
        case 4:
        {
            _lblStatus.text = @"Order Delivered";
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            self.imgStep.image = [UIImage imageNamed:@"step3.png"];
            break;
        }
        case 5:
        {
            _lblStatus.text = @"Order on hold";
            self.imgStep.image = [UIImage imageNamed:@"step_onhold.png"];
            break;
        }
        case 6:
        {
            _lblStatus.text = @"Returned Order";
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            self.imgStep.image = [UIImage imageNamed:@"step_return.png"];
            break;
        }
        case 1:
        {
            _lblStatus.text = @"In Process";
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            break;
        }
        default:
            break;
    }
    
}
- (IBAction)toggleShow:(id)sender {

    BOOL hidden =  self.data.viewContentHidden;
    self.data.viewContentHidden = !hidden;
    UIView* view = [[self superview] superview];
    if ([view isKindOfClass:[OrderCorTableViewCell class]]) {
        OrderCorTableViewCell* cell = (OrderCorTableViewCell*)view;
        [cell.tableView reloadData];
    }
}
- (IBAction)clickPos:(id)sender {
    if (self.vc.navigationController!=nil) {
        
        g_addressModel = self.data.addressModel;
        g_state = self.data.state;
        
        if(g_corporateModel==nil){
            g_corporateModel = [[CorporateModel alloc] init];
        }
        g_corporateModel.name = @"";
        g_corporateModel.address = self.data.deliver;
        g_corporateModel.phone = @"";
        g_corporateModel.details = self.data.deliver;
        g_corporateModel.truck = self.data.loadType;
        
        
        
        [self orderTracking:self.data.orderId Employee:self.data.accepted_by];
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
    
    self.lblPaymentMethod.text = [NSString stringWithFormat:@"%@",model.payment];
    
    self.lblPickDate.text = [NSString stringWithFormat:@"%@ %@",model.dateModel.date,model.dateModel.time];
    
    self.lblDeliver.text = model.deliver;
    self.lblType.text = [CGlobal getTruck:model.loadType];
    
    
    self.dateModel = [[DateModel alloc] initWithDictionary:nil];
    [self showItemLists:model];
    
    int state = [model.state intValue];
    switch (state) {
        case 0:
        {
            //            _lblStatus.text = @"Order Cancel";
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            [self showCarriers];
            break;
        }
        case 4:
        {
            [self showCarriers];
            break;
        }
        case 5:
        {
            [self showCarriers];
            break;
        }
        case 6:
        {
            [self showCarriers];
            break;
        }
        default:
            break;
    }
    
    
    [self hideAddressFields];
    if (model.cellSizeCalculated == false) {
        self.viewContent.hidden = false;
        CGRect scRect = [[UIScreen mainScreen] bounds];
        scRect.size.width = scRect.size.width - 16;
        CGSize size = [self.stackRoot systemLayoutSizeFittingSize:scRect.size withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityDefaultLow];
        NSLog(@"widthwidth %f height %f",size.width,size.height);
        self.data.cellSize = size;
        
        model.cellSizeCalculated = true;
    }
    self.modelSet = true;
    
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

-(void)showItemLists:(OrderCorporateHisModel*)model{
    self.viewHeader.hidden = true;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CGFloat height = self.cellHeight * self.orderModel.itemModels.count;
    self.constraint_TH.constant = height;
    [self.tableView_items setNeedsUpdateConstraints];
    [self.tableView_items layoutIfNeeded];
    return self.orderModel.itemModels.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.orderModel.product_type == g_CAMERA_OPTION) {
        ReviewCameraTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        NSMutableDictionary* inputData = [[NSMutableDictionary alloc] init];
        inputData[@"vc"] = self.vc;
        inputData[@"indexPath"] = indexPath;
        inputData[@"aDelegate"] = self;
        inputData[@"tableView"] = tableView;
        inputData[@"model"] = self.orderModel.itemModels[indexPath.row];
        
        
        [cell setData:inputData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(self.orderModel.product_type == g_ITEM_OPTION){
        ReviewItemTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        [cell initMe:self.orderModel.itemModels[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.aDelegate = self;
        return cell;
    }else{
        ReviewPackageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        [cell initMe:self.orderModel.itemModels[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.aDelegate = self;
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
        [_imgSignature_recv sd_setImageWithURL:[NSURL URLWithString:path2]
                         placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                }];
    }
}
- (IBAction)clickArrow:(id)sender {
    [self toggleShow:sender];
}
@end





