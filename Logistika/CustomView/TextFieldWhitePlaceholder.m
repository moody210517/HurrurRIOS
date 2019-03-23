//
//  TextFieldWhitePlaceholder.m
//  intuitive
//
//  Created by BoHuang on 4/13/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "TextFieldWhitePlaceholder.h"

@implementation TextFieldWhitePlaceholder

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"TopBarView initWithFrame");
        [self customLayout];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"TopBarView initWithCoder");
        [self customLayout];
    }
    return self;
}
-(void)customLayout{
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
}
@end
