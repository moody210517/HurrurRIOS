//
//  RescheduleTableViewCell.m
//  Logistika
//
//  Created by BoHuang on 4/10/18.
//  Copyright © 2018 BoHuang. All rights reserved.
//

#import "RescheduleTableViewCell.h"

@implementation RescheduleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(NSMutableDictionary *)data Mode:(int)mode{
    [super setData:data];
    OrderRescheduleModel*model = self.model;
    if (model.viewContentHidden) {
        [self.rescheduleItemView firstProcess:mode Data:self.model VC:self.vc];
        
    }else{
        [self.rescheduleItemView firstProcess:mode Data:self.model VC:self.vc];
        if (model.cellSizeCalculated == false) {
            [self.rescheduleItemView setModelData:model VC:self.vc];
        }else{
            [self.rescheduleItemView setModelData:model VC:self.vc];
        }
    }
    self.rescheduleItemView.viewContent.hidden = model.viewContentHidden;
    if (model.viewContentHidden) {
        self.rescheduleItemView.imgDrop.image = [UIImage imageNamed:@"down.png"];
    }else{
        self.rescheduleItemView.imgDrop.image = [UIImage imageNamed:@"up.png"];
    }
}
@end
