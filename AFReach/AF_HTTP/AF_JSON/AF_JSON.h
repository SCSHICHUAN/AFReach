//
//  AF_JSON.h
//  AFReach
//
//  Created by 石川 on 2020/9/6.
//  Copyright © 2020 pd. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "SCHTTP_block.h"
NS_ASSUME_NONNULL_BEGIN

@interface AF_JSON : NSObject
+(void)POSTwithHost:(NSString* _Nullable)path
             method:(NSString* _Nullable)methot
         parameters:(NSDictionary* _Nullable)prs
           wellDone:(WellDone _Nullable)wellDone
              error:(Error _Nullable)error;
-(void)postWithHost:(NSString* _Nullable)path
    method:(NSString* _Nullable)methot
parameters:(NSDictionary* _Nullable)prs
  wellDone:(WellDone _Nullable)wellDone
     error:(Error _Nullable)error;

/*
 application/x-www-form-urlencoded    在发送前编码所有字符（默认）
 */
+(void)POSTwithHost_app_urlencodedWhthHost:(NSString* _Nullable)path
             method:(NSString* _Nullable)methot
         parameters:(NSDictionary* _Nullable)prs
           wellDone:(WellDone _Nullable)wellDone
              error:(Error _Nullable)error;
-(void)postWithHost_app_urlencodedWhthHost:(NSString* _Nullable)path
    method:(NSString* _Nullable)methot
parameters:(NSDictionary* _Nullable)prs
  wellDone:(WellDone _Nullable)wellDone
     error:(Error _Nullable)error;


/*
 application/json 作为请求头告诉服务端消息主体是序列化的JSON字符串。除低版本的IE，基本都支持。
 */
+(void)POSTwithHost_app_jsonWhthHost:(NSString* _Nullable)path
             method:(NSString* _Nullable)methot
         parameters:(NSDictionary* _Nullable)prs
           wellDone:(WellDone _Nullable)wellDone
              error:(Error _Nullable)error;
-(void)postWithHost_app_jsonWhthHost:(NSString* _Nullable)path
    method:(NSString* _Nullable)methot
parameters:(NSDictionary* _Nullable)prs
  wellDone:(WellDone _Nullable)wellDone
     error:(Error _Nullable)error;

@end

NS_ASSUME_NONNULL_END
