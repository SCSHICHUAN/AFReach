//
//  AFDownload.m
//  AFReach
//
//  Created by stan on 2020/8/26.
//  Copyright © 2020 pd. All rights reserved.
//

#import "AFDownload.h"
#import "AFNetworking.h"


@implementation AFDownload


+(void)DownloadPath:(NSString* _Nullable)path
       withProgress:(SCProgress _Nullable)progress
        andWellDone:(WellDone _Nullable)wellDone
           andError:(Error _Nullable)error
{
    [[[AFDownload alloc] init] downloadPath:path withProgress:progress andWellDone:wellDone andError:error];
}


-(void)downloadPath:(NSString* _Nullable)path
       withProgress:(SCProgress _Nullable)progress
        andWellDone:(WellDone _Nullable)wellDone
           andError:(Error _Nullable)error
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURL *URL = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    //用AF封装的方法生成DownloadTask
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        SC_Progress pr;
        pr.item_buffer_size = 0;
        pr.current_buffer_size = downloadProgress.completedUnitCount;
        pr.total_buffer_size = downloadProgress.totalUnitCount;
        
        if (progress) {
            progress(pr);
        }
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *e_rror) {
        if (e_rror) {
            if (error) {
                error(e_rror);
            }
        }else if (wellDone) {
            wellDone(response,[NSString stringWithFormat:@"%@",filePath]);
          }
               
    }];
    
    
    [downloadTask resume];
}




@end
