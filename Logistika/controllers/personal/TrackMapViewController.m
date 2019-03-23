//
//  TrackMapViewController.m
//  Logistika
//
//  Created by BoHuang on 6/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "TrackMapViewController.h"
#import "CGlobal.h"
#import "InfoView1.h"
#import "InfoView2.h"
#import "OrderModel.h"
#import "NetworkParser.h"
#import "GooglePlaceResult.h"
#import "UIImageView+WebCache.h"
#import "LoginResponse.h"
#import "Step.h"

@interface TrackMapViewController ()
//@property (nonatomic,strong) NSMutableArray* pointLists;
@property (nonatomic,assign) CLLocationCoordinate2D sourcePosition;
@property (nonatomic,assign) CLLocationCoordinate2D destinationPosition;
@property (nonatomic,assign) CLLocationCoordinate2D packageLocaion;
@property (nonatomic,strong) NSString* sourcePosition_exists;
@property (nonatomic,strong) NSString* packageLocaion_exists;

@property (nonatomic,assign) CLLocationCoordinate2D userPosition;
@property (nonatomic,assign) CLLocationCoordinate2D pinSourcePosition;
@property (nonatomic,assign) CLLocationCoordinate2D pinDestiniationPosition;

@property (nonatomic,strong) GMSMarker* packageMarker;
@property (nonatomic,strong) GMSMarker* sourceMarker;
@property (nonatomic,strong) GMSMarker* destinationMarker;

@property (nonatomic,strong) OrderModel* orderModel;

@property (nonatomic,strong) NSTimer* trackTimer;
@property (nonatomic,strong) GMSPolyline* m_GMSPolyline;

@end

@implementation TrackMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_SECONDARY_THIRD;
    // Do any additional setup after loading the view.
    _lblName.text = self.orderResponse.orderTrackModel.first_name;
    _lblPhone.text =    self.orderResponse.orderTrackModel.phone;
    
    self.mapView.myLocationEnabled = true;
    self.mapView.settings.myLocationButton = true;
    
//    _pointLists = [[NSMutableArray alloc] init];
    if ([self.orderResponse.orderTrackModel.pickup length]>0 && [self.orderResponse.orderTrackModel.location length]>0) {
        NSArray* str_pickup =  [self.orderResponse.orderTrackModel.pickup componentsSeparatedByString:@","];
        NSArray* str_location = [self.orderResponse.orderTrackModel.location componentsSeparatedByString:@","];
        
        @try {
            self.sourcePosition = CLLocationCoordinate2DMake([str_pickup[0] doubleValue], [str_pickup[1] doubleValue]);
            self.sourcePosition_exists = @"1";
        } @catch (NSException *exception) {
            
        }
        
        @try {
            self.packageLocaion = CLLocationCoordinate2DMake([str_location[0] doubleValue], [str_location[1] doubleValue]);
            self.packageLocaion_exists = @"1";
        } @catch (NSException *exception) {
            
        }
        
    }
    
    NSString* path1 = [NSString stringWithFormat:@"%@%@%@%@",g_baseUrl,PHOTO_URL,@"employer/",self.orderResponse.orderTrackModel.picture];
    [_imgView1 sd_setImageWithURL:[NSURL URLWithString:path1]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        }];
    
    self.mapView.camera = [[GMSCameraPosition alloc] initWithTarget:self.userPosition zoom:gms_camera_zoom bearing:0 viewingAngle:0];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        double lat = 35.89093;
        double lng = -106.326907;
        if (g_lastLocation !=nil) {
            lat = g_lastLocation.coordinate.latitude;
            lng = g_lastLocation.coordinate.longitude;
        }
        self.userPosition = CLLocationCoordinate2DMake(lat, lng);
        if (self.packageLocaion_exists!=nil) {
            
            GMSMarker* marker = [[GMSMarker alloc] init];
            marker.title = @"Package Location";
            marker.snippet = @"2";
            marker.userData = @{@"type":@"2"};
            marker.position = self.packageLocaion;
            marker.icon = [CGlobal getImageForMap:@"box.png"];
            marker.map = self.mapView;
            
            self.packageMarker = marker;
            
        }
        
        self.sourcePosition = CLLocationCoordinate2DMake(g_addressModel.sourceLat, g_addressModel.sourceLng);
        self.destinationPosition = CLLocationCoordinate2DMake(g_addressModel.desLat, g_addressModel.desLng);
        
        GMSMarker* marker = [[GMSMarker alloc] init];
        marker.title = @"source";
        marker.snippet = @"1";
        marker.position = self.sourcePosition;
        marker.icon = [CGlobal getImageForMap:@"org_set.png"];
        marker.map = self.mapView;
        marker.userData = @{@"type":@"1"};
        self.sourceMarker = marker;
        
        marker = [[GMSMarker alloc] init];
        marker.title = @"des";
        marker.snippet = @"1";
        marker.position = self.destinationPosition;
        marker.icon = [CGlobal getImageForMap:@"dest_set.png"];
        marker.map = self.mapView;
        marker.userData = @{@"type":@"1"};
        self.destinationMarker = marker;
        
        self.mapView.delegate = self;
        
        if ([_packageLocaion_exists isEqualToString:@"1"]) {
            self.mapView.camera = [[GMSCameraPosition alloc] initWithTarget:_packageLocaion zoom:gms_camera_zoom bearing:0 viewingAngle:0];
        }else{
            self.mapView.camera = [[GMSCameraPosition alloc] initWithTarget:_userPosition zoom:gms_camera_zoom bearing:0 viewingAngle:0];
        }
        
        [self drawPath:self.sourcePosition Dest:self.destinationPosition];
        
        
    });
    
    //[self startTrackTimer];
}

-(void)drawPath:(CLLocationCoordinate2D)source Dest:(CLLocationCoordinate2D) dest{
    if (source.latitude == 0 && source.longitude == 0) {
        return;
    }
    if (dest.latitude == 0 && dest.longitude == 0) {
        return;
    }
    
    if (dest.latitude!=0) {
        NSString* path = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&mode=driving&sensor=false&key=AIzaSyBRHZ24e9OnPUSM4J2pLfOzVGrXBkFia_g",source.latitude,source.longitude,dest.latitude,dest.longitude];
        [CGlobal showIndicator:self];
        NetworkParser* manager = [NetworkParser sharedManager];

        [manager ontemplateGeneralRequestWithRawUrl:nil
           Path:path withCompletionBlock:^(NSDictionary *dict, NSError *error) {
               
               
               if (self.sourceMarker!=nil && self.destinationMarker!=nil) {
                   //
                   LoginResponse* resp = [[LoginResponse alloc] initWithDictionaryForRoute:dict];
                   //                resp.route.listStep
                   GMSMutablePath* path = [GMSMutablePath path];
                   NSArray* step = resp.route.listStep;
                   for (int i=0; i<step.count; i++) {
                       Step* istep = step[i];
                       NSMutableArray*listPoints = istep.listPoints;
                       for (int j=0; j<listPoints.count; j++) {
                           NSValue* value = listPoints[j];
                           CGPoint pt = [value CGPointValue];
                           [path addCoordinate:CLLocationCoordinate2DMake(pt.x, pt.y)];
                       }
                   }
                   if(self.m_GMSPolyline!=nil){
                       _m_GMSPolyline.map = nil;
                       _m_GMSPolyline = nil;
                   }
                   
                   GMSPolyline* myLine = [GMSPolyline polylineWithPath:path];
                   myLine.strokeColor = COLOR_PRIMARY;
                   myLine.strokeWidth = 2.0f;
                   myLine.map = self.mapView;
                   
                   self.m_GMSPolyline = myLine;
                   
                   GMSCoordinateBounds*bound = [[GMSCoordinateBounds alloc] initWithPath:path];
                   [self.mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bound withPadding:30]];
               }
               [CGlobal stopIndicator:self];
               
               
           } method:@"get"];
        

//        [manager ontemplateGeneralRequestWithRawUrl:nil Path:path withCompletionBlock:^(NSDictionary *dict, NSError *error) {
//
//        }];
    }
}



-(void)viewDidAppear:(BOOL)animated{
    [self startTrackTimer];
    NSLog(@"viewDidAppear  startTrackTimer");
}
-(void)viewDidDisappear:(BOOL)animated{
    [self stopTrackTimer];
    NSLog(@"viewDidDisappear  stopTrackTimer");
}
-(void)stopTrackTimer{
    if (self.trackTimer!=nil) {
        [self.trackTimer invalidate];
        self.trackTimer = nil;
    }
}
-(void)startTrackTimer{
   // [self startTrackTimer];
    self.trackTimer = [NSTimer scheduledTimerWithTimeInterval:11 target:self selector:@selector(runnableTrack) userInfo:nil repeats:true];
}
-(void)updatePackageLocationData:(OrderResponse*) param{
    if ([param.orderTrackModel.pickup length]>0 && [param.orderTrackModel.location length]>0) {
        NSArray* str_pickup =  [self.orderResponse.orderTrackModel.pickup componentsSeparatedByString:@","];
        NSArray* str_location = [self.orderResponse.orderTrackModel.location componentsSeparatedByString:@","];
        
        self.orderResponse.orderTrackModel.pickup   = param.orderTrackModel.pickup;
        self.orderResponse.orderTrackModel.location = param.orderTrackModel.location;
        
        @try {
            self.sourcePosition = CLLocationCoordinate2DMake([str_pickup[0] doubleValue], [str_pickup[1] doubleValue]);
            self.sourcePosition_exists = @"1";
        } @catch (NSException *exception) {
            
        }
        
        @try {
            self.packageLocaion = CLLocationCoordinate2DMake([str_location[0] doubleValue], [str_location[1] doubleValue]);
            self.packageLocaion_exists = @"1";
            
        } @catch (NSException *exception) {
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.packageMarker.position = self.packageLocaion;
            NSLog(@"packageLOCATION UPDATED lat=%f lng=%f",self.packageLocaion.latitude,self.packageLocaion.longitude);
        });
    }
}
-(void)runnableTrack{
    NetworkParser* manager = [NetworkParser sharedManager];
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    params[@"order_id"] = self.orderResponse.orderTrackModel.order_id;
    params[@"employer_id"] = self.orderResponse.orderTrackModel.employer_id;;
    params[@"type"] = [NSNumber numberWithInt:g_mode];
    
    [manager ontemplateGeneralRequest2:params BasePath:@"" Path:@"/Track/order_track" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            if (dict!=nil && dict[@"result"] != nil) {
                //
                if([dict[@"result"] intValue] == 200){
                    OrderResponse* response = [[OrderResponse alloc] initWithDictionary_track:dict];
                    if (response.orderTrackModel!=nil) {
                        response.orderTrackModel.type = @"200";
                        [self updatePackageLocationData:response];
                        
                        return;
                    }
                }else if ([dict[@"result"] intValue] == 300){
                    OrderResponse* response = [[OrderResponse alloc] initWithDictionary_track:dict];
                    if (response.orderTrackModel!=nil) {
                        response.orderTrackModel.type = @"300";
                        
                        [self updatePackageLocationData:response];
                        return;
                    }
                }
            }
        }else{
            NSLog(@"Error");
        }
    } method:@"POST"];
}
- (IBAction)tapCall:(id)sender {
    NSString*phone = [NSString stringWithFormat:@"tel:%@",self.lblPhone.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = false;
    self.title = @"Track";
}
- (IBAction)tapZoomButton:(UIView*)sender {
    int tag = sender.tag;
    if (tag == 1) {
        float zoom = self.mapView.camera.zoom;
        zoom = zoom + 0.5;
        [self.mapView animateToZoom:zoom];
    }else if(tag == 2){
        float zoom = self.mapView.camera.zoom;
        zoom = zoom - 0.5;
        if (zoom>0) {
            [self.mapView animateToZoom:zoom];
        }
        
    }
}
-(void)getGpsFromPinCode:(NSString*)pincode Number:(int)number{
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    data[@"address"] = pincode;
    data[@"sensor"] = @"false";
    data[@"key"] = @"AIzaSyBRHZ24e9OnPUSM4J2pLfOzVGrXBkFia_g";
    
    NSString* path = @"https://maps.googleapis.com/maps/api/geocode/json";
    NetworkParser* manager = [NetworkParser sharedManager];
    [manager ontemplateGeneralRequestWithRawUrl:data Path:path withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        GooglePlaceResult* resp = [[GooglePlaceResult alloc] initWithDictionary:dict];
        if (resp.results.count > 0) {
            GooglePlace*place = resp.results[0];
            if (number == 1) {
                self.pinSourcePosition = CLLocationCoordinate2DMake([place.geometry.location.lat doubleValue], [place.geometry.location.lng doubleValue]);
                [self getGpsFromPinCode:g_addressModel.desPinCode Number:2];
            }else{
                self.pinDestiniationPosition = CLLocationCoordinate2DMake([place.geometry.location.lat doubleValue], [place.geometry.location.lng doubleValue]);
                if ([self.orderResponse.orderTrackModel.pickup length]>0 && [self.orderResponse.orderTrackModel.location length]>0) {
                    if ([self.orderResponse.orderTrackModel.pickup isEqualToString:self.orderResponse.orderTrackModel.location]) {
                        // when source, package equals
                        //
                        GMSMarker* marker = [[GMSMarker alloc] init];
                        marker.title = @"source";
                        marker.snippet = @"1";
                        marker.position = self.pinSourcePosition;
                        marker.icon = [CGlobal getImageForMap:@"source.png"];
                        marker.map = self.mapView;
                        marker.userData = @{@"type":@"1"};
                        self.sourceMarker = marker;
                        
                        marker = [[GMSMarker alloc] init];
                        marker.title = @"des";
                        marker.snippet = @"1";
                        marker.position = self.pinDestiniationPosition;
                        marker.icon = [CGlobal getImageForMap:@"source.png"];
                        marker.map = self.mapView;
                        marker.userData = @{@"type":@"1"};
                        self.destinationMarker = marker;
                    }else{
                        // when different
//                        NSArray* str_pickup = self.pointLists[0];
                        NSArray* str_pickup;
                        CLLocationCoordinate2D pos = CLLocationCoordinate2DMake([str_pickup[0] doubleValue], [str_pickup[1] doubleValue]);
                        
                        GMSMarker* marker = [[GMSMarker alloc] init];
                        marker.title = @"source";
                        marker.snippet = @"1";
                        marker.position = pos;
                        marker.icon = [CGlobal getImageForMap:@"source.png"];
                        marker.map = self.mapView;
                        marker.userData = @{@"type":@"1"};
                        self.sourceMarker = marker;
                        
                        marker = [[GMSMarker alloc] init];
                        marker.title = @"des";
                        marker.snippet = @"1";
                        marker.position = self.pinDestiniationPosition;
                        marker.icon = [CGlobal getImageForMap:@"source.png"];
                        marker.map = self.mapView;
                        marker.userData = @{@"type":@"1"};
                        self.destinationMarker = marker;
                    }
                }
            }
        }else{
            [CGlobal AlertMessage:@"Fail" Title:nil];
        }
        
    } method:@"get"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
    
    if([marker.userData isKindOfClass:[NSDictionary class]]){
        NSDictionary* userData = marker.userData;
        int type = [userData[@"type"] intValue];
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"UserInfoWindow" owner:self options:nil];
        
        if (type == 1) {
            InfoView1* view = array[0];
            NSString* title = marker.title;
            if ([title isEqualToString:@"source"]) {
                view.lblSource.text = @"Source Location";
                view.lblAddress.text = g_addressModel.sourceAddress;
                view.lblArea.text = g_addressModel.sourceArea;
                view.lblCity.text = g_addressModel.sourceCity;
            }else{
                view.lblSource.text = @"Destination Location";
                view.lblAddress.text = g_addressModel.desAddress;
                view.lblArea.text = g_addressModel.desArea;
                view.lblCity.text = g_addressModel.desCity;
            }
            
            CGRect frame = view.frame;
            CGRect scRect = [[UIScreen mainScreen] bounds];
            scRect.size.width = MIN(scRect.size.width -32,320);
            
            CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, scRect.size.width, [view getHeight]);
            view.frame = newFrame;
            
            return view;
        }else{
            InfoView2* view = array[1];
            NSString* snipt = marker.snippet;
            if ([snipt length]>0) {
                if ([g_state isEqualToString:@"0"]) {
                    view.lblStatus.text = @"Status: Cancel";
                }else if ([g_state isEqualToString:@"1"]) {
                    view.lblStatus.text = @"Status: In Process";
                }else if ([g_state isEqualToString:@"2"]) {
                    view.lblStatus.text = @"Status: On the way for pickup";
                }else if ([g_state isEqualToString:@"3"]) {
                    view.lblStatus.text = @"Status: On the way to destination";
                }else if ([g_state isEqualToString:@"4"]) {
                    view.lblStatus.text = @"Status: Order Delivered";
                }else if ([g_state isEqualToString:@"5"]) {
                    view.lblStatus.text = @"Status: Order on hold";
                }else if ([g_state isEqualToString:@"6"]) {
                    view.lblStatus.text = @"Status: Returned Order";
                }
                
                [view setData:@{@"vc":self}];
                CGRect frame = view.frame;
                CGRect scRect = [[UIScreen mainScreen] bounds];
                scRect.size.width = MIN(scRect.size.width -32,320);
                
                CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, scRect.size.width, [view getHeight]);
                view.frame = newFrame;
                
                return view;
            }
            
        }
    }
    return nil;
}
@end
