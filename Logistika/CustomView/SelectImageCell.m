//
//  SelectImageCell.m
//  Logistika
//
//  Created by BoHuang on 4/20/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "SelectImageCell.h"
#import "CGlobal.h"
#import "ViewPhotoFull.h"
#import "Logistika-Swift.h"

@implementation SelectImageCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setStyleWithData:(NSMutableDictionary*)data Mode:(int)mode{
    _mode = [NSNumber numberWithInt:mode];
    
    self.hidden = false;
    self.filePath = data[@"path"];

    self.imgContent.image = data[@"image"];
    self.image =  data[@"image"];
//    [CGlobal getImageFromPath:self.filePath CallBack:^(UIImage *image) {
//        if (image!=nil) {
//            self.imgContent.image = image;
//        }else{
//            [CGlobal AlertMessage:@"Error" Title:nil];
//        }
//    }];
    
}
- (IBAction)tapImage:(id)sender {
    if ([self.aDelegate isKindOfClass:[UIViewController class]]) {
        UIViewController* vc = (UIViewController*)self.aDelegate;
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"ViewPhotoFull" owner:vc options:nil];
        ViewPhotoFull* view = array[0];
        [view firstProcess:@{@"vc":vc,@"image":self.imgContent.image,@"aDelegate":self}];
        
        self.dialog = [[MyPopupDialog alloc] init];
        [self.dialog setup:view backgroundDismiss:true backgroundColor:[UIColor grayColor]];
        
        if ([vc isKindOfClass:[OrderFrameViewController class]]) {
            OrderFrameViewController*vcc = vc;
            if(vcc.rootVC!=nil)
                [self.dialog showPopup:vcc.rootVC.view];
        }else{
            [self.dialog showPopup:vc.view];
        }
        
    }
    
}

- (IBAction)onClose:(id)sender {
    if (_aDelegate!=nil) {
        [_aDelegate didSubmit:@{@"mode":_mode} View:self];
        self.filePath = nil;
    }
}
@end
