//
//  SelectItemViewController.m
//  Logistika
//
//  Created by BoHuang on 4/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "SelectItemViewController.h"
#import "ItemModel.h"
#import "ProductCellCamera.h"
#import "PhotoUploadViewController.h"
#import "SelectItemTableViewCell.h"
#import "AddressDetailViewController.h"
#import "CGlobal.h"

@interface SelectItemViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (assign,nonatomic) CGFloat cellHeight;
@end

@implementation SelectItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellHeight = 222;
    self.scrollView.backgroundColor = COLOR_SECONDARY_THIRD;
    if (self.cameraOrderModel == nil) {
        self.cameraOrderModel = [[OrderModel alloc] initWithDictionary:nil];
        [self addMore:nil];
    }
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib* nib = [UINib nibWithNibName:@"SelectItemTableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"cell"];
    
    self.tableview.scrollEnabled = false;
    self.tableview.backgroundColor = [UIColor clearColor];
    
    
    
    
}
-(id)checkInput{
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    for (int k=0; k<self.cameraOrderModel.itemModels.count; k++) {
        ItemModel* imodel = self.cameraOrderModel.itemModels[k];
        NSString* title = imodel.title;
        title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(title.length == 0){
            return nil;
        }
        
//        NSString*d1 = [imodel.dimension1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        if(d1.length == 0){
//            return nil;
//        }
//        
//        NSString*d2 = [imodel.dimension2 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        if(d2.length == 0){
//            return nil;
//        }
//        
//        NSString*d3 = [imodel.dimension3 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        if(d3.length == 0){
//            return nil;
//        }
        
    }
    return ret;
}
- (IBAction)clickContinue:(id)sender {
    id data = [self checkInput];
    if (data!=nil) {
        g_itemOrderModel = self.cameraOrderModel;
        UIStoryboard *ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
        AddressDetailViewController* vc = [ms instantiateViewControllerWithIdentifier:@"AddressDetailViewController"];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.navigationController pushViewController:vc animated:true];
        });
    }else{
        [CGlobal AlertMessage:@"Please enter all info" Title:nil];
    }
}

-(void)didSubmit:(id)obj View:(UIView *)view{
    if ([view isKindOfClass:[SelectItemTableViewCell class]]) {
        NSDictionary* dict = obj;
        SelectItemTableViewCell*cell = view;
        if ([dict[@"action"] isEqualToString:@"remove"]) {
            // remove view
            if (self.cameraOrderModel.itemModels.count>1) {
                NSInteger found = [self.cameraOrderModel.itemModels indexOfObject:cell.data];
                if (found!=NSNotFound) {
                    [self.cameraOrderModel.itemModels removeObjectAtIndex:found];
                    _btnUploadMore.hidden = false;
                    [self.tableview reloadData];
                }
            }
            
        }else if ([dict[@"action"] isEqualToString:@"select"]) {
            
        }
    }
}
- (IBAction)addMore:(id)sender {
    if (self.cameraOrderModel.itemModels.count < g_limitCnt) {
        ItemModel* itemModel = [[ItemModel alloc] initWithDictionary:nil];
        if (g_isii) {
            itemModel.title = @"option2";
            itemModel.dimension3 = @"3";
            itemModel.dimension2 = @"1";
            itemModel.dimension1 = @"2";
        }
        [self.cameraOrderModel.itemModels addObject:itemModel];
        [self.tableview reloadData];
        
        if (self.cameraOrderModel.itemModels.count >=g_limitCnt) {
            self.btnUploadMore.hidden = true;
        }
    }else{
        [CGlobal AlertMessage:@"Can not upload more" Title:nil];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableview reloadData];
    if (self.cameraOrderModel.itemModels.count >=3) {
        self.btnUploadMore.hidden = true;
    }else{
        self.btnUploadMore.hidden = false;
    }
    self.topBarView.caption.text = @"Select the Item";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CGFloat height = self.cellHeight * self.cameraOrderModel.itemModels.count;
    self.constraint_TH.constant = height;
    [_tableview setNeedsUpdateConstraints];
    [_tableview layoutIfNeeded];
    return self.cameraOrderModel.itemModels.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectItemTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell initMe:self.cameraOrderModel.itemModels[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.aDelegate = self;
    cell.txtItem.backgroundColor = COLOR_SECONDARY_THIRD;
    
    cell.backgroundColor = COLOR_SECONDARY_PRIMARY;
    cell.cview.backgroundColor = COLOR_RESERVED;
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
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
