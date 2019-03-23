
#import <Foundation/Foundation.h>

@interface EnvVar : NSObject
@property (nonatomic, copy) NSString * username;
@property (nonatomic, copy) NSString * password;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * avatar;
@property (nonatomic, copy) NSString * token;
@property (nonatomic, copy) NSString * fbtoken;
@property (nonatomic, copy) NSString * email;
@property (nonatomic, copy) NSString * fbid;
@property (nonatomic, assign) long lastLogin;
@property (nonatomic, copy) NSString * pushtoken;

@property (nonatomic, copy) NSString * first_name;
@property (nonatomic, copy) NSString * last_name;
@property (nonatomic, copy) NSString * country;
@property (nonatomic, assign) long introviewed;

@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * user_type;
@property (nonatomic, copy) NSString * address1;
@property (nonatomic, copy) NSString * address_id;
@property (nonatomic, copy) NSString * address2;
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * state;
@property (nonatomic, copy) NSString * pincode;
@property (nonatomic, copy) NSString * landmark;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, assign) BOOL  quote;
@property (nonatomic, assign) long  mode;
@property (nonatomic, copy) NSString * order_id;
@property (nonatomic, copy) NSString * question;
@property (nonatomic, copy) NSString * answer;
@property (nonatomic, copy) NSString * term;
@property (nonatomic, copy) NSString * policy;
@property (nonatomic, copy) NSString * feedback_id;
@property (nonatomic, copy) NSString * corporate_user_id;
@property (nonatomic, copy) NSString * cor_email;
@property (nonatomic, copy) NSString * cor_password;
@property (nonatomic, copy) NSString * cor_order_id;
@property (nonatomic, copy) NSString * quote_id;


- (BOOL)hasLoginDetails;
- (void)logOut;
- (void) loadFromDefaults;

- (id) initTemp;

- (void)saveDefaults:(NSString *)key value:(id)obj;
- (void)saveDefaultsLong:(NSString *)key value:(long)v;
//customFunctions
-(void)saveToken;
@end
