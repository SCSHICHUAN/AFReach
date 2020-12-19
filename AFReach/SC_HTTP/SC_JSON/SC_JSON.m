//
//  SC_JSON.m
//  AFReach
//
//  Created by 石川 on 2020/9/6.
//  Copyright © 2020 pd. All rights reserved.
//

#import "SC_JSON.h"

@implementation SC_JSON
+(void)POSTwithHost:(NSString* _Nullable)path
             method:(NSString* _Nullable)methot
         parameters:(NSDictionary* _Nullable)prs
           wellDone:(WellDone _Nullable)wellDone
              error:(Error _Nullable)error
{
    [[[SC_JSON alloc] init] postWithHost:path method:methot parameters:prs wellDone:wellDone error:error];
}
-(void)postWithHost:(NSString* _Nullable)path
             method:(NSString* _Nullable)methot
         parameters:(NSDictionary* _Nullable)prs
           wellDone:(WellDone _Nullable)wellDone
              error:(Error _Nullable)error
{
    NSMutableURLRequest *request_post = [NSMutableURLRequest
                                         requestWithURL: [NSURL URLWithString:[path stringByAppendingString:methot]]];
    request_post.HTTPMethod = @"POST";
    request_post.HTTPBody = [self formatHttpBodyJson:prs];
    NSURLSession *session_post = [NSURLSession sharedSession];
    NSURLSessionDataTask *task_post = [session_post dataTaskWithRequest:request_post completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error_l) {
        
        if (error_l) {
            if (error) {
                error(error_l);
            }
        }else{
            
            
            NSDictionary *jsonDict;
            
            @try {
                NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSData * datas = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
                jsonDict = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableLeaves error:nil];
                if (!jsonDict) {
                    jsonDict = (NSDictionary *)[NSString stringWithFormat:@"%s",[data bytes]];
                }
            } @catch (NSException *exception) {
                jsonDict = @{@"format":@"JSON ERROR"};
            } @finally {
                wellDone(response,jsonDict);
            }
        }
    }];
    
    [task_post resume];
}





/*
 @"name=jack&password=123"
 */
-(NSData*)formatHttpBodyJson:(NSDictionary *)dict
{
    __block NSString *format = @"";
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key,NSString *value, BOOL * _Nonnull stop) {
        format = [format stringByAppendingString:[key stringByAppendingFormat:@"=%@&",value]];
    }];
    
    format = [format substringWithRange:NSMakeRange(0, [format length] - 1)];
    NSData *formatData = [format dataUsingEncoding:NSUTF8StringEncoding];
    
    return formatData;
}


@end
