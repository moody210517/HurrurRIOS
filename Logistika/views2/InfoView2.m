//
//  InfoView2.m
//  Logistika
//
//  Created by BoHuang on 6/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "InfoView2.h"
#import "CGlobal.h"
#import "ReviewCameraTableViewCell.h"
#import "ReviewItemTableViewCell.h"
#import "ReviewPackageTableViewCell.h"

@implementation InfoView2

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setData:(NSDictionary*)data{
    [super setData:data];
    
    
    if (g_mode != c_CORPERATION) {
        self.viewItems.hidden = false;
        self.viewDetail.hidden = true;
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

    }else{
        self.viewItems.hidden = true;
        self.viewDetail.hidden = false;
        self.lblDeliver.text = g_corporateModel.details;
        self.lblLoadType.text = [CGlobal getTruck:g_corporateModel.truck];
    }
}
-(CGFloat)getHeight{
    
    CGRect scRect = [[UIScreen mainScreen] bounds];
    scRect.size.width = MIN(scRect.size.width -32,320);
    scRect.size.height = 20;
    
    CGSize size = [self.stackRoot systemLayoutSizeFittingSize:scRect.size withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityDefaultLow];
    //        NSLog(@"widthwidth %f height %f",size.width,size.height);
    
    NSLog(@"height estimated %f",size.height);
    
    return size.height;
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
-(void)calculateRowHeight{
    self.height_dict = [[NSMutableDictionary alloc] init];
    self.totalHeight = 0;
    
    CGRect scRect = [[UIScreen mainScreen] bounds];
    scRect.size.width = MIN(scRect.size.width -32,320);
    scRect.size.height = 20;
    
    for (int i=0; i<self.orderModel.itemModels.count; i++) {
        NSIndexPath*path = [NSIndexPath indexPathForRow:i inSection:0];
        CGFloat height = [CGlobal tableView1:self.tableView heightForRowAtIndexPath:path DefaultHeight:self.cellHeight Data:self.orderModel OrderType:g_ORDER_TYPE  Padding:16 Width:scRect.size.width];
        NSString*key = [NSString stringWithFormat:@"%d",i];
        NSString*value = [NSString stringWithFormat:@"%f",height];
        self.height_dict[key] = value;
        self.totalHeight = self.totalHeight + height;
    }
    
    self.constraint_TH.constant = self.totalHeight;
}
@end
