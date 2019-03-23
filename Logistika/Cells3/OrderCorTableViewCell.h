//
//  OrderCorTableViewCell.h
//  Logistika
//
//  Created by BoHuang on 8/9/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "OrderItemCorView.h"

@interface OrderCorTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet OrderItemCorView *orderItemCorView;

-(void)setData:(NSMutableDictionary *)data;
@end
