//
//  QuoteItemView.m
//  Logistika
//
//  Created by BoHuang on 4/28/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "QuoteItemView.h"
#import "CGlobal.h"
#import "ReviewCameraTableViewCell.h"
#import "ReviewItemTableViewCell.h"
#import "ReviewPackageTableViewCell.h"

@implementation QuoteItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)firstProcess:(int)mode Data:(QuoteModel*)model VC:(UIViewController*)vc{
    self.mode = mode;
    [self.swSelect addTarget:self action:@selector(swSelected:) forControlEvents:UIControlEventValueChanged];
    
    EnvVar* env = [CGlobal sharedId].env;
//    self.lblTracking.text = model.trackId;
    self.lblOrderNumber.text = model.orderId;
    self.lblReserved.text = [NSString stringWithFormat:@"Reserved By %@",env.nickname];
    
    self.modelSet = false;
    self.vc = vc;
    self.data = model;
    self.aDelegate = vc;
}
-(void)swSelected:(UISwitch*)sw{
    NSNumber* val;
    if (sw.on) {
        val = [NSNumber numberWithInt:1];
    }else{
        val = [NSNumber numberWithInt:0];
        
    }
    
    if (self.aDelegate!=nil) {
        [self.aDelegate didSubmit:@{@"value":val,@"action":@"switch",@"mode":[NSNumber numberWithInt:_mode],@"sw":sw} View:self];
    }
}
- (IBAction)toggleShow:(id)sender {
    BOOL hidden =  self.viewContent.hidden;
    self.viewContent.hidden = !hidden;
    if (self.modelSet == false) {
        [self setModelData:self.data VC:self.vc];
        
    }
    if (!hidden) {
        self.imgDrop.image = [UIImage imageNamed:@"down.png"];
    }else{
        self.imgDrop.image = [UIImage imageNamed:@"up.png"];
    }
}

-(void)setModelData:(QuoteModel*)model VC:(UIViewController*)vc{
    self.vc = vc;
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
    
//    ServiceModel*servicemodel = model.serviceModel;
//    if (servicemodel!=nil) {
//        self.lblServiceLevel.text = [NSString stringWithFormat:@"%@, %@%@, %@",servicemodel.name,symbol_dollar,servicemodel.price,servicemodel.time_in];
//        _viewService.hidden = false;
//    }else{
//        _viewService.hidden = true;
//    }
    _viewService.hidden = true;
    self.viewPayment.hidden = true;
    
//    self.lblPickDate.text = [NSString stringWithFormat:@"Pick up on%@ %@",g_dateModel.date,g_dateModel.time];
    
    
    [self showItemLists:model];
    
    self.modelSet = true;
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
-(void)showItemLists:(QuoteModel*)model{
    self.orderModel = model.orderModel;
    int product_type = model.orderModel.product_type;
    if (product_type == g_CAMERA_OPTION) {
        
        self.viewHeader_CAMERA.hidden = false;
        self.viewHeader_ITEM.hidden = true;
        self.viewHeader_PACKAGE.hidden = true;
        
        UINib* nib = [UINib nibWithNibName:@"ReviewCameraTableViewCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"cell1"];
        self.cellHeight = 40;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }else if(product_type == g_ITEM_OPTION){
        self.viewHeader_CAMERA.hidden = true;
        self.viewHeader_ITEM.hidden = false;
        self.viewHeader_PACKAGE.hidden = true;
        
        UINib* nib = [UINib nibWithNibName:@"ReviewItemTableViewCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
        self.cellHeight = 40;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }else if(product_type == g_PACKAGE_OPTION){
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
        inputData[@"vc"] = self.vc;
        inputData[@"indexPath"] = indexPath;
        inputData[@"aDelegate"] = self;
        inputData[@"tableView"] = tableView;
        inputData[@"model"] = self.orderModel.itemModels[indexPath.row];
        
        
        [cell setData:inputData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(self.orderModel.product_type == g_ITEM_OPTION){
        ReviewItemTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        [cell initMe:self.orderModel.itemModels[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.aDelegate = self;
        return cell;
    }else{
        ReviewPackageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        
        [cell initMe:self.orderModel.itemModels[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.aDelegate = self;
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
-(void)calculateRowHeight:(QuoteModel*)model{
    self.height_dict = [[NSMutableDictionary alloc] init];
    self.totalHeight = 0;
    for (int i=0; i<self.orderModel.itemModels.count; i++) {
        NSIndexPath*path = [NSIndexPath indexPathForRow:i inSection:0];
        CGFloat height = [CGlobal tableView1:self.tableView heightForRowAtIndexPath:path DefaultHeight:self.cellHeight Data:self.orderModel OrderType:model.orderModel.product_type Padding:32 Width:0];
        NSString*key = [NSString stringWithFormat:@"%d",i];
        NSString*value = [NSString stringWithFormat:@"%f",height];
        self.height_dict[key] = value;
        self.totalHeight = self.totalHeight + height;
    }
}
@end
