//
//  AF_JSON.m
//  AFReach
//
//  Created by 石川 on 2020/9/6.
//  Copyright © 2020 pd. All rights reserved.
//

#import "AF_JSON.h"
#import "AFNetworking.h"

@implementation AF_JSON
+(void)POSTwithHost:(NSString* _Nullable)path
             method:(NSString* _Nullable)methot
         parameters:(NSDictionary* _Nullable)prs
           wellDone:(WellDone _Nullable)wellDone
              error:(Error _Nullable)error
{
    [[[AF_JSON alloc] init]postWithHost:path method:methot parameters:prs wellDone:wellDone error:error];
}
-(void)postWithHost:(NSString* _Nullable)path
             method:(NSString* _Nullable)methot
         parameters:(NSDictionary* _Nullable)prs
           wellDone:(WellDone _Nullable)wellDone
              error:(Error _Nullable)error
{
    NSString *URLString = [path stringByAppendingString:methot];
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:prs error:nil];
    //设置请求多字符编码UTF-8 不设置服务器会乱码
    [request setValue:@"text/html;application/json;charset=UTF-8" forHTTPHeaderField:@"contentType"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error_l) {
        if (error_l) {
            
            if (error) {
                error(error_l);
            }
            
        } else {
            
            if (wellDone) {
                wellDone(response,responseObject);
            }
            
        }
    }];
    
    
    [dataTask resume];
}

/*
 application/x-www-form-urlencoded
 */
+(void)POSTwithHost_app_urlencodedWhthHost:(NSString* _Nullable)path
                                    method:(NSString* _Nullable)methot
                                parameters:(NSDictionary* _Nullable)prs
                                  wellDone:(WellDone _Nullable)wellDone
                                     error:(Error _Nullable)error
{
    [[[AF_JSON alloc] init] postWithHost_app_urlencodedWhthHost:path method:methot parameters:prs wellDone:wellDone error:error];
}
-(void)postWithHost_app_urlencodedWhthHost:(NSString* _Nullable)path
                                    method:(NSString* _Nullable)methot
                                parameters:(NSDictionary* _Nullable)prs
                                  wellDone:(WellDone _Nullable)wellDone
                                     error:(Error _Nullable)error
{
    NSString *URLString = [path stringByAppendingString:methot];
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:prs error:nil];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"contentType"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error_l) {
        if (error_l) {
            
            if (error) {
                error(error_l);
            }
            
        } else {
            
            if (wellDone) {
                wellDone(response,responseObject);
            }
            
        }
    }];
    
    
    [dataTask resume];
}


/*
 application/json
 */
+(void)POSTwithHost_app_jsonWhthHost:(NSString* _Nullable)path
                              method:(NSString* _Nullable)methot
                          parameters:(NSDictionary* _Nullable)prs
                            wellDone:(WellDone _Nullable)wellDone
                               error:(Error _Nullable)error
{
    [[[AF_JSON alloc] init] postWithHost_app_jsonWhthHost:path method:methot parameters:prs wellDone:wellDone error:error];
}
-(void)postWithHost_app_jsonWhthHost:(NSString* _Nullable)path
                              method:(NSString* _Nullable)methot
                          parameters:(NSDictionary* _Nullable)prs
                            wellDone:(WellDone _Nullable)wellDone
                               error:(Error _Nullable)error
{
    NSString *URLString = [path stringByAppendingString:methot];
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:prs error:nil];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"contentType"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error_l) {
        if (error_l) {
            
            if (error) {
                error(error_l);
            }
            
        } else {
            
            if (wellDone) {
                wellDone(response,responseObject);
            }
            
        }
    }];
    
    
    [dataTask resume];
}





@end
