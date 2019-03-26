//
//  ItemModel.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ItemModel.h"
#import "CGlobal.h"

@implementation ItemModel
-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        [self initDefault];
        if (dict!=nil) {
            [BaseModel parseResponse:self Dict:dict];
            int product_type = [dict[@"product_type"] intValue];
            if (product_type == g_CAMERA_OPTION) {
                // already parsed
            }else if(product_type == g_ITEM_OPTION){
                NSArray* dim = [dict[@"dimension"] componentsSeparatedByString:@"X"];
                if (dim.count >=3) {
                    self.dimension1 = dim[0];
                    self.dimension2 = dim[1];
                    self.dimension3 = dim[2];
                }
                
                
            }else if(product_type == g_PACKAGE_OPTION){
                
            }
        }
        
    }
    return self;
}
-(void)initDefault{
    self.title = @"";
    self.dimension1 = @"";
    self.dimension2 = @"";
    self.dimension3 = @"";
    self.weight = c_weight[0];
    self.weight_value = [c_weight_value[0] intValue];
    self.quantity = c_quantity[0];
    self.mPackage = @"0";
}
-(void)firstPackage{
    self.title = c_packageLists[0];
    self.dimension1 = @"";
    self.dimension2 = @"";
    self.dimension3 = @"";
    self.weight = c_weight[0];
    self.weight_value = [c_weight_value[0] intValue];
    self.quantity = c_quantity[0];
    self.mPackage = @"0";
}
-(NSString*)getDimetion{
    if ([_dimension1 length]>0 && [_dimension2 length]>0 && [_dimension3 length]>0) {
        return [NSString stringWithFormat:@"%@X%@X%@",_dimension1,_dimension2,_dimension3];
    }
    return @"";
}
@end
