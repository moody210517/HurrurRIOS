//
//  ComboDropTableViewCell.m
//  Wordpress News App
//
//  Created by BoHuang on 6/15/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import "ComboDropTableViewCell.h"
#import "CGlobal.h"

@implementation ComboDropTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //_root.layer.borderColor = [[UIColor blackColor] CGColor];
    //_root.layer.cornerRadius = 0;
    
    //_root.layer.backgroundColor = [[CGlobal colorWithHexString:@"#E0DED1"] CGColor];
    
    //self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    //_root.layer.backgroundColor = [[CGlobal colorWithHexString:@"#0099cc"] CGColor];
    //[_label setTextColor:[UIColor whiteColor]];
    // Configure the view for the selected state
}

-(void)setData:(NSString*)string Selected:(BOOL)sel{
    _label.textAlignment = UITextAlignmentLeft;
    if (sel) {
        _root.layer.backgroundColor = [[CGlobal colorWithHexString:@"#0099cc" Alpha:1.0] CGColor];
        [_label setTextColor:[UIColor whiteColor]];
        
    }else{
        _root.layer.backgroundColor = [[CGlobal colorWithHexString:@"#E0DED1" Alpha:1.0] CGColor];
        [_label setTextColor:[UIColor blackColor]];
    }
    _label.text = string;
}
//-(void)setDataForHeader:(NSString*)string{
//    _label.textAlignment = UITextAlignmentCenter;
//    _root.layer.backgroundColor = [[CGlobal colorWithHexString:@"#E0DED1"] CGColor];
//    _root.layer.backgroundColor = [[CGlobal colorWithHexString:@"#E0DED1"] CGColor];
//    if (self) {
//        _root.layer.backgroundColor = [[CGlobal colorWithHexString:@"#0099cc"] CGColor];
//        [_label setTextColor:[UIColor whiteColor]];
//        
//    }else{
//        
//        [_label setTextColor:[UIColor blackColor]];
//    }
//    _label.text = string;
//}
@end
