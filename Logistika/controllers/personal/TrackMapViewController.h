//
//  TrackMapViewController.h
//  Logistika
//
//  Created by BoHuang on 6/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BasicViewController.h"
#import "OrderResponse.h"
#import <GoogleMaps/GoogleMaps.h>
@interface TrackMapViewController : UIViewController<GMSMapViewDelegate>
@property (nonatomic,strong) OrderResponse* orderResponse;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgView1;



@end
