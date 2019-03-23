//
//  CGlobal.h
//  SchoolApp
//
//  Created by apple on 9/24/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
#import "WNAActivityIndicator.h"
#import "NSString+Common.h"
#import "CustomTextField.h"
#import "EnvVar.h"
#import <CoreLocation/CLLocation.h>
#import "TblUser.h"
#import "LoginResponse.h"
#import "ECDrawerLayout.h"
#import "OrderModel.h"
#import "AddressModel.h"
#import "DateModel.h"
#import "ServiceModel.h"
#import "CarrierModel.h"
#import "PriceType.h"
#import "CorporateModel.h"
#import "ItemModel.h"
#import "QuoteCoperationModel.h"
#import "CityModel.h"

extern  UIColor*   COLOR_TOOLBAR_TEXT;
extern  UIColor*   COLOR_TOOLBAR_BACK;
extern  UIColor*   COLOR_PRIMARY;
extern  UIColor*   COLOR_PRIMARY_BAR;
extern  UIColor*   COLOR_SECONDARY_PRIMARY;
extern  UIColor*   COLOR_SECONDARY_GRAY;
extern  UIColor*   COLOR_SECONDARY_THIRD;
extern  UIColor*   COLOR_RESERVED;
extern  UIColor*   COLOR_RESERVED2;

extern  NSString * g_baseUrl;
extern  NSString* BASE_URL;
extern  NSString* BASE_DATA_URL;
extern  NSString* BASE_URL_ORDER;
extern  NSString* FORGOT ;
extern  NSString* ZIP_LOCATION ;
extern  NSString* PHOTO_URL ;
extern  NSString*   symbol_dollar;
extern  NSString*   support_phone;

extern BOOL g_isii;
extern int g_location_cnt;

extern  NSString*   APISERVICE_IP_URL;
extern  NSString*   APISERVICE_MAP_URL;
extern  NSString*   COMMON_PATH1;

extern  NSString*   ACTION_LOGIN;
extern  NSString*   ACTION_CONFIRM;
extern  NSString*   ACTION_ADD_FRIEND;
extern  NSString*   ACTION_INVITE_GAME;
extern  NSString*   ACTION_UPDATE_GAME;
extern  NSString*   ACTION_GET_BELL;
extern  NSString*   ACTION_CONQUERED_COUNTRY;
extern  NSString*   ACTION_UPLOAD;
extern  NSString*   ACTION_LIKEPIC;
extern  NSString*   ACTION_REPORT;
extern  NSString*   ACTION_ACTIVEBIDS ;
extern  NSString*   ACTION_MAKEPOST ;
extern  NSString*   ACTION_COMMENT ;
extern  NSString*   ACTION_USERINFO ;
extern  NSString*   ACTION_UPDATEPROFILE ;
extern  NSString*   ACTION_LOADNOTI ;
extern  NSString*   ACTION_TOGO_IDS ;
extern  NSString*   ACTION_TOGO_DATA ;
extern  NSString*   ACTION_CONQUERED_DATA ;

extern  NSString*   ACTION_DEFAULTPROFILE ;


extern  NSString*   G_SHARETEXT ;

extern int gms_camera_zoom;
extern NSDictionary*g_launchoptions;
extern int g_mode;
extern int c_PERSONAL;
extern int c_GUEST ;
extern int c_CORPERATION ;
extern NSString *g_guestEmail;

extern int g_ORDER_TYPE;
extern int g_CAMERA_OPTION;
extern int g_ITEM_OPTION;
extern int g_PACKAGE_OPTION;
extern int g_limitCnt;
extern int g_limitCamera;
extern CGFloat g_txtBorderWidth;

extern NSArray* g_securityList;
extern NSArray* c_quantity;
extern NSArray* c_weight;
extern NSArray* c_weight_value;
extern NSArray* c_packageLists;
extern NSArray* c_paymentWay;
extern NSArray* c_menu_title;

extern NSString* PUBLISHABLE_KEY;
extern NSString* curPaymentWay;
extern NSString* eamil_guest;
//card validataion


//basic data
extern OrderModel* g_cameraOrderModel;
extern OrderModel* g_itemOrderModel;
extern OrderModel* g_packageOrderModel;

extern AddressModel* g_addressModel;
extern DateModel* g_dateModel;
extern ServiceModel* g_serviceModel;
extern CarrierModel* g_carrierModel;
extern NSString* g_state;
extern CLLocation* g_lastLocation;
extern QuoteCoperationModel* g_quoteCoperationModel;

extern NSMutableArray* g_quoteModels;
extern NSMutableArray* g_quoteCoperationModels;
extern NSMutableArray* g_orderHisModels;
extern NSMutableArray* g_orderCorporateHisModels;
extern NSMutableArray* g_cancelModels;
extern NSMutableArray* g_quoteModels;
extern NSMutableArray* g_orderRescheduleModels;
extern NSMutableArray* g_truckModels;
extern NSMutableArray* g_cityModels;
extern NSMutableArray* g_cityBounds;
extern CityModel* g_city_selection;

extern NSString* g_page_type;
extern NSString* g_quote_order_id;
extern NSString* g_quote_id;
extern PriceType* g_priceType;
extern CorporateModel* g_corporateModel;
extern LoginResponse* g_areaData;
extern CGRect g_keyboardRect;
extern NSString* g_track_id;


//notifications
extern NSString *GLOBALNOTIFICATION_DATA_CHANGED_PHOTO ;
extern NSString *GLOBALNOTIFICATION_MAP_PICKLOCATION ;
extern NSString *GLOBALNOTIFICATION_RECEIVE_USERINFO_SUCC;
extern NSString *GLOBALNOTIFICATION_RECEIVE_USERINFO_FAIL;
extern NSString *GLOBALNOTIFICATION_CHANGEVIEWCONTROLLER;
extern NSString *GLOBALNOTIFICATION_CHANGEVIEWCONTROLLERREBATE;
extern NSString *GLOBALNOTIFICATION_MQTTPAYLOAD;
extern NSString *GLOBALNOTIFICATION_MQTTPAYLOAD_PROCESS;
extern NSString *GLOBALNOTIFICATION_ADDRESSPICKUP;
extern NSString *GLOBALNOTIFICATION_LIKEDBUTTON;

extern NSString *NOTIFICATION_RECEIVEUUID;

extern NSString *const kPhotoManagerChangedContentNotificationHot;
extern NSString *const kPhotoManagerChangedContentNotificationFresh;
extern NSString *const kPhotoManagerChangedContentNotificationOthers;

//menu height
extern CGFloat GLOBAL_MENUHEIGHT;
extern CGFloat GLOBAL_MENUWIDTH;

typedef void (^PermissionCallback)(BOOL ret);
typedef void (^ImagePickerCallback)(UIImage* image);

@interface CGlobal : NSObject
+ (CGlobal *)sharedId;

@property (nonatomic, strong) TblUser* curUser;
@property (nonatomic, strong) LoginResponse* loginResponse;
@property (nonatomic, assign) CLLocationCoordinate2D defaultPos;
@property (nonatomic, strong) EnvVar * env;

// COMMON FUMCTIONS
+(void)makeTermsPrivacyForLabel: (TTTAttributedLabel *) label withUrl:(NSString*)urlString;
+(void)initSample;
+(int)getOrientationMode;
+(void)showIndicator:(UIViewController*)viewcon;
+(void)stopIndicator:(UIViewController*)viewcon;
+(void)showIndicatorForView:(UIView*)viewcon;
+(void)stopIndicatorForView:(UIView*)viewcon;
+(void)AlertMessage:(NSString*)message Title:(NSString*)title;
+(void)backProcess;
+(void)backProcess:(UIViewController*)con Delegate:(id)mydelegate;
+(void)makeBorderBlackAndBackWhite:(UIView*)target;
+(void)makeBorderASUITextField:(UIView*)target;
+(CGFloat)heightForView:(NSString*)text Font:(UIFont*) font Width:(CGFloat) width;
+(NSString*)getUDID;
+(void)setDefaultBackground:(UIViewController*)viewcon;
+(NSString*) jsonStringFromDict:(BOOL) prettyPrint Dict:(NSDictionary*)dict;
+(NSString*)getEncodedString:(NSString*)input;
//+(BOOL)gotoViewController:(UIViewController*)controller Mode:(int) mode;

+(NSString*)getDateFromPickerForDb:(UIDatePicker*)datePicker;
+(NSDate*)getDateFromDbString:(NSString*)string;
+(NSDate*)getLocalDateFromDbString:(NSString*)string;
+(NSString*)getLocalDateFromDBString:(NSString*)string;
+(NSString*)getGmtHour;
+(NSString*)getCurrentTimeInGmt0;
+(NSString*)getTimeStringFromDate:(NSDate*)sourceDate;
+(NSArray*)getIntegerArrayFromRids:(NSString*)rids;
+(NSString*)getFormattedTimeFormPicker:(UIDatePicker*)picker;
+(int)ageFromBirthday:(NSDate *)birthdate;
+(NSString*)getAgoTime:(NSString*)param1 IsGmt:(BOOL)isGmt;
+(NSNumber*)getNumberFromStringForCurrency:(NSString*)formatted_str;
+(NSString*)getStringFromNumberForCurrency:(NSNumber*)number;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert Alpha:(CGFloat)alpha;
+(void)shareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url withView:(UIView*)view withController:(UIViewController*)controller;
+ (NSString *)urlencode:(NSString*)param1;
+(NSString*)timeStamp;
+(NSTimeInterval)timeStampInterval;
// program specific
+(void)setStyleForInput1:(UIView*)buttonView;
+(void)setStyleForInput2:(UIView*)viewRound View:(UIView*)viewtext Radius:(CGFloat)radius;
+(void)setStyleForInput3:(UIView*)viewRound TextField:(UITextField*)textField LeftorRight:(BOOL)isLeft Radius:(CGFloat)radius SelfView:(UIView*)view;
+(void)showMenu:(UIViewController*)viewcon;
+(void)hideMenu;
+(void)toggleMenu:(UIViewController*)viewcon;
+(void)addRangeSlider:(UIView*)view Min:(CGFloat)min Max:(CGFloat)max RangeSlider:(id)m_slider WithFrame:(CGRect)rect SliderType:(int)type;
+(NSString*)checkTimeForCreateBid:(NSString*)string;
+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
+ (UIImage*)getScaledImage:(UIImage*)image Source:(UIImagePickerControllerSourceType)sourceType;
+(void)removeDuplicatesForPhotos:(NSMutableArray*)source WithData:(NSMutableArray*)data;
//PARSING JSON

+(UIImage*)getImageForMap:(UIImage*)bm NSString:(NSString*)number;
+(UIImage*)getImageForMap:(NSString*)number;
-(instancetype)initWithDictionary:(NSDictionary*) dict;
+(NSMutableDictionary*)getQuestionDict:(id)targetClass;
+(void)parseResponse:(id)targetClass Dict:(NSDictionary*)dict;
+(id)getDuplicate:(id)targetClass;

+(NSData*)buildJsonData:(id)targetClass;
+ (UIImage *)ipMaskedImageNamed:(NSString *)name color:(UIColor *)color;
+ (UIImage *)scaleAndRotateImage:(UIImage *)image;
+ (CGSize)getSizeForAspect:(UIImage*)image Frame:(CGSize)frame;
+ (CGSize)getSizeForAspectFromSize:(CGSize)imageSize Frame:(CGSize)frame;
+(void)grantedPermissionCamera:(PermissionCallback)callback;
+(void)grantedPermissionPhotoLibrary:(PermissionCallback)callback;
+(UIImage*)getColoredImage:(NSString*)imgName Color:(UIColor*)color;
+(UIImage*)getColoredImageFromImage:(UIImage*)image Color:(UIColor*)color;
+(void) setTerm:(TTTAttributedLabel*)attributedLabel;
+(BOOL) isValidEmail:(NSString*)email;
+(NSString *) escapeString:(NSString *)string;
+(NSString*) getDateString:(NSInteger)offset;

+(void)initMenu:(UIViewController<ECDrawerLayoutDelegate>*)vc;
+(void)showWebView:(NSString*)title WEBVIEW:(UIWebView*)webview;
+(void)clearData;
+(void)initGlobal;
+(BOOL)validatePassword:(NSString*)password;
+(BOOL)isPostCode:(NSString*)postcode;
+(NSString*)encrypt:(NSString*)password;
+(NSString*)decrypt:(NSString*)password;
+(void)getImageFromPath:(NSString*)path CallBack:(ImagePickerCallback)callBack;

+(int)getTotalWeight;
+(NSString*)getDeviceID;
+(NSString*)getDeviceName;
+(NSComparisonResult)compareWithToday:(NSDate*)input DateStr:(NSString*)datestr mode:(int)mode;
+(NSString*)getTruck:(NSString*)truck;
+(BOOL)isPointInPolygon:(CLLocationCoordinate2D) tap ArrayList:(NSMutableArray*)vertices;
+(NSString*)getValidPhoneNumber:(NSString*)param Output:(int)output Prefix:(NSString*)prefix Length:(int)length;
+(CGFloat)tableView1:(UITableView *)tableView1 heightForRowAtIndexPath:(NSIndexPath *)indexPath DefaultHeight:(CGFloat)cellHeight Data:(OrderModel*)orderModel OrderType:(int)orderType Padding:(CGFloat)padding Width:(CGFloat)width;
+(NSDictionary*)processDataFor_OrderHistory:(NSDictionary *)dict Error:(NSError *)error;
+(void)callSupport;

+ (NSMutableArray*)polylineWithEncodedString:(NSString *)encodedString;
@end
