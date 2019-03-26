//
//  OrderItemView.m
//  Logistika
//
//  Created by BoHuang on 4/27/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "OrderItemView.h"
#import "ReviewCameraTableViewCell.h"
#import "ReviewItemTableViewCell.h"
#import "ReviewPackageTableViewCell.h"
#import "NetworkParser.h"
#import "TopBarView.h"
#import "AppDelegate.h"
#import "TrackMapViewController.h"
#import "OrderTableViewCell.h"
#import "RescheduleDateInput.h"
#import "Logistika-Swift.h"

@implementation OrderItemView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(void)firstProcess:(int)mode Data:(OrderHisModel*)model VC:(UIViewController*)vc{
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
    
    self.lblTracking.text = model.trackId;
    self.lblOrderNumber.text = model.orderId;
    
    int state = [model.state intValue];
    _btnPos.hidden = true;
    switch (state) {
        case 0:
        {
            _lblStatus.text = @"Order Cancel";
            
            break;
        }
        case 2:
        {
            _lblStatus.text = @"Associate on the way for pickup";
            _btnPos.hidden = false;
            break;
        }
        case 3:
        {
            _lblStatus.text = @"On the way to destination";
            _btnPos.hidden = false;
            break;
        }
        case 4:
        {
            _lblStatus.text = @"Order Delivered";
            break;
        }
        case 5:
        {
            _lblStatus.text = @"Order on hold";
            _btnPos.hidden = false;
            break;
        }
        case 6:
        {
            _lblStatus.text = @"Returned Order";
            break;
        }
        case 1:
        {
            _lblStatus.text = @"In Process";
            
            break;
        }
        default:
            break;
    }
    self.vc = vc;
    self.data = model;
    
        
}
- (IBAction)clickPos:(id)sender {
    if (self.vc.navigationController!=nil) {
        
        g_addressModel = self.data.addressModel;
        g_state = self.data.state;
        g_ORDER_TYPE = self.data.orderModel.product_type;
        if (g_ORDER_TYPE == g_CAMERA_OPTION) {
            g_cameraOrderModel = self.data.orderModel;
        }else if(g_ORDER_TYPE == g_ITEM_OPTION){
            g_itemOrderModel = self.data.orderModel;
        }else if(g_ORDER_TYPE == g_PACKAGE_OPTION  ){
            g_packageOrderModel = self.data.orderModel;
        }
        
        [self orderTracking:self.data.orderId Employee:self.data.accepted_by];
    }
}
- (IBAction)toggleShow:(id)sender {
    
    BOOL hidden =  self.data.viewContentHidden;
    self.data.viewContentHidden = !hidden;
    UIView* view = [[self superview] superview];
    if ([view isKindOfClass:[OrderTableViewCell class]]) {
        OrderTableViewCell* cell = (OrderTableViewCell*)view;
        [cell.tableView reloadRowsAtIndexPaths:@[cell.indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        tableView.reloadRows(at: [indexPath], with: .top)
//        [cell.tableView reloadData];
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

-(void)setModelData:(OrderHisModel*)model VC:(UIViewController*)vc{
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
    
    
    self.dateModel = [[DateModel alloc] initWithDictionary:nil];
    [self showItemLists:model];
    
    NSDictionary* pred_str = @{@"step1":@"Associated ",
                               @"step2":@"Order Picked up & in\ntransit to drop off ",
                               @"order_delivered":@"Order Delivered ",
                               @"order_on_hold":@"Order On Hold ",
                               @"order_returned":@"Order Returned ",
                               @"associate":@"Associate on the \n way",
                               @"pickup_cancelled":@"Pickup Cancelled",
                               };
    self.lblStat1.text = pred_str[@"associate"];
    self.lblStat2.text = pred_str[@"step2"];
    self.lblStat3.text = pred_str[@"order_returned"];
    
    int state = [model.state intValue];
    _btnPos.hidden = true;
    switch (state) {
        case 1:{
            _lblStatus.text = @"In Process";
            self.imgStep.image = [UIImage imageNamed:@"step_inprogress.png"];
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            self.lblStat3.text = pred_str[@"order_delivered"];
            
            break;
            
        }
        case 0:
        {
            _lblStatus.text = @"Order Cancel";
            self.imgStep.image = [UIImage imageNamed:@"step_cancel.png"];
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;            
            self.lblStat2.text = pred_str[@"pickup_cancelled"];
            self.lblStat3.text = pred_str[@"order_delivered"];
        
            break;
        }
        case 2:
        {
            _lblStatus.text = @"Associate on the way for pickup";
            self.imgStep.image = [UIImage imageNamed:@"step1.png"];
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            self.lblStat3.text = pred_str[@"order_delivered"];
            _btnPos.hidden = false;
            break;
        }
        case 3:
        {
            _lblStatus.text = @"On the way to destination";
            self.imgStep.image = [UIImage imageNamed:@"step2.png"];
            self.lblStat3.text = pred_str[@"order_delivered"];
            _btnPos.hidden = false;
            break;
        }
        case 4:
        {
            _lblStatus.text = @"Order Delivered";
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            self.imgStep.image = [UIImage imageNamed:@"step3.png"];
            self.lblStat3.text = pred_str[@"order_delivered"];
            break;
        }
        case 5:
        {
            _lblStatus.text = @"Order on hold";
            self.imgStep.image = [UIImage imageNamed:@"step_onhold.png"];
            self.lblStat3.text = pred_str[@"order_on_hold"];
            _btnPos.hidden = false;
            break;
        }
        case 6:
        {
            _lblStatus.text = @"Returned Order";
            self.imgPos.hidden = true;
            self.btnPos.hidden = true;
            self.imgStep.image = [UIImage imageNamed:@"step_return.png"];
            self.lblStat3.text = pred_str[@"order_returned"];
            break;
        }
        default:
            break;
    }
    
    [self hideAddressFields];
    if (model.cellSizeCalculated == false) {
        self.viewContent.hidden = false;
        CGRect scRect = [[UIScreen mainScreen] bounds];
        scRect.size.width = scRect.size.width;
        CGSize size = [self.stackRoot systemLayoutSizeFittingSize:scRect.size withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityDefaultLow];
        NSLog(@"HQHQHQ order id %@",model.orderId);
        NSLog(@"HQHQHQ OV W=%f h=%f",size.width,size.height);
        self.data.cellSize = size;
        
        model.cellSizeCalculated = false;
        
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

-(void)showItemLists:(OrderHisModel*)model{
    self.orderModel = model.orderModel;
    if (model.orderModel.product_type == g_CAMERA_OPTION) {
        
        self.viewHeader_CAMERA.hidden = false;
        self.viewHeader_ITEM.hidden = true;
        self.viewHeader_PACKAGE.hidden = true;
        
        UINib* nib = [UINib nibWithNibName:@"ReviewCameraTableViewCell" bundle:nil];
        [self.tableView_items registerNib:nib forCellReuseIdentifier:@"cell1"];
        self.cellHeight = 40;
        self.tableView_items.delegate = self;
        self.tableView_items.dataSource = self;
    }else if(model.orderModel.product_type == g_ITEM_OPTION){
        self.viewHeader_CAMERA.hidden = true;
        self.viewHeader_ITEM.hidden = false;
        self.viewHeader_PACKAGE.hidden = true;
        
        UINib* nib = [UINib nibWithNibName:@"ReviewItemTableViewCell" bundle:nil];
        [self.tableView_items registerNib:nib forCellReuseIdentifier:@"cell2"];
        self.cellHeight = 40;
        self.tableView_items.delegate = self;
        self.tableView_items.dataSource = self;
    }else if(model.orderModel.product_type == g_PACKAGE_OPTION){
        self.viewHeader_CAMERA.hidden = true;
        self.viewHeader_ITEM.hidden = true;
        self.viewHeader_PACKAGE.hidden = false;
        
        UINib* nib = [UINib nibWithNibName:@"ReviewPackageTableViewCell" bundle:nil];
        [self.tableView_items registerNib:nib forCellReuseIdentifier:@"cell3"];
        self.cellHeight = 40;
        self.tableView_items.delegate = self;
        self.tableView_items.dataSource = self;
    }
    [self calculateRowHeight:model];
    [self.tableView_items reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    self.constraint_TH.constant = self.totalHeight;
    [self.tableView_items setNeedsUpdateConstraints];
    [self.tableView_items layoutIfNeeded];
    return self.orderModel.itemModels.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (self.orderModel.product_type == g_CAMERA_OPTION) {
            ReviewCameraTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            
            NSMutableDictionary* inputData = [[NSMutableDictionary alloc] init];
            inputData[@"vc"] = self.vc;
            inputData[@"indexPath"] = indexPath;
            inputData[@"aDelegate"] = self;
            inputData[@"tableView"] = tableView;
            inputData[@"model"] = self.orderModel.itemModels[indexPath.row];
            
            [cell setData:inputData];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = COLOR_RESERVED2;
            
            return cell;
        }else if(self.orderModel.product_type == g_ITEM_OPTION){
            ReviewItemTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            
            [cell initMe:self.orderModel.itemModels[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.aDelegate = self;
            cell.backgroundColor = COLOR_RESERVED2;
            return cell;
        }else{
            ReviewPackageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
            
            [cell initMe:self.orderModel.itemModels[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.aDelegate = self;
            cell.backgroundColor = COLOR_RESERVED2;
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
- (IBAction)clickArrow:(id)sender {
    [self toggleShow:sender];
}
-(void)calculateRowHeight:(OrderHisModel*)model{
    self.height_dict = [[NSMutableDictionary alloc] init];
    self.totalHeight = 0;
    for (int i=0; i<self.orderModel.itemModels.count; i++) {
        NSIndexPath*path = [NSIndexPath indexPathForRow:i inSection:0];
        CGFloat height = [CGlobal tableView1:self.tableView_items heightForRowAtIndexPath:path DefaultHeight:self.cellHeight Data:self.orderModel OrderType:model.orderModel.product_type Padding:0 Width:0];

        NSString*key = [NSString stringWithFormat:@"%d",i];
        NSString*value = [NSString stringWithFormat:@"%f",height];
        self.height_dict[key] = value;
        self.totalHeight = self.totalHeight + height;
    }
}
-(IBAction)clickSchedule:(UIButton*)sender{
    int tag = sender.tag;
    if (tag == 1) {
        // cancel
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Are you sure you want to Cancel" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        alert.tag = 201;
        [alert show];
    
    }else if(tag == 2){
        // pickup
        UIView* view1 = [[self superview] superview];
        
        
        UIViewController* vc = self.vc;
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"ViewPhotoFull" owner:vc options:nil];
        RescheduleDateInput* view = array[1];
        [view firstProcess:@{@"vc":vc,@"model":self.data,@"aDelegate":vc,@"view":self}];
        
        self.dialog = [[MyPopupDialog alloc] init];
        [self.dialog setup:view backgroundDismiss:true backgroundColor:[UIColor darkGrayColor]];
        [self.dialog showPopup:vc.view];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    int tag = (int)alertView.tag;
    switch (tag) {
        case 200:
        {
            // Reschedule
            if (buttonIndex == 0) {
                
            }
            break;
        }
        case 201:{
            if (buttonIndex == 1) {
                // cancel pickup
                [CGlobal showIndicator:self.vc];
                NetworkParser* manager = [NetworkParser sharedManager];
                NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
                params[@"id"] = self.data.orderId;
                
                [manager ontemplateGeneralRequest2:params BasePath:BASE_URL_ORDER Path:@"cancel_order" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
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
                                return;
                            }
                        }
                        AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                        [delegate goHome:self.vc];
                        return;
                    }else{
                        NSLog(@"Error");
                    }
                    [CGlobal stopIndicator:self.vc];
                } method:@"POST"];
                return;
            }
            break;
        }
            
            
        default:
            break;
    }
}
@end
