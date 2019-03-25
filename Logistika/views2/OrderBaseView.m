//
//  OrderBaseView.m
//  Logistika
//
//  Created by BoHuang on 6/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "OrderBaseView.h"
#import "NetworkParser.h"
#import "OrderResponse.h"
#import "TrackMapViewController.h"
#import "AppDelegate.h"
#import "RescheduleDateInput.h"
#import "Logistika-Swift.h"

@implementation OrderBaseView
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
- (IBAction)clickTrack:(id)sender {
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
- (IBAction)clickReschedule:(id)sender {
    UIView* view1 = [[self superview] superview];
    
    
    UIViewController* vc = self.vc;
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"ViewPhotoFull" owner:vc options:nil];
    RescheduleDateInput* view = array[1];
    [view firstProcess:@{@"vc":vc,@"model":self.data,@"aDelegate":vc,@"view":self}];
    
    self.dialog = [[MyPopupDialog alloc] init];
    [self.dialog setup:view backgroundDismiss:true backgroundColor:[UIColor darkGrayColor]];
    if ([vc isKindOfClass:[OrderFrameViewController class]]) {
        OrderFrameViewController*vcc = vc;
        if(vcc.rootVC!=nil)
            [self.dialog showPopup:vcc.rootVC.view];
    }else{
        [self.dialog showPopup:vc.view];
    }
}
-(void)didSubmit:(NSDictionary *)data View:(UIView *)view{
    
    UIView* view1 = [[self superview] superview];
}

- (IBAction)clickEntire:(id)sender {
    if (self.aDelegate!=nil){
        [self.aDelegate didSubmit:self.original_data View:self];
    }
    
}
-(void)cancelOrder:(NSString*) type{
    
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
                    if([type isEqualToString:@"cash"]){
                        NSString* message = @"Your order has been cancelled";
                        [CGlobal AlertMessage:message Title:nil];
                    }else{
                        NSString* message = @"Your order has been cancelled. Amount will be processed in the same account through which the payment was made with in 3 to 5 business days";
                        [CGlobal AlertMessage:message Title:nil];
                    }
                  
                    
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
}
- (IBAction)clickCancelSchedule:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Are you sure you want to Cancel" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alert.tag = 201;
    [alert show];
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
                NSMutableDictionary* paramsCancel = [[NSMutableDictionary alloc] init];
                NSString * url = @"https://www.payumoney.com/treasury/merchant/refundPayment";
                paramsCancel[@"refundAmount"] = self.data.price;
                paramsCancel[@"merchantKey"] = @"iBzb2IZp";
                paramsCancel[@"paymentId"] = self.data.transaction_id;
                
                if([self.data.payment isEqualToString:@"Cash on Pick up"]){
                    [self cancelOrder:@"cash"];
                }else{
                    [manager cancelPayment:url Data:paramsCancel
                       withCompletionBlock:^(NSDictionary *dict, NSError *error) {
                           if(error == nil){
                               
                               NSString* status = dict[@"status"];
                               NSString* s = [dict objectForKey:@"status"];
                               if([status longLongValue] == 0){
                                   [self cancelOrder:@"card"];
                               }else{
                                   [CGlobal stopIndicator:self.vc];
                                   NSString *message = dict[@"message"];
                                  // NSString* message = @"Fail";
                                   [CGlobal AlertMessage:message Title:nil];
                               }
                               
                               
                           }else{
                               [CGlobal stopIndicator:self.vc];
                           }
                       } method:@"post"];
                }
                
                
                return;
            }
            break;
        }
            
            
        default:
            break;
    }
}
@end
