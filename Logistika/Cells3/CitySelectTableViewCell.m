//
//  CitySelectTableViewCell.m
//  Logistika
//
//  Created by BoHuang on 9/23/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "CitySelectTableViewCell.h"
#import "CityModel.h"
#import "CGlobal.h"
#import "UIImageView+WebCache.h"

@implementation CitySelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGFloat size = _lbltext1.font.pointSize;
    _lbltext1.font = [UIFont boldSystemFontOfSize:size];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(NSMutableDictionary *)data{
    [super setData:data];
    CityModel* cityModel = self.model;
    NSString* path1 = [NSString stringWithFormat:@"%@%@%@%@",g_baseUrl,PHOTO_URL,@"employer/",cityModel.image];
    [_imgView1 sd_setImageWithURL:[NSURL URLWithString:path1]
                     placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            }];
    _lbltext1.text = cityModel.name;
}


@end
