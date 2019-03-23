//
//  RescheduleDateInput.m
//  Logistika
//
//  Created by BoHuang on 7/5/18.
//  Copyright © 2018 BoHuang. All rights reserved.
//

#import "RescheduleDateInput.h"
#import "AppDelegate.h"
#import "CGlobal.h"
#import "NetworkParser.h"

@implementation RescheduleDateInput

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)clickAction:(id)sender {
    
    
    //[self.dialog showPopup:vcc.rootVC.view];
    
    UIDatePicker*picker = self.txtNewDate.inputView;
    if(picker==nil)
        return;
    NSDate* myDate = picker.date;
    
    if ([CGlobal compareWithToday:myDate DateStr:nil mode:2] == NSOrderedDescending) {
        [CGlobal AlertMessage:@"Pickup Date should not be in the past" Title:nil];
        return;
    }
    
    
    
    NSString* val = self.txtNewDate.text;
    if (val!=nil && [val length] > 0) {
        [CGlobal showIndicator:self.vc];
        NetworkParser* manager = [NetworkParser sharedManager];
        NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
        params[@"id"] = self.data.orderId;
        params[@"date"] = self.dateModel.date;
        params[@"time"] = self.dateModel.time;
        
        // change page
        if(self.aDelegate!=nil){
            [self.aDelegate didCancel:self.orginal_data View:self];
        }
        
        [manager ontemplateGeneralRequest2:params BasePath:BASE_URL_ORDER Path:@"reschedule" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
            [CGlobal stopIndicator:self.vc];
            if (error == nil) {
                if (dict!=nil && dict[@"result"] != nil) {
                    //
                    if([dict[@"result"] intValue] == 400){
                        NSString* message = @"Fail";
                        [CGlobal AlertMessage:message Title:nil];
                    }else if ([dict[@"result"] intValue] == 200){
                        NSString* message = @"Success";
                       
                        
                        // change page
                        if(self.aDelegate!=nil){
                            [self.aDelegate didSubmit:self.orginal_data View:self];
                             [CGlobal AlertMessage:message Title:nil];
                        }else{
                            AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                            [delegate goHome:self.vc];
                             [CGlobal AlertMessage:message Title:nil];
                        }
                        
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
    }else{
        [CGlobal AlertMessage:@"Choose Date" Title:nil];
    }
    return;
}
-(void)firstProcess:(NSDictionary*)data{
    if (data!=nil) {
        if (data[@"aDelegate"] != nil) {
            self.aDelegate = data[@"aDelegate"];
        }
        if (data[@"vc"] != nil) {
            self.vc = data[@"vc"];
        }
        self.orginal_data = data;
        if (data[@"model"] != nil) {
            UIDatePicker* date = [[UIDatePicker alloc] init];
            date.date = [NSDate date];
            date.datePickerMode = UIDatePickerModeDateAndTime;
            self.txtNewDate.inputView = date;
            self.datePicker = date;
            
            self.data = data[@"model"];
            
            [date addTarget:self action:@selector(timeChanged:) forControlEvents:UIControlEventValueChanged];
            
            self.dateModel = [[DateModel alloc] initWithDictionary:nil];
        }
        
    }
    [self.txtNewDate addBotomLayer:CGRectMake(0, 0, 200, 30)];
    
}
-(void)timeChanged:(UIDatePicker*)picker{
    int tag = (int)picker.tag;
    switch (tag) {
        default:
        {
            NSDate* myDate = picker.date;
            
            if ([CGlobal compareWithToday:myDate DateStr:nil mode:2] == NSOrderedDescending) {
                [CGlobal AlertMessage:@"Pickup Date should not be in the past" Title:nil];
                return;
            }
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy hh:mm a"];
            NSString *prettyVersion = [dateFormat stringFromDate:myDate];
            _txtNewDate.text = prettyVersion;
            
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            prettyVersion = [dateFormat stringFromDate:myDate];
            self.dateModel.date = prettyVersion;
            
            [dateFormat setDateFormat:@"hh:mm a"];
            prettyVersion = [dateFormat stringFromDate:myDate];
            self.dateModel.time = prettyVersion;
            break;
        }
    }
    
}
@end

