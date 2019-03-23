//
//  IpResponse.m
//  ResignDate
//
//  Created by BoHuang on 5/10/16.
//  Copyright © 2016 Twinklestar. All rights reserved.
//

#import "IpResponse.h"
#import "BaseModel.h"

@implementation IpResponse

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
    }
    return self;
}
@end
