//
//  NetworkParser.m
//  SchoolApp
//
//  Created by TwinkleStar on 11/27/15.
//  Copyright © 2015 apple. All rights reserved.
//

#import "NetworkParser.h"
#import "AFNetworking.h"
#import "CGlobal.h"
#import "BaseModel.h"

@implementation NetworkParser

+ (instancetype)sharedManager
{
    static NetworkParser *sharedPhotoManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPhotoManager = [[NetworkParser alloc] init];
        
    });
    
    return sharedPhotoManager;
}
-(BOOL)checkResponse:(NSDictionary*)dict{
    @try {
        if ([dict objectForKey:@"response"] == nil) {
            return true;
        }else{
            NSNumber* code = [dict valueForKey:@"response"];
            if ([code intValue] == 200) {
                return true;
            }else{
                
                NSString*error = (NSString*)[dict objectForKey:@"res"];
                if (error != nil) {
                    //[CGlobal AlertMessage:error Title:nil];
                }
                
            }
            return false;
        }
        
    }
    @catch (NSException *exception) {
        return false;
    }
    @finally {
        
    }
    
}
-(void)generalNetworkWithNoCheck:(NSString*)serverurl Data:(NSDictionary*)questionDict withCompletionBlock:(NetworkCompletionBlock)completionBlock method:(NSString*)method{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if ([[serverurl lowercaseString] hasPrefix:@"https://"]) {
        manager.securityPolicy.allowInvalidCertificates = YES; // not recommended for production
        [manager.securityPolicy setValidatesDomainName:NO];
    }
    
     if ([[method lowercaseString] isEqualToString:@"get"]) {
         [manager GET:serverurl parameters:questionDict progress:nil success:^(NSURLSessionTask *task, id responseObject) {
             //        NSLog(@"JSON: %@", responseObject);
             if(completionBlock){
                 if (completionBlock) {
                     completionBlock(responseObject,nil);
                 }
             }
             
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             if(completionBlock) {
                 completionBlock(nil,error);
             }
             
         }];
     }else{
         [manager POST:serverurl parameters:questionDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             if(completionBlock){
                 //                NSData *jsonData = [myJsonString dataUsingEncoding:NSUTF8StringEncoding];
                 NSString* str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                 //str = @"{\"result\":400}";
                 //NSLog(str);
                 NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                 id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 if(completionBlock){
                     if (dict!=nil ) {
                         completionBlock(dict,nil);
                     }else{
                         completionBlock(dict,[[NSError alloc] init]);
                     }
                 }
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if(completionBlock) {
                 completionBlock(nil,error);
             }
         }];
     }
}
-(void)generalNetwork2:(NSString*)serverurl Data:(NSDictionary*)questionDict withCompletionBlock:(NetworkCompletionBlock)completionBlock method:(NSString*)method{
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if ([[serverurl lowercaseString] hasPrefix:@"https://"]) {
        manager.securityPolicy.allowInvalidCertificates = YES; // not recommended for production
        [manager.securityPolicy setValidatesDomainName:NO];
    }
    
    
    
    //    serverurl = [serverurl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    [manager.requestSerializer setValue:@"text/html" forHTTPHeaderField:@"Accept"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if ([[method lowercaseString] isEqualToString:@"get"]) {
        [manager GET:serverurl parameters:questionDict progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            //        NSLog(@"JSON: %@", responseObject);
            if(completionBlock){
                if ([self checkResponse:responseObject] && completionBlock) {
                    completionBlock(responseObject,nil);
                }else{
                    completionBlock(responseObject,[[NSError alloc] init]);
                }
                
            }
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            //        NSLog(@"Error: %@", error);
            if(completionBlock) {
                completionBlock(nil,error);
            }
            
        }];
    }else{
        
        
        [manager POST:serverurl parameters:questionDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(completionBlock){
//                NSData *jsonData = [myJsonString dataUsingEncoding:NSUTF8StringEncoding];
                NSString* str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                //str = @"{\"result\":400}";
                //NSLog(str);
                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (dict!=nil && [self checkResponse:dict] && completionBlock) {
                    completionBlock(dict,nil);
                }else{
                    completionBlock(dict,[[NSError alloc] init]);
                }
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(completionBlock) {
                completionBlock(nil,error);
            }
        }];
    }
}
-(void)generalNetwork:(NSString*)serverurl Data:(NSDictionary*)questionDict withCompletionBlock:(NetworkCompletionBlock)completionBlock method:(NSString*)method{
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if ([[serverurl lowercaseString] hasPrefix:@"https://"]) {
        manager.securityPolicy.allowInvalidCertificates = YES; // not recommended for production
        [manager.securityPolicy setValidatesDomainName:NO];
    }
    
    
    
    //    serverurl = [serverurl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    if ([[method lowercaseString] isEqualToString:@"get"]) {
        [manager GET:serverurl parameters:questionDict progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            //        NSLog(@"JSON: %@", responseObject);
            if(completionBlock){
                if ([self checkResponse:responseObject] && completionBlock) {
                    completionBlock(responseObject,nil);
                }else{
                    completionBlock(responseObject,[[NSError alloc] init]);
                }
                
            }
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            //        NSLog(@"Error: %@", error);
            if(completionBlock) {
                completionBlock(nil,error);
            }
            
        }];
    }else{
        
        [manager POST:serverurl parameters:questionDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(completionBlock){
                if ([self checkResponse:responseObject] && completionBlock) {
                    completionBlock(responseObject,nil);
                }else{
                    completionBlock(responseObject,[[NSError alloc] init]);
                }
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(completionBlock) {
                completionBlock(nil,error);
            }
        }];
    }
    
    
}
- (void)uploadImage2:(NSMutableDictionary*)params Data:(NSMutableArray*)data_list Path:(NSString*)serverurl withCompletionBlock:(NetworkCompletionBlock)completionBlock{
    
        
    NSDictionary *parameters = params;
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:serverurl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int k=0; k<data_list.count; k++) {
            NSString* name = [NSString stringWithFormat:@"file%d",k];
            NSString* filename = [NSString stringWithFormat:@"image%d.jpg",k];
            
            NSData*imageData = data_list[k];
            [formData appendPartWithFileData:imageData name:name fileName:name mimeType:@"multipart/form-data;boundary=*****"];
        }
        
        
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    if ([[serverurl lowercaseString] hasPrefix:@"https://"]) {
        manager.securityPolicy.allowInvalidCertificates = YES; // not recommended for production
        [manager.securityPolicy setValidatesDomainName:NO];
    }
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:nil
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      NSString* str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                      //str = @"{\"result\":400}";
                      //NSLog(str);
                      NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                      id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                      if (error == nil) {
                          NSLog(@"Error: %@", error);
                          if(completionBlock){
                              if ([self checkResponse:dict]) {
                                  
                                  completionBlock(dict,nil);
                              }else{
                                  completionBlock(nil,[[NSError alloc] init]);
                              }
                              
                          }
                      } else {
                          NSLog(@"%@ %@", response, dict);
                          if(completionBlock) {
                              completionBlock(nil,error);
                          }
                      }
                  }];
    
    [uploadTask resume];
    
}
- (void)uploadImage:(UIImage*)image FileName:(NSString*)fileName withCompletionBlock:(NetworkCompletionBlock)completionBlock{
    
    NSString *serverurl = g_baseUrl ;
    serverurl = [serverurl stringByAppendingString:ACTION_UPLOAD];
    
    NSDictionary *parameters = @{@"foo": @"bar"};
    
    NSData *imageData = UIImageJPEGRepresentation(image,0.7);
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:serverurl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"uploaded_file" fileName:fileName mimeType:@"multipart/form-data;boundary=*****"];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    if ([[serverurl lowercaseString] hasPrefix:@"https://"]) {
        manager.securityPolicy.allowInvalidCertificates = YES; // not recommended for production
        [manager.securityPolicy setValidatesDomainName:NO];
    }
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:nil
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                          if(completionBlock){
                              if ([self checkResponse:responseObject]) {
                                  
                                  completionBlock(responseObject,nil);
                              }else{
                                  completionBlock(nil,[[NSError alloc] init]);
                              }
                              
                          }
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                          if(completionBlock) {
                              completionBlock(nil,error);
                          }
                      }
                  }];
    
    [uploadTask resume];
    
    //    NSString *serverurl = g_baseUrl ;
    //    serverurl = [serverurl stringByAppendingString:ACTION_UPLOAD];
    //
    //    NSDictionary *parameters = @{@"foo": @"bar"};
    //
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //
    //    NSData *imageData = UIImageJPEGRepresentation(image,0.7);
    //    [manager POST:serverurl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //        [formData appendPartWithFileData:imageData name:@"uploaded_file" fileName:fileName mimeType:@"multipart/form-data;boundary=*****"];
    //    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSLog(@"Success: %@", responseObject);
    //        if(completionBlock){
    //            if ([self checkResponse:responseObject]) {
    //
    //                completionBlock(responseObject,nil);
    //            }else{
    //                completionBlock(nil,[[NSError alloc] init]);
    //            }
    //
    //        }
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"Error: %@", error);
    //        if(completionBlock) {
    //            completionBlock(nil,error);
    //        }
    //    }];
    
    
}


-(void)ontemplateGeneralRequest2:(id) data BasePath:(NSString*)url Path:(NSString*)path withCompletionBlock:(NetworkCompletionBlock)completionBlock method:(NSString*)method{
    NSString *serverurl = [NSString stringWithFormat:@"%@%@%@",g_baseUrl,url,path];
    
    NSMutableDictionary *questionDict=nil;
    if (data!=nil) {
        questionDict=[BaseModel getQuestionDict:data];
    }
    
    
    [self generalNetwork2:serverurl Data:questionDict withCompletionBlock:completionBlock method:method];
}
-(void)ontemplateRequestWithNoCheck2:(id) data BasePath:(NSString*)url Path:(NSString*)path  withCompletionBlock:(NetworkCompletionBlock)completionBlock method:(NSString*)method{
    NSString *serverurl = g_baseUrl ;
    serverurl = [serverurl stringByAppendingString:url];
    
    NSMutableDictionary *questionDict=nil;
    if (data!=nil) {
        questionDict=[BaseModel getQuestionDict:data];
    }
    
    [self generalNetworkWithNoCheck:serverurl Data:questionDict withCompletionBlock:completionBlock method:method];
}

-(void)ontemplateGeneralRequest:(id) data Path:(NSString*)url withCompletionBlock:(NetworkCompletionBlock)completionBlock method:(NSString*)method{
    NSString *serverurl = g_baseUrl ;
    serverurl = [serverurl stringByAppendingString:url];
    
    NSMutableDictionary *questionDict=nil;
    if (data!=nil) {
        questionDict=[BaseModel getQuestionDict:data];
    }
    
    
    [self generalNetwork:serverurl Data:questionDict withCompletionBlock:completionBlock method:method];
}
-(void)ontemplateRequestWithNoCheck:(id) data Path:(NSString*)url withCompletionBlock:(NetworkCompletionBlock)completionBlock method:(NSString*)method{
    NSString *serverurl = g_baseUrl ;
    serverurl = [serverurl stringByAppendingString:url];
    
    NSMutableDictionary *questionDict=nil;
    if (data!=nil) {
        questionDict=[BaseModel getQuestionDict:data];
    }
    
    [self generalNetworkWithNoCheck:serverurl Data:questionDict withCompletionBlock:completionBlock method:method];
}

-(void)ontemplateGeneralRequestWithRawUrl:(id) data Path:(NSString*)url withCompletionBlock:(NetworkCompletionBlock)completionBlock method:(NSString*)method{
    NSString *serverurl = url ;
    
    NSMutableDictionary *questionDict=nil;
    if (data!=nil) {
        questionDict=[BaseModel getQuestionDict:data];
    }
    
    
    [self generalNetwork:serverurl Data:questionDict withCompletionBlock:completionBlock method:method];
}
-(void)ontemplateGeneralRequestWithRawUrlNoCheck:(id) data Path:(NSString*)url withCompletionBlock:(NetworkCompletionBlock)completionBlock method:(NSString*)method{
    NSString *serverurl = url ;
    
    NSMutableDictionary *questionDict=nil;
    if (data!=nil) {
        questionDict=[BaseModel getQuestionDict:data];
    }
    
    
    [self generalNetworkWithNoCheck:serverurl Data:questionDict withCompletionBlock:completionBlock method:method];
}



-(void)cancelPayment:(NSString*)serverurl Data:(NSDictionary*)questionDict withCompletionBlock:(NetworkCompletionBlock)completionBlock method:(NSString*)method{
    
    NSDictionary *headers = @{ @"Authorization": @"/ZanKOwsXGLTryavOYQlL8zKZw3JAnukwokz4H0o07o=",
                               @"Content-Type": @"application/json",
                               @"cache-control": @"no-cache",
                               @"Postman-Token": @"1d5e6a67-fd2b-4d72-b200-6d33e37938f9" };
    
    NSString *amount = questionDict[@"refundAmount"];//[questionDict valueForKey:@"refundAmount"];
    NSString *paymentId = questionDict[@"paymentId"];//[questionDict valueForKey:@"paymentId"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.payumoney.com/treasury/merchant/refundPayment?refundAmount=%@&merchantKey=iBzb2IZp&paymentId=%@", amount, paymentId]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                NSLog(@"%@", httpResponse);
                
                NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                            //str = @"{\"result\":400}";
                    //NSLog(str);
                NSData *mydata = [str dataUsingEncoding:NSUTF8StringEncoding];
        
                
                id dict = [NSJSONSerialization JSONObjectWithData:mydata options:0 error:nil];
                if (dict!=nil && [self checkResponse:dict] && completionBlock) {
                    completionBlock(dict,nil);
                }else{
                    completionBlock(dict,[[NSError alloc] init]);
                }
                
            }
        }];
    [dataTask resume];
    

//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    if ([[serverurl lowercaseString] hasPrefix:@"https://"]) {
//        manager.securityPolicy.allowInvalidCertificates = YES; // not recommended for production
//        [manager.securityPolicy setValidatesDomainName:NO];
//    }
//
//    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    [manager.requestSerializer setValue:@"/ZanKOwsXGLTryavOYQlL8zKZw3JAnukwokz4H0o07o=" forHTTPHeaderField:@"authorization"];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//
//    [manager POST:serverurl parameters:questionDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if(completionBlock){
//            //                NSData *jsonData = [myJsonString dataUsingEncoding:NSUTF8StringEncoding];
//            NSString* str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//            //str = @"{\"result\":400}";
//            //NSLog(str);
//            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//            id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            if (dict!=nil && [self checkResponse:dict] && completionBlock) {
//                completionBlock(dict,nil);
//            }else{
//                completionBlock(dict,[[NSError alloc] init]);
//            }
//
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if(completionBlock) {
//            completionBlock(nil,error);
//        }
//    }];
    
}

@end










