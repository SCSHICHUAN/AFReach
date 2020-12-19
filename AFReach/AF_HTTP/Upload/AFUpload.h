//
//  AFUpload.h
//  AFReach
//
//  Created by stan on 2020/8/27.
//  Copyright © 2020 pd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCProgress.h"
#import "SCHTTP_block.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFUpload : NSObject

/*
 上传单个文件
 */
+(void)UploadPath:(NSString* _Nullable)path
    filePath:(NSString * _Nullable)filePath
withProgress:(SCProgress _Nullable)progress
 andWellDone:(WellDone _Nullable)wellDone
    andError:(Error _Nullable)error;
-(void)uploadPath:(NSString* _Nullable)path
         filePath:(NSString * _Nullable)filePath
     withProgress:(SCProgress _Nullable)progress
      andWellDone:(WellDone _Nullable)wellDone
         andError:(Error _Nullable)error;






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
