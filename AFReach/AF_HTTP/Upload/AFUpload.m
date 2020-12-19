//
//  AFUpload.m
//  AFReach
//
//  Created by stan on 2020/8/27.
//  Copyright © 2020 pd. All rights reserved.
//

#import "AFUpload.h"
#import "AFNetworking.h"


@implementation AFUpload
/*
上传单个文件
*/
+(void)UploadPath:(NSString* _Nullable)path
         filePath:(NSString * _Nullable)filePath
     withProgress:(SCProgress _Nullable)progress
      andWellDone:(WellDone _Nullable)wellDone
         andError:(Error _Nullable)error
{
    [[[AFUpload alloc] init] uploadPath:path filePath:filePath withProgress:progress andWellDone:wellDone andError:error];
}

-(void)uploadPath:(NSString* _Nullable)path
         filePath:(NSString * _Nullable)filePath
     withProgress:(SCProgress _Nullable)progress
      andWellDone:(WellDone _Nullable)wellDone
         andError:(Error _Nullable)error
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSURL *URL = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    
    NSURL *urlFilePath = [NSURL URLWithString:filePath];
    
    
    
    //用AF封装的方法生成UploadTask
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:urlFilePath progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            SC_Progress pr;
            pr.item_buffer_size = 0;
            pr.current_buffer_size = uploadProgress.completedUnitCount;
            pr.total_buffer_size = uploadProgress.totalUnitCount;
            progress(pr);
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error_loc) {
        
        if (error_loc) {
            
            if (error) {
                error(error_loc);
            }
            
        } else {
            
            if (wellDone) {
                wellDone(response,responseObject);
            }
            
        }
    }];
    
    [uploadTask resume];
    
    
}




/*
上传多个个文件
*/
+(void)Upload_multi_part_path:(NSString* _Nullable)path
                    filePaths:(NSMutableArray * _Nullable)filePaths
                 withProgress:(SCProgress _Nullable)progress
                  andWellDone:(WellDone _Nullable)wellDone
                     andError:(Error _Nullable)error
{
    [[[AFUpload alloc] init] upload_multi_part_path:path filePaths:filePaths withProgress:progress andWellDone:wellDone andError:error];
}

/*
 
 遇到的坑 在AF库中
 #import "AFURLResponseSerialization.m"
 添加 text/plain
 AF 默认服务器返回JSON
 
 self.acceptableContentTypes = [NSSet setWithObjects:
 @"application/json",
 @"text/html",
 @"text/json",
 @"text/javascript",
 @"text/plain", nil];
 */
-(void)upload_multi_part_path:(NSString* _Nullable)path
                    filePaths:(NSMutableArray * _Nullable)filePaths
                 withProgress:(SCProgress _Nullable)progress
                  andWellDone:(WellDone _Nullable)wellDone
                     andError:(Error _Nullable)error
{
    
    //生成request对象
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //拼接上传文件data
        for (NSString *filePath in filePaths) {
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" fileName:[AFUpload  GetFileName:filePath] mimeType:@"image/jpeg/png" error:nil];
        }
    } error:nil];
    
    
    
    
    
    
    //配置AF manager
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    
    
    
    //用AF封装的方法生成UploadTask
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
        
       if (progress) {
            SC_Progress pr;
            pr.item_buffer_size = 0;
            pr.current_buffer_size = uploadProgress.completedUnitCount;
            pr.total_buffer_size = uploadProgress.totalUnitCount;
            progress(pr);
        }
        
        
    }completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable l_error) {
        
        //上传完成返回
        if (l_error) {

            if (error) {
                error(l_error);
            }
        } else {
            
            if (wellDone) {
                wellDone(response,responseObject);
            }
        }
    }];
    
    
    
    //开始上传
    [uploadTask resume];
}



//获取文件名字
+(NSString*)GetFileName:(NSString*)pFile
{
    NSRange range = [pFile rangeOfString:@"/"options:NSBackwardsSearch];
    return [pFile substringFromIndex:range.location + 1];
}



@end
