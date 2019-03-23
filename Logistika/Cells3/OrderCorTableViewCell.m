//
//  OrderCorTableViewCell.m
//  Logistika
//
//  Created by BoHuang on 8/9/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "OrderCorTableViewCell.h"

@implementation OrderCorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(NSMutableDictionary *)data{
    [super setData:data];
    OrderCorporateHisModel*model  = self.model;
    if (model.viewContentHidden) {
        [self.orderItemCorView firstProcess:0 Data:self.model VC:self.vc];
    }else{
        [self.orderItemCorView firstProcess:0 Data:self.model VC:self.vc];
        if (model.cellSizeCalculated == false) {
            [self.orderItemCorView setModelData:self.model VC:self.vc];
        }else{
            [self.orderItemCorView setModelData:self.model VC:self.vc];
        }
    }
    self.orderItemCorView.viewContent.hidden = model.viewContentHidden;
    
}
@end
