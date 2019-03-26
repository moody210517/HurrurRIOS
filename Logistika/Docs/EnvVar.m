
#import "EnvVar.h"
#import "macros.h"
#import "CGlobal.h"
#import "NetworkParser.h"
//Login keys
static NSString * kDefaultsUserNameKey = @"username";
static NSString * kDefaultsPasswordKey = @"password";

//updated keys
static NSString * kDefaultsLastLoggedInKey = @"LASTLOGGEDIN";

//My own keys


@interface EnvVar()
{
    BOOL bSaveDefaults;
}
@end

@implementation EnvVar

- (long) udLong:(NSString *)key default:(long)v
{
    if (UDValue(key))
    {
        return UDInteger(key);
    }
    else
    {
        //set default value and return default value;
        UDSetInteger(key, v);
        UDSync();
        return v;
    }
}
- (void) loadFromDefaults
{
    
    _username = UDValue(kDefaultsUserNameKey);
    _password = UDValue(kDefaultsPasswordKey);
    
    _lastLogin = UDInteger(kDefaultsLastLoggedInKey);
    _token = UDValue(@"token");
    _fbid = UDValue(@"fbid");
    _first_name = UDValue(@"first_name");
    _last_name = UDValue(@"last_name");
    _country = UDValue(@"country");
    _introviewed = UDInteger(@"introviewed");
    
    // introduced
    _user_id = UDValue(@"user_id");
    _user_type = UDValue(@"user_type");
    _address1 = UDValue(@"address1");
    _address_id = UDValue(@"address_id");
    _address2 = UDValue(@"address2");
    _city = UDValue(@"city");
    _state = UDValue(@"state");
    _pincode = UDValue(@"pincode");
    _landmark = UDValue(@"landmark");
    _phone = UDValue(@"phone");
    _quote = UDBool(@"quote");
    _quote = false;
    _mode = UDInteger(@"mode");
    _order_id = UDValue(@"order_id");
    _question = UDValue(@"question");
    _answer = UDValue(@"answer");
    _term = UDValue(@"term");
    _policy = UDValue(@"policy");
    _feedback_id = UDValue(@"feedback_id");
    _corporate_user_id = UDValue(@"corporate_user_id");
    _cor_email = UDValue(@"cor_email");
    _cor_password = UDValue(@"cor_password");
    _cor_order_id = UDValue(@"cor_order_id");
    _quote_id = UDValue(@"quote_id");
    
    if (_token == nil) {
        _token = @"123456789";
    }
    
    
    if (_pushtoken == nil) {
        _pushtoken = @"";
    }
    
    if (_first_name == nil) {
        _first_name = @"";
    }
    if (_last_name == nil) {
        _last_name = @"";
    }
    if (_country == nil) {
        _country = @"";
    }
    if (_feedback_id == nil) {
        _feedback_id = @"0";
    }
}

- (id) init
{
    self = [super init];
    if (self != nil)
    {
        bSaveDefaults = YES;
        [self loadFromDefaults];
    }
    return self;
}

- (id) initTemp
{
    self = [super init];
    if (self != nil)
    {
        bSaveDefaults = NO;
    }
    return self;
}

#pragma mark - Login environment variables....
- (void)saveDefaults:(NSString *)key value:(id)obj
{
    if (bSaveDefaults)
    {
        if (obj != nil)
            UDSetValue(key, obj);
        else
            UDRemove(key);
        UDSync();
    }

}

- (void)saveDefaultsLong:(NSString *)key value:(long)v
{
    if (bSaveDefaults)
    {
        UDSetInteger(key, v);
        UDSync();
    }
}
- (void)setUsername:(NSString *)username
{
    _username = [username copy];
    [self saveDefaults:kDefaultsUserNameKey value:username];
}

- (void)setPassword:(NSString *)password
{
    _password = password;
    [self saveDefaults:kDefaultsPasswordKey value:password];
}

- (BOOL)hasLoginDetails
{
    return self.username != nil && self.password != nil;
}

- (void)logOut
{
    [self setLastLogin:-1];
    if (self.mode == 0) {
        [self setUsername:@""];
        [self setEmail:@""];
        [self setPassword:@""];
        
        
    }else{
        [self setCor_email:@""];
        [self setCor_password:@""];
        
    }
    
//    [self setAddress1:@""];
//    [self setAddress2:@""];
//    [self setCity:@""];
//    [self setState:@""];
//    [self setPincode:@""];
//    [self setPhone:@""];
//    [self setLandmark:@""];
}


#pragma mark - Other Preference Values
- (void)setLastLogin:(long)lastLogin
{
    _lastLogin = lastLogin;
    [self saveDefaultsLong:kDefaultsLastLoggedInKey value:lastLogin];
}
-(void)setIntroviewed:(long)introviewed
{
    _introviewed = introviewed;
    [self saveDefaultsLong:@"introviewed" value:introviewed];
}

//custom token
-(void)setUser_id:(NSString *)user_id{
    _user_id = user_id;
    [self saveDefaults:@"user_id" value:user_id];
}
-(void)setUser_type:(NSString *)user_type{
    _user_type = user_type;
    [self saveDefaults:@"user_type" value:user_type];
}
-(void)setAddress1:(NSString *)address1{
    _address1 = address1;
    [self saveDefaults:@"user_type" value:address1];
}
-(void)setAddress_id:(NSString *)address_id{
    _address_id = address_id;
    [self saveDefaults:@"user_type" value:address_id];
}
-(void)setAddress2:(NSString *)address2{
    _address2 = address2;
    [self saveDefaults:@"address2" value:address2];
}
-(void)setCity:(NSString *)city{
    _city = city;
    [self saveDefaults:@"city" value:city];
}
-(void)setState:(NSString *)state{
    _state = state;
    [self saveDefaults:@"state" value:state];
}
-(void)setPincode:(NSString *)pincode{
    _pincode = pincode;
    [self saveDefaults:@"pincode" value:pincode];
}
-(void)setLandmark:(NSString *)landmark{
    _landmark = landmark;
    [self saveDefaults:@"landmark" value:landmark];
}
-(void)setPhone:(NSString *)phone{
    _phone = phone;
    [self saveDefaults:@"phone" value:phone];
}
-(void)setQuote:(BOOL)quote{
    _quote = quote;
    UDSetBool(@"quote", quote);
    
}
-(void)setMode:(long )mode{
    _mode = mode;
    [self saveDefaultsLong:@"mode" value:mode];
}
-(void)setOrder_id:(NSString *)order_id{
    _order_id = order_id;
    [self saveDefaults:@"order_id" value:order_id];
}
-(void)setQuestion:(NSString *)question{
    _question = question;
    [self saveDefaults:@"question" value:question];
}
-(void)setAnswer:(NSString *)answer{
    _answer = answer;
    [self saveDefaults:@"answer" value:answer];
}
-(void)setTerm:(NSString *)term{
    _term = term;
    [self saveDefaults:@"term" value:term];
}
-(void)setPolicy:(NSString *)policy{
    _policy = policy;
    [self saveDefaults:@"policy" value:policy];
}
-(void)setFeedback_id:(NSString *)feedback_id{
    _feedback_id = feedback_id;
    [self saveDefaults:@"feedback_id" value:feedback_id];
}
-(void)setCorporate_user_id:(NSString *)corporate_user_id{
    _corporate_user_id = corporate_user_id;
    [self saveDefaults:@"corporate_user_id" value:corporate_user_id];
}
-(void)setCor_email:(NSString *)cor_email{
    _cor_email = cor_email;
    [self saveDefaults:@"cor_email" value:cor_email];
}
-(void)setCor_password:(NSString *)cor_password{
    _cor_password = cor_password;
    [self saveDefaults:@"cor_password" value:cor_password];
}
-(void)setCor_order_id:(NSString *)cor_order_id{
    _cor_order_id = cor_order_id;
    [self saveDefaults:@"cor_order_id" value:cor_order_id];
}
-(void)setQuote_id:(NSString *)quote_id{
    _quote_id = quote_id;
    [self saveDefaults:@"quote_id" value:quote_id];
}
-(void)setNickname:(NSString *)nickname{
    _nickname = nickname;
    [self saveDefaults:@"nickname" value:nickname];
}
-(void)setFirst_name:(NSString *)first_name{
    _first_name = first_name;
    [self saveDefaults:@"first_name" value:first_name];
}
-(void)setLast_name:(NSString *)last_name{
    _last_name = last_name;
    [self saveDefaults:@"last_name" value:last_name];
}
-(void)setBusuness_Type:(NSString *)business_type{
    _business_type = business_type;
    [self saveDefaults:@"business_type" value:business_type];
}

@end






