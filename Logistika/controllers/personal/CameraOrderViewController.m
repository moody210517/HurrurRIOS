//
//  CameraOrderViewController.m
//  Logistika
//
//  Created by BoHuang on 4/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "CameraOrderViewController.h"
#import "ItemModel.h"
#import "ProductCellCamera.h"
#import "PhotoUploadViewController.h"
#import "CameraOrderTableViewCell.h"
#import "AddressDetailViewController.h"
#import "CGlobal.h"

@interface CameraOrderViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (assign,nonatomic) CGFloat cellHeight;
@end

@implementation CameraOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellHeight = 122;
    self.scrollView.backgroundColor = COLOR_SECONDARY_THIRD;
    if (self.cameraOrderModel == nil) {
        self.cameraOrderModel = [[OrderModel alloc] initWithDictionary:nil];
        
    }
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib* nib = [UINib nibWithNibName:@"CameraOrderTableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"cell"];
    self.viewExceed.hidden = true;
    // Do any additional setup after loading the view.
    
    EnvVar* env = [CGlobal sharedId].env;
    if (env.mode == c_GUEST) {
        NSString* mm = [[NSBundle mainBundle] localizedStringForKey:@"carmera_alert_guest" value:@"" table:nil];
        _lblExceed.text = mm;
    }
    
}
- (IBAction)clickContinue:(id)sender {
    EnvVar* env = [CGlobal sharedId].env;
    if (!self.viewExceed.isHidden && env.mode == c_GUEST) {
        [CGlobal AlertMessage:@"Please Sign In" Title:nil];
    }else{
        if (self.cameraOrderModel.itemModels.count>0) {
            g_cameraOrderModel = self.cameraOrderModel;
            UIStoryboard *ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
            AddressDetailViewController* vc = [ms instantiateViewControllerWithIdentifier:@"AddressDetailViewController"];
            
            int total = 0;            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (total>10) {
                    vc.type = @"exceed";
                }else{
                    
                }
                [self.navigationController pushViewController:vc animated:true];
            });
        }else{
            [CGlobal AlertMessage:@"Please enter all info" Title:nil];
        }
    }
}

-(void)didSubmit:(id)obj View:(UIView *)view{
    if ([view isKindOfClass:[CameraOrderTableViewCell class]]) {
        NSDictionary* dict = obj;
        CameraOrderTableViewCell*cell = view;
        if ([dict[@"action"] isEqualToString:@"remove"]) {
            // remove view
            NSInteger found = [self.cameraOrderModel.itemModels indexOfObject:cell.data];
            if (found!=NSNotFound) {
                [self.cameraOrderModel.itemModels removeObjectAtIndex:found];
                _btnUploadMore.hidden = false;
                [self.tableview reloadData];
            }
        }else if ([dict[@"action"] isEqualToString:@"select"]) {
            int total = 0;
        }
    }
}
- (IBAction)openUploadController:(id)sender {
    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
    PhotoUploadViewController* vc = [ms instantiateViewControllerWithIdentifier:@"PhotoUploadViewController"];
    dispatch_async(dispatch_get_main_queue(), ^{
        vc.limit = g_limitCamera - self.cameraOrderModel.itemModels.count;
        [self.navigationController pushViewController:vc animated:true];
    });
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableview reloadData];
    if (self.cameraOrderModel.itemModels.count >=g_limitCamera) {
        self.btnUploadMore.hidden = true;
    }else{
        self.btnUploadMore.hidden = false;
    }
    
    self.topBarView.caption.text = @"Photo Upload";
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
    CameraOrderTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell initMe:self.cameraOrderModel.itemModels[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.aDelegate = self;
    
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
