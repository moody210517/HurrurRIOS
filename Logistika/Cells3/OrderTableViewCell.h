//
//  OrderTableViewCell.h
//  Logistika
//
//  Created by BoHuang on 8/9/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderItemView.h"
#import "BaseTableViewCell.h"

@interface OrderTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet OrderItemView *orderItemView;

-(void)setData:(NSMutableDictionary *)data;
@end
