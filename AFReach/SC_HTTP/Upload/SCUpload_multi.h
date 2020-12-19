//
//  SCUpload_multi.h
//  AFReach
//
//  Created by 石川 on 2020/9/6.
//  Copyright © 2020 pd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCProgress.h"
#import "SCHTTP_block.h"

NS_ASSUME_NONNULL_BEGIN

@interface SCUpload_multi : NSObject<NSURLSessionTaskDelegate,NSURLSessionDataDelegate>

/*
上传多个个文件
*/
-(void)upload_multi_part_path:(NSString* _Nullable)path
         filePaths:(NSMutableArray * _Nullable)filePaths
     withProgress:(SCProgress _Nullable)progress
      andWellDone:(WellDone _Nullable)wellDone
         andError:(Error _Nullable)error;

+(void)Upload_multi_part_path:(NSString* _Nullable)path
         filePaths:(NSMutableArray * _Nullable)filePaths
     withProgress:(SCProgress _Nullable)progress
      andWellDone:(WellDone _Nullable)wellDone
         andError:(Error _Nullable)error;



@end

NS_ASSUME_NONNULL_END
