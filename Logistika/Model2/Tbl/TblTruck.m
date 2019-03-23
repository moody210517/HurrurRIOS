//
//  TblTruck.m
//  Logistika
//
//  Created by BoHuang on 6/7/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "TblTruck.h"

@implementation TblTruck
-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        [BaseModel parseResponse:self Dict:dict];
        
        self.ddescription = dict[@"description"];
    }
    return self;
}
@end
