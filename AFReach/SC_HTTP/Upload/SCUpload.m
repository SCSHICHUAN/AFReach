//
//  SCUpload.m
//  AFReach
//
//  Created by stan on 2020/8/28.
//  Copyright © 2020 pd. All rights reserved.
//

#import "SCUpload.h"
@interface SCUpload()
{
    SCProgress _progress;
    WellDone _wellDone;
    Error _error;
}
@end
@implementation SCUpload
+(void)UploadPath:(NSString* _Nullable)path
    filePath:(NSString * _Nullable)filePath
withProgress:(SCProgress _Nullable)progress
 andWellDone:(WellDone _Nullable)wellDone
    andError:(Error _Nullable)error
{
    [[[SCUpload alloc] init] uploadPath:path filePath:filePath withProgress:progress andWellDone:wellDone andError:error];
}
-(void)uploadPath:(NSString* _Nullable)path
    filePath:(NSString * _Nullable)filePath
withProgress:(SCProgress _Nullable)progress
 andWellDone:(WellDone _Nullable)wellDone
    andError:(Error _Nullable)error
{
    [self up_go:path file:filePath];
    _progress = progress;
    _wellDone = wellDone;
    _error    = error;
}


-(void)up_go:(NSString*)path file:(NSString*)filePath
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    
    NSString *fileName = [SCUpload GetFileName:filePath];
    [req setValue:fileName forHTTPHeaderField:@"filename"];
   
    
    
    
    NSURL *fileUrl = [NSURL URLWithString:filePath];
    //用文件创建UploadTask
    NSURLSessionUploadTask *dTask = [session uploadTaskWithRequest:req fromFile:fileUrl];
    [dTask setTaskDescription:@"上传文件一"];
    [dTask resume];
}
//获取文件名字
+(NSString*)GetFileName:(NSString*)pFile
{
    NSRange range = [pFile rangeOfString:@"/"options:NSBackwardsSearch];
    return [pFile substringFromIndex:range.location + 1];
}


#pragma mark-NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
         didSendBodyData:(int64_t)bytesSent
          totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    //NSLog(@"速度:%lld, 已经下载:%lld, 总的数据:%lld",bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
        SC_Progress pr;
        pr.item_buffer_size = bytesSent;
        pr.current_buffer_size = totalBytesSent;
        pr.total_buffer_size = totalBytesExpectedToSend;
        
        if (_progress) {
            _progress(pr);
        }
         
    }
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
    didCompleteWithError:(nullable NSError *)error;
{
        if (error) {
            if (_error) {
                _error(error);
            }
        }
        
}

#pragma mark-NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveData:(NSData *)data
{
    NSString * str  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (_wellDone) {
        _wellDone(nil,str);
    }
}

@end
