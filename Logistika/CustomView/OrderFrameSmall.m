//
//  OrderFrameSmall.m
//  Logistika
//
//  Created by BoHuang on 7/11/18.
//  Copyright © 2018 BoHuang. All rights reserved.
//

#import "OrderFrameSmall.h"


@implementation OrderFrameSmall

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(void)firstProcess:(NSDictionary*)data{
    self.original_data =data;
    self.vc = data[@"vc"];
    self.aDelegate = data[@"aDelegate"];
    self.data = data[@"model"];
    
    OrderHisModel* model = data[@"model"];
    
    self.lblTracking.text = model.trackId;
    self.lblOrderNumber.text = model.orderId;
    
    int state = [model.state intValue];
    _btnPos.hidden = true;
    _btnCancel.hidden = true;
    _btnReschedule.hidden = true;
    switch (state) {
        case 0:
        {
            _lblStatus.text = @"Order Cancel";
            break;
        }
        case 2:
        {
            _lblStatus.text = @"Associate on the way for pickup";
            _btnPos.hidden = false;
            break;
        }
        case 3:
        {
            _lblStatus.text = @"On the way to destination";
            _btnPos.hidden = false;
            break;
        }
        case 4:
        {
            _lblStatus.text = @"Order Delivered";
            break;
        }
        case 5:
        {
            _lblStatus.text = @"Order on hold";
            _btnPos.hidden = false;
            break;
        }
        case 6:
        {
            _lblStatus.text = @"Returned Order";
            break;
        }
        case 1:
        {
            _lblStatus.text = @"In Process";
            _btnCancel.hidden = false;
            _btnReschedule.hidden = false;
            break;
        }
        default:
            break;
    }
    
}
@end
