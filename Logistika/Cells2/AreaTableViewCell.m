//
//  AreaTableViewCell.m
//  Logistika
//
//  Created by BoHuang on 6/7/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "AreaTableViewCell.h"
#import "TblArea.h"
#import "CGlobal.h"
@implementation AreaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDataForArea:(NSDictionary*)data{
    TblArea* area = data[@"data"];
    
    self.lblContent.text = area.title;
    self.backgroundColor = [CGlobal colorWithHexString:@"F3F5E1" Alpha:1.0f];
}
@end
