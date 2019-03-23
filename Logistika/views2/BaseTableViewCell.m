//
//  BaseTableViewCell.m
//  Logistika
//
//  Created by BoHuang on 6/10/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "OrderBaseView.h"
#import "NetworkParser.h"
#import "OrderResponse.h"
#import "TrackMapViewController.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(NSMutableDictionary*)data{
    self.vc = data[@"vc"];
    self.aDelegate = data[@"aDelegate"];
    self.indexPath = data[@"indexPath"];
    self.tableView = data[@"tableView"];
//    self.tableView2 = data[@"tableView"];
    self.model = data[@"model"];
    
    self.inputData = data;
    
}
- (IBAction)clickEntireCell:(id)sender {
    if (self.aDelegate!=nil) {
        NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
        data[@"indexPath"] = self.indexPath;
        data[@"inputData"] = self.inputData;
        data[@"model"] = self.model;
        
        [self.aDelegate didSubmit:data View:self.tableView];
    }
}

-(void)orderTracking:(NSString*)orderId Employee:(NSString*)employeeId{
    if (self.vc.navigationController!=nil) {
        [CGlobal showIndicator:self.vc];
        NetworkParser* manager = [NetworkParser sharedManager];
        NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
        params[@"order_id"] = orderId;
        params[@"employer_id"] = employeeId;
        params[@"type"] = [NSNumber numberWithInt:g_mode];
        
        [manager ontemplateGeneralRequest2:params BasePath:@"" Path:@"/Track/order_track" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
            if (error == nil) {
                if (dict!=nil && dict[@"result"] != nil) {
                    //
                    if([dict[@"result"] intValue] == 200){
                        OrderResponse* response = [[OrderResponse alloc] initWithDictionary_track:dict];
                        if (response.orderTrackModel!=nil) {
                            response.orderTrackModel.type = @"200";
                            
                            UIStoryboard*ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                            TrackMapViewController* vc = [ms instantiateViewControllerWithIdentifier:@"TrackMapViewController"];
                            vc.orderResponse = response;
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.vc.navigationController pushViewController:vc animated:true];
                            });
                            [CGlobal stopIndicator:self.vc];
                            return;
                        }
                    }else if ([dict[@"result"] intValue] == 300){
                        OrderResponse* response = [[OrderResponse alloc] initWithDictionary_track:dict];
                        if (response.orderTrackModel!=nil) {
                            response.orderTrackModel.type = @"300";
                            
                            UIStoryboard*ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                            TrackMapViewController* vc = [ms instantiateViewControllerWithIdentifier:@"TrackMapViewController"];
                            vc.orderResponse = response;
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.vc.navigationController pushViewController:vc animated:true];
                            });
                            [CGlobal stopIndicator:self.vc];
                            return;
                        }
                    }
                }
            }else{
                NSLog(@"Error");
            }
            [CGlobal AlertMessage:@"Fail" Title:nil];
            [CGlobal stopIndicator:self.vc];
        } method:@"POST"];
    }
    
}
@end
