//
//  AddressHisModel.m
//  Logistika
//
//  Created by Venu Talluri on 02/01/1941 Saka.
//  Copyright © 1941 BoHuang. All rights reserved.
//

#import "AddressHisModel.h"

@implementation AddressHisModel
-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        [self initDefault];
        if (dict!=nil) {
            [BaseModel parseResponse:self Dict:dict];
            
            self.name = dict[@"name"];
            self.address = dict[@"address"];
            self.area = dict[@"area"];
            self.city = dict[@"city"];
            self.state = dict[@"state"];
            self.pincode = dict[@"pincode"];
            self.phone = dict[@"phone"];
            self.landmark = dict[@"landmark"];
            
            self.instruction = dict[@"d_address"];
            self.lat = [dict[@"lat"] doubleValue];
            self.lng = [dict[@"lng"] doubleValue];
            
            
            [self checkValueForView];
        }
    }
    return self;
}
-(void)checkValueForView{
    if(self.instruction == [NSNull null]){
        self.instruction = @" ";
    }else if ([self.instruction length]>0) {
        //ok
    }else{
        self.instruction = @" ";
    }
    
    if(self.name == [NSNull null]){
        self.name = @" ";
    }else if ([self.name length]>0) {
        //ok
    }else{
        self.name   = @" ";
    }
   
    
    if(self.landmark == [NSNull null]){
        self.landmark = @" ";
    }else if ([self.landmark length]>0) {
        //ok
    }else{
        self.landmark = @" ";
    }
}

-(void)initDefault{
    self.lat = 0;
    self.lng = 0;
    
    
}
@end
