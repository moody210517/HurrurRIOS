//
//  AddressModel.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel
-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        [self initDefault];
        if (dict!=nil) {
            [BaseModel parseResponse:self Dict:dict];
            
            self.sourceAddress = dict[@"s_address"];
            self.sourceCity = dict[@"s_city"];
            self.sourceState = dict[@"s_state"];
            self.sourcePinCode = dict[@"s_pincode"];
            self.sourcePhonoe = dict[@"s_phone"];
            self.sourceLandMark = dict[@"s_landmark"];
            self.sourceInstruction = dict[@"s_instruction"];
            self.sourceArea = dict[@"s_area"];
            
            self.desAddress = dict[@"d_address"];
            self.desCity = dict[@"d_city"];
            self.desState = dict[@"d_state"];
            
            self.desPinCode = dict[@"d_pincode"];
            self.desLandMark = dict[@"d_landmark"];
            self.desInstruction = dict[@"d_instruction"];
            self.desArea = dict[@"d_area"];
            
            self.sourceLat = [dict[@"s_lat"] doubleValue];
            self.sourceLng = [dict[@"s_lng"] doubleValue];
            self.desLat = [dict[@"d_lat"] doubleValue];
            self.desLng = [dict[@"d_lng"] doubleValue];
            
            self.desPhone = dict[@"d_phone"];
            self.desName = dict[@"d_name"];
            
            if(self.sourcePhonoe!=nil){
                NSArray* components = [self.sourcePhonoe componentsSeparatedByString:@":"];
                if (components.count == 2) {
                    self.sourcePhonoe = components[0];
                    self.sourceName = components[1];
                }else if(components.count == 1){
                    self.sourcePhonoe = components[0];
                }else {
                    self.sourcePhonoe = @" ";
                }
            }
//            if (self.sourcePhonoe.length>5) {
//                if(![self.sourcePhonoe containsString:@"+"]){
//                    self.sourcePhonoe = [NSString stringWithFormat:@"+%@",self.sourcePhonoe];
//                }
//                self.sourcePhonoe = [self.sourcePhonoe stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            }
//            if (self.desPhone.length>5) {
//                if(![self.desPhone containsString:@"+"]){
//                    self.desPhone = [NSString stringWithFormat:@"+%@",self.desPhone];
//                }
//                self.desPhone = [self.desPhone stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            }
            [self checkValueForView];   
        }
    }
    return self;
}
-(void)checkValueForView{
    if(self.desInstruction == [NSNull null]){
        self.desInstruction = @" ";
    }else if ([self.desInstruction length]>0) {
        //ok
    }else{
        self.desInstruction = @" ";
    }
    
    if(self.sourceInstruction == [NSNull null]){
        self.sourceInstruction = @" ";
    }else if ([self.sourceInstruction length]>0) {
        //ok
    }else{
        self.sourceInstruction = @" ";
    }
    
    if(self.desName == [NSNull null]){
        self.desName = @" ";
    }else if ([self.desName length]>0) {
        //ok
    }else{
        self.desName = @" ";
    }
    if(self.sourceName == [NSNull null]){
        self.sourceName = @" ";
    }else if ([self.sourceName length]>0) {
        //ok
    }else{
        self.sourceName = @" ";
    }
    
    if(self.desLandMark == [NSNull null]){
        self.desLandMark = @" ";
    }else if ([self.desLandMark length]>0) {
        //ok
    }else{
        self.desLandMark = @" ";
    }
}
-(void)setDesPhone:(NSString *)desPhone{
    id value = desPhone;
    
    if (value!=nil && [value isKindOfClass:[NSString class]] && value != [NSNull null] && [value length]>0) {
        _desPhone = value;
    }else{
        _desPhone = @" ";
    }
}
-(void)initDefault{
    self.sourceLat = 0;
    self.sourceLng = 0;
    
    self.desLat = 0;
    self.desLng = 0;
    
    self.duration = @"";
    self.distance = @"";
    _desPhone = @" ";
}
@end
