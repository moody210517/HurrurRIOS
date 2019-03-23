//
//  TrackingCorViewController.h
//  Logistika
//
//  Created by BoHuang on 5/2/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"
#import "OrderModel.h"
#import "DateModel.h"
#import "OrderCorporateHisModel.h"
#import "BorderLabel.h"
#import "OrderCorporateHisModel.h"
#import "OrderResponse.h"

@interface TrackingCorViewController : BasicViewController


@property (strong, nonatomic) OrderResponse* response;

@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

@property (strong, nonatomic) UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_TH;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;

@property (weak, nonatomic) IBOutlet UIView *viewHeader_CAMERA;
@property (weak, nonatomic) IBOutlet UIView *viewHeader_ITEM;
@property (weak, nonatomic) IBOutlet UIView *viewHeader_PACKAGE;

//@property (weak, nonatomic) IBOutlet UIButton *btnAction;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lblPickName;

@property (weak, nonatomic) IBOutlet UILabel *lblPickAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPickCity;
@property (weak, nonatomic) IBOutlet UILabel *lblPickState;
@property (weak, nonatomic) IBOutlet UILabel *lblPickPincode;
@property (weak, nonatomic) IBOutlet UILabel *lblPickPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblPickLandMark;
@property (weak, nonatomic) IBOutlet UILabel *lblPickInst;

@property (weak, nonatomic) IBOutlet UILabel *lblDestAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblDestCity;
@property (weak, nonatomic) IBOutlet UILabel *lblDestState;
@property (weak, nonatomic) IBOutlet UILabel *lblDestPincode;
@property (weak, nonatomic) IBOutlet UILabel *lblDestPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblDestLandMark;
@property (weak, nonatomic) IBOutlet UILabel *lblDestInst;
@property (weak, nonatomic) IBOutlet UILabel *lblDestName;

@property (weak, nonatomic) IBOutlet UILabel *lblPickDate;
@property (weak, nonatomic) IBOutlet UILabel *lblServiceLevel;
@property (weak, nonatomic) IBOutlet UILabel *lblPaymentMethod;
@property (weak, nonatomic) IBOutlet UIView *viewContent;
//@property (weak, nonatomic) IBOutlet UIView *viewNewDate;

@property (weak, nonatomic) IBOutlet UILabel *lblTracking;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderNumber;

-(void)setModelData:(OrderCorporateHisModel*)model VC:(UIViewController*)vc;
-(void)firstProcess:(int)mode Data:(OrderCorporateHisModel*)model VC:(UIViewController*)vc;
@property (assign, nonatomic) int mode;
@property (assign, nonatomic) CGFloat cellHeight;
@property (strong, nonatomic) OrderModel* orderModel;
@property (strong, nonatomic) OrderCorporateHisModel* data;

@property (strong, nonatomic) DateModel* dateModel;

@property (strong, nonatomic) UIViewController* vc;

@property (assign, nonatomic) BOOL modelSet;
@property (weak, nonatomic) IBOutlet UIView *viewAdditional;
@property (weak, nonatomic) IBOutlet UILabel *lblFrieght;
@property (weak, nonatomic) IBOutlet UILabel *lblLoadType;
@property (weak, nonatomic) IBOutlet UILabel *lblScanCon;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;
@property (weak, nonatomic) IBOutlet UILabel *lblVehicleNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblDriverID;
@property (weak, nonatomic) IBOutlet UILabel *lblDriverName;
@property (weak, nonatomic) IBOutlet UIImageView *imgSignature;
@property (weak, nonatomic) IBOutlet UIImageView *imgSignature_recv;

@property (weak, nonatomic) IBOutlet UIImageView *imgDrop;

@property (strong, nonatomic) NSString* trackID;
@property (weak, nonatomic) IBOutlet UIButton *btnPos;
@property (weak, nonatomic) IBOutlet UIImageView *imgPos;

@property (weak, nonatomic) IBOutlet UILabel *lblDeliver;
@property (weak, nonatomic) IBOutlet UILabel *lblType;
@end
