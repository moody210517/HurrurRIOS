//
//  EftGoogleAddressComponent.m
//  EFT
//
//  Created by Twinklestar on 12/11/15.
//  Copyright © 2015 Twinklestar. All rights reserved.
//

#import "EftGoogleAddressComponent.h"

@implementation EftGoogleAddressComponent

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        if ([dict objectForKey:@"long_name"] != nil) {
            self.long_name = (NSString*)[dict objectForKey:@"long_name"];
        }
        if ([dict objectForKey:@"short_name"] != nil) {
            self.short_name = (NSString*)[dict objectForKey:@"short_name"];
        }
        if ([dict objectForKey:@"types"] != nil) {
            _types = [dict objectForKey:@"types"];
        }
    }
    return self;
}
@end
