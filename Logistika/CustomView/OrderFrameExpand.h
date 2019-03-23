//
//  OrderFrameExpand.h
//  Logistika
//
//  Created by BoHuang on 7/11/18.
//  Copyright © 2018 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderBaseView.h"

@interface OrderFrameExpand : OrderBaseView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lblOrderNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblTracking;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UIButton* btnCancel;
@property (weak, nonatomic) IBOutlet UIButton* btnReschedule;
@property (weak, nonatomic) IBOutlet UIButton* btnPos;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_Height;


-(void)firstProcess:(NSDictionary*)data;

@property (weak, nonatomic) IBOutlet UIStackView *stackRoot;

@property (strong, nonatomic) UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_TH;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;

@property (weak, nonatomic) IBOutlet UIView *viewHeader_CAMERA;
@property (weak, nonatomic) IBOutlet UIView *viewHeader_PACKAGE;
@property (weak, nonatomic) IBOutlet UIView *viewHeader_ITEM;


//@property (weak, nonatomic) IBOutlet UIButton *btnAction;

@property (weak, nonatomic) IBOutlet UITableView *tableView_items;

@property (weak, nonatomic) IBOutlet UILabel *lblPickName;
@property (weak, nonatomic) IBOutlet UILabel *lblPickAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPickLandMark;
//@property (weak, nonatomic) IBOutlet UILabel *lblPickCity;
//@property (weak, nonatomic) IBOutlet UILabel *lblPickState;
//@property (weak, nonatomic) IBOutlet UILabel *lblPickPincode;
@property (weak, nonatomic) IBOutlet UILabel *lblPickPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblPickInst;

@property (weak, nonatomic) IBOutlet UILabel *lblDestName;
@property (weak, nonatomic) IBOutlet UILabel *lblDestAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblDestLandMark;
//@property (weak, nonatomic) IBOutlet UILabel *lblDestCity;
//@property (weak, nonatomic) IBOutlet UILabel *lblDestState;
//@property (weak, nonatomic) IBOutlet UILabel *lblDestPincode;
@property (weak, nonatomic) IBOutlet UILabel *lblDestPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblDestInst;


@property (weak, nonatomic) IBOutlet UILabel *lblPickDate;
@property (weak, nonatomic) IBOutlet UILabel *lblServiceLevel;
@property (weak, nonatomic) IBOutlet UILabel *lblPaymentMethod;


@property (assign, nonatomic) CGFloat cellHeight;
@property (strong, nonatomic) OrderModel* orderModel;
//@property (strong, nonatomic) DateModel* dateModel;

@property (weak, nonatomic) IBOutlet UIImageView *imgDrop;
@property (weak, nonatomic) IBOutlet UIImageView *imgStep;


@property (nonatomic,strong) NSMutableDictionary* height_dict;
@property (nonatomic,assign) CGFloat tableHeight;

@property (weak, nonatomic) IBOutlet UILabel *lblStat1;
@property (weak, nonatomic) IBOutlet UILabel *lblStat2;
@property (weak, nonatomic) IBOutlet UILabel *lblStat3;

//@property (weak, nonatomic) IBOutlet UIView *viewSchedule;


@end
