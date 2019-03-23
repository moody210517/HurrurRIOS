//
//  ProductCellCamera.m
//  Logistika
//
//  Created by BoHuang on 4/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ProductCellCamera.h"

#import "CGlobal.h"

@implementation ProductCellCamera

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(CGFloat)getHeight{
    return 100;
}
-(void)initMe:(NSDictionary*)data{
    self.backgroundColor = [UIColor whiteColor];
    [self.cbWeight setDelegate:self];
    [self.cbQuantity setDelegate:self];
    
    self.cbWeight.entries = c_weight;
    self.cbQuantity.entries = c_quantity;
    if ([data[@"data"] isKindOfClass:[ItemModel class]]) {
        ItemModel* model = data[@"data"];
        
        self.imgContent.image = model.image_data;
        
        NSInteger found = [c_weight indexOfObject:model.weight];
        if (found!=NSNotFound) {
            self.cbWeight.selectedItem = found;
        }
        
        NSInteger found2 = [c_quantity indexOfObject:model.quantity];
        if (found2!=NSNotFound) {
            self.cbQuantity.selectedItem = found2;
        }
        self.data = model;
        
        
    }
    [self.btnRemove addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    self.btnRemove.tag = 100;
}
-(void)clickView:(UIView*)sender{
    int tag = (int)sender.tag;
    switch (tag) {
        case 100:
        {
            if (self.aDelegate!=nil) {
                [self.aDelegate didSubmit:@{@"action":@"remove"} View:self];
            }
            break;
        }
        default:
            break;
    }
}
-(void)comboBox:(UIComboBox *)comboBox selected:(int)selected{
    if (comboBox == self.cbQuantity) {
        
    }else{
        if (self.aDelegate!=nil) {
            [self.aDelegate didSubmit:@{@"action":@"select",@"weight_index":[NSNumber numberWithInt:selected]} View:self];
        }
    }
}
@end
