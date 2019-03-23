//
//  PickupLocationViewController.h
//  Logistika
//
//  Created by BoHuang on 7/25/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BasicViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "ColoredButton.h"
#import "ColoredView.h"

@interface PickupLocationViewController : BasicViewController<UITableViewDelegate,UITableViewDataSource,GMSMapViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UITextField *edt_location;
@property (weak, nonatomic) IBOutlet UITableView *autocompleteTable;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet ColoredButton *btnDone;

@property (weak, nonatomic) IBOutlet UIView *viewMap1;
@property (weak, nonatomic) IBOutlet ColoredView *viewPick2;

@property (weak, nonatomic) IBOutlet UIView *topBar;
@property (weak, nonatomic) IBOutlet UIButton *topbar_btn_search;
@property (weak, nonatomic) IBOutlet UILabel *topbar_lbl_location;
@property (weak, nonatomic) IBOutlet UIImageView *topbar_imgsearch;
@property (weak, nonatomic) IBOutlet UILabel *topbar_lbl_chooselocation;
@property (copy, nonatomic) NSString* type;
@property (assign, nonatomic) int pageIndex;
@end
