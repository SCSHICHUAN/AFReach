//
//  SCUpload_multi.m
//  AFReach
//
//  Created by 石川 on 2020/9/6.
//  Copyright © 2020 pd. All rights reserved.
//

#import "SCUpload_multi.h"
#define HTTP_boundary @"wfWiEWrgEFA9A78512weF7106A"

@interface SCUpload_multi()
{
    SCProgress _progress;
    WellDone _wellDone;
    Error _error;
}
@end
@implementation SCUpload_multi


+(void)Upload_multi_part_path:(NSString* _Nullable)path
    filePaths:(NSMutableArray * _Nullable)filePaths
withProgress:(SCProgress _Nullable)progress
 andWellDone:(WellDone _Nullable)wellDone
    andError:(Error _Nullable)error
{
    [[[SCUpload_multi alloc] init] upload_multi_part_path:path filePaths:filePaths withProgress:progress andWellDone:wellDone andError:error];
}
-(void)upload_multi_part_path:(NSString* _Nullable)path
         filePaths:(NSMutableArray * _Nullable)filePaths
     withProgress:(SCProgress _Nullable)progress
      andWellDone:(WellDone _Nullable)wellDone
         andError:(Error _Nullable)error
{
    
     [self up_go:path files:filePaths];
     _progress = progress;
     _wellDone = wellDone;
     _error    = error;
}

-(void)up_go:(NSString*)path files:(NSMutableArray * _Nullable)filePaths
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    
    //HTTP 设置为多文件上传
    NSString *headerStr = [NSString stringWithFormat:@"multipart/form-data;boundary=%@",HTTP_boundary];
    [req setValue:headerStr forHTTPHeaderField:@"Content-Type"];
    
    //拼接发送的文件
    NSMutableData *formatData = [NSMutableData data];
    for (NSString *path in filePaths) {
        NSMutableData *data = [NSMutableData dataWithContentsOfFile:path];
        NSString *fileName = [SCUpload_multi GetFileName:path];
        NSMutableData *ruData =  [self fileFormatWithName:@"sc-file" fileName:fileName fileData:data];
        [formatData appendData:ruData];
    }
    
    [formatData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",HTTP_boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *lenght = [NSString stringWithFormat:@"%lu",(unsigned long)formatData.length];
    
    
    [req setValue:lenght forHTTPHeaderField:@"Content-Length"];

    
    //用fomat data创建UploadTask
    NSURLSessionUploadTask *dTask = [session uploadTaskWithRequest:req fromData:formatData];
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


/*
按照HTTP格式拼接要发送的文件
Concatenate the files to be sent in HTTP format
*/
-(NSMutableData*)fileFormatWithName:(NSString *)name fileName:(NSString*)fileName fileData:(NSData*)data
{
    
    NSMutableData *formatData = [NSMutableData data];
    NSString *formatStr = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=%@;filename=%@\r\n\r\n",HTTP_boundary,name,fileName] ;
    [formatData appendData:[formatStr dataUsingEncoding:NSUTF8StringEncoding]];
    [formatData appendData:data];
    [formatData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
    return formatData;
}
/*
按照HTTP格式拼接要发送的文字
Concatenate the text to be sent in HTTP format
*/
-(NSMutableData*)textFormatWithName:(NSString *)name fileName:(NSString*)fileName text:(NSString*)text
{
    
    NSMutableData *formatData = [NSMutableData data];
    NSString *formatStr = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=%@\r\n\r\n",HTTP_boundary,name];
    [formatStr stringByAppendingString:text];
    [formatStr stringByAppendingString:@"\r\n"];
    [formatStr dataUsingEncoding:NSUTF8StringEncoding];
        
    return formatData;
}


@end
