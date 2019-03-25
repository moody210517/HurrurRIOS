//
//  AddressChooser.h
//  Logistika
//
//  Created by kangta on 3/24/19.
//  Copyright © 2019 BoHuang. All rights reserved.
//

#import "ColoredView.h"

NS_ASSUME_NONNULL_BEGIN


@interface AddressChooser : ColoredView

@property (nonatomic, copy) NSString* type;
@property (nonatomic, strong) UIViewController*vc;
-(void)firstProcess:(NSDictionary*)data;

@end

NS_ASSUME_NONNULL_END
