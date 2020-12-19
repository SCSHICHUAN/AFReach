//
//  SC_JSON.h
//  AFReach
//
//  Created by 石川 on 2020/9/6.
//  Copyright © 2020 pd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCHTTP_block.h"
NS_ASSUME_NONNULL_BEGIN

@interface SC_JSON : NSObject
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
@end

NS_ASSUME_NONNULL_END
