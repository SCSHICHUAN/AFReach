//
//  SCUpload.h
//  AFReach
//
//  Created by stan on 2020/8/28.
//  Copyright © 2020 pd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCProgress.h"
#import "SCHTTP_block.h"

NS_ASSUME_NONNULL_BEGIN

@interface SCUpload : NSObject<NSURLSessionTaskDelegate,NSURLSessionDataDelegate>

-(void)uploadPath:(NSString* _Nullable)path
         filePath:(NSString * _Nullable)filePath
     withProgress:(SCProgress _Nullable)progress
      andWellDone:(WellDone _Nullable)wellDone
         andError:(Error _Nullable)error;

+(void)UploadPath:(NSString* _Nullable)path
         filePath:(NSString * _Nullable)filePath
     withProgress:(SCProgress _Nullable)progress
      andWellDone:(WellDone _Nullable)wellDone
         andError:(Error _Nullable)error;


@end

NS_ASSUME_NONNULL_END
