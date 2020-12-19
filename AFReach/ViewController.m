//
//  ViewController.m
//  AFReach
//
//  Created by stan on 2020/8/26.
//  Copyright © 2020 pd. All rights reserved.
//

#import "ViewController.h"
#import "AFDownload.h"
#import "SCDownload.h"
#import "AFUpload.h"
#import "SCUpload.h"
#import "SCUpload_multi.h"
#import "AFNetworking.h"
#import "AF_JSON.h"
#import "SC_JSON.h"
#import "AFNetworking.h"


#define screenW ([UIScreen mainScreen].bounds.size.width)
#define screenH ([UIScreen mainScreen].bounds.size.height)


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIViewController *logVc;
}
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *titlesArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    [self titlesArray];
}


#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titlesArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.titlesArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self LOG_VC];
    
    if (indexPath.row == 0) {
        [self AF_DownloadPath];
    }else if (indexPath.row == 1){
        [self SC_DownloadPath];
    }else if (indexPath.row == 2){
        [self AF_UploadPath];
    }else if (indexPath.row == 3){
        [self SC_UploadPath];
    }else if (indexPath.row == 4){
        [self AF_Upload_multi];
    }else if (indexPath.row == 5){
        [self SC_Upload_multi];
    }else if (indexPath.row == 6){
        [self  createDataTask];
    }else if (indexPath.row == 7){
        [self   AF_POST_JSON_norm];
    }else if (indexPath.row == 8){
        [self  AF_app_urlencoded];
    }else if (indexPath.row == 9){
        [self  AF_app_json];
    }else if (indexPath.row == 10){
        [self  sc_post_json];
    }else if (indexPath.row == 11){
        [self  af_post_http_session];
    }else if (indexPath.row == -1){
        [self  createDataTask];
    }else if (indexPath.row == -1){
        [self  createDataTask];
    }else if (indexPath.row == -1){
        [self  createDataTask];
    }
    
    
   
    
}







-(void)AF_DownloadPath
{
    [AFDownload DownloadPath:@"https://github.com/AFNetworking/AFNetworking/archive/master.zip" withProgress:^(SC_Progress progress) {
        
        NSString *textLog = [NSString stringWithFormat:
                             @"速度:%lld, 已经下载:%lld, 总的下载数据:%lld",
                             progress.item_buffer_size,
                             progress.current_buffer_size,
                             progress.total_buffer_size];
        [self showLogText:textLog];
        
    } andWellDone:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        [self showLogText:responseObject];
        
    } andError:^(NSError * _Nullable error) {
        if (error) {
            [self showLogText:[NSString stringWithFormat:@"%@",error]];
        }
    }];
}

-(void)SC_DownloadPath
{
    [SCDownload DownloadPath:@"https://github.com/AFNetworking/AFNetworking/archive/master.zip" withProgress:^(SC_Progress progress) {
        
        NSString *textLog = [NSString stringWithFormat:
                             @"速度:%lld, 已经下载:%lld, 总的下载数据:%lld",
                             progress.item_buffer_size,
                             progress.current_buffer_size,
                             progress.total_buffer_size];
        [self showLogText:textLog];
        
    } andWellDone:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        [self showLogText:responseObject];
        
    } andError:^(NSError * _Nullable error) {
        if (error) {
            [self showLogText:[NSString stringWithFormat:@"%@",error]];
        }
    }];
}

-(void)AF_UploadPath
{
   
  NSString *fpath =[[NSBundle mainBundle] pathForResource:@"pp.png" ofType:nil];
    
    [AFUpload UploadPath:[host stringByAppendingString:fileMethod] filePath:fpath withProgress:^(SC_Progress progress) {
        
        NSString *textLog = [NSString stringWithFormat:
                             @"速度:%lld, 已经上传:%lld, 总的上传数据:%lld",
                             progress.item_buffer_size,
                             progress.current_buffer_size,
                             progress.total_buffer_size];
        [self showLogText:textLog];
        
    } andWellDone:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        [self showLogText:responseObject];
        
    } andError:^(NSError * _Nullable error) {
        if (error) {
            [self showLogText:[NSString stringWithFormat:@"%@",error]];
        }
    }];
}



-(void)SC_UploadPath
{
    NSString *fpath =[[NSBundle mainBundle] pathForResource:@"pp.png" ofType:nil];
    
    [SCUpload UploadPath:[host stringByAppendingString:fileMethod] filePath:fpath withProgress:^(SC_Progress progress) {
        
        NSString *textLog = [NSString stringWithFormat:
                             @"速度:%lld, 已经上传:%lld, 总的上传数据:%lld",
                             progress.item_buffer_size,
                             progress.current_buffer_size,
                             progress.total_buffer_size];
        [self showLogText:textLog];
    
        
    } andWellDone:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        NSString *urlText = (NSString *)responseObject;
        
        
        [self showLogText:urlText];
        
        
    } andError:^(NSError * _Nullable error) {
        if (error) {
            [self showLogText:[NSString stringWithFormat:@"%@",error]];
        }
    }];
}





-(void)AF_Upload_multi
{
    
    NSString *fpath =[[NSBundle mainBundle] pathForResource:@"pp.png" ofType:nil];
    NSString *fpath1 =[[NSBundle mainBundle] pathForResource:@"gg.png" ofType:nil];
    NSString *fpath2 =[[NSBundle mainBundle] pathForResource:@"WechatIMG4.jpeg" ofType:nil];
    
    NSMutableArray *mPath = [NSMutableArray array];
    [mPath addObject:fpath];
    [mPath addObject:fpath1];
    [mPath addObject:fpath2];
    
    [AFUpload Upload_multi_part_path:[host stringByAppendingString:fileMethod] filePaths:mPath withProgress:^(SC_Progress progress) {
        
        
        NSString *textLog = [NSString stringWithFormat:@"速度:%lld, 已经上传:%lld, 总的上传数据:%lld", progress.item_buffer_size,
                             progress.current_buffer_size,
                             progress.total_buffer_size];
        
        [self showLogText:textLog];
        
    } andWellDone:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        
        
        [self showLogText:responseObject];
        
        
    } andError:^(NSError * _Nullable error) {
        if (error) {
            [self showLogText:[NSString stringWithFormat:@"%@",error]];
        }
    }];
}


-(void)SC_Upload_multi
{
      NSString *fpath =[[NSBundle mainBundle] pathForResource:@"pp.png" ofType:nil];
       NSString *fpath1 =[[NSBundle mainBundle] pathForResource:@"gg.png" ofType:nil];
       NSString *fpath2 =[[NSBundle mainBundle] pathForResource:@"WechatIMG4.jpeg" ofType:nil];
    
    
    NSMutableArray *mPath = [NSMutableArray array];
    [mPath addObject:fpath];
    [mPath addObject:fpath1];
    [mPath addObject:fpath2];
    
    
    [SCUpload_multi Upload_multi_part_path:[host stringByAppendingString:fileMethod] filePaths:mPath withProgress:^(SC_Progress progress) {
        
         NSString *textLog = [NSString stringWithFormat:@"速度:%lld, 已经上传:%lld, 总的上传数据:%lld", progress.item_buffer_size,
                                    progress.current_buffer_size,
                                    progress.total_buffer_size];
               
               [self showLogText:textLog];
        
    } andWellDone:^(NSURLResponse * _Nullable response, id  _Nullable responseObject) {
        
        [self showLogText:responseObject];
    } andError:^(NSError * _Nullable error) {
        if (error) {
            [self showLogText:[NSString stringWithFormat:@"%@",error]];
        }
    }];
}



-(void)createDataTask
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURL *URL = [NSURL URLWithString:[host stringByAppendingString:jsonMethod]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    
    
    [dataTask resume];
}

-(void)AF_POST_JSON_norm
{
    
    
     NSDictionary *parameters = @{@"name": @"石川",@"scbody":@{@"身高":@"170cm",@"爱好":@"打篮球",@"工作":@"码农"}};
    
    
    [AF_JSON POSTwithHost:host method:jsonMethod parameters:parameters wellDone:^(NSURLResponse * _Nullable response, id  _Nullable responseObject) {
        [self showLogText:responseObject];
    } error:^(NSError * _Nullable error) {
        if (error) {
             [self showLogText:[NSString stringWithFormat:@"%@",error]];
        }
    }];
}


-(void)AF_app_urlencoded
{
    NSDictionary *parameters = @{@"name": @"石川",@"scbody":@{@"身高":@"170cm",@"爱好":@"打篮球",@"工作":@"码农"}};
    
    [AF_JSON POSTwithHost_app_urlencodedWhthHost:host method:jsonMethod2 parameters:parameters wellDone:^(NSURLResponse * _Nullable response, id  _Nullable responseObject) {
         [self showLogText:responseObject];
    } error:^(NSError * _Nullable error) {
        if (error) {
             [self showLogText:[NSString stringWithFormat:@"%@",error]];
        }
    }];
    
}


-(void)AF_app_json
{
    NSDictionary *parameters = @{@"name": @"石川",@"scbody":@{@"身高":@"170cm",@"爱好":@"打篮球",@"工作":@"码农"}};
    
    [AF_JSON POSTwithHost_app_jsonWhthHost:host method:jsonMethod2 parameters:parameters wellDone:^(NSURLResponse * _Nullable response, id  _Nullable responseObject) {
        [self showLogText:responseObject];
    } error:^(NSError * _Nullable error) {
        [self showLogText:[NSString stringWithFormat:@"%@",error]];
    }];
    
    
}


-(void)sc_post_json
{
    NSDictionary *parameters = @{@"name": @"石川",@"身高":@"170cm",@"爱好":@"打篮球",@"工作":@"码农"};
    [SC_JSON POSTwithHost:host method:jsonMethod2 parameters:parameters wellDone:^(NSURLResponse * _Nullable response, id  _Nullable responseObject) {
        [self showLogText:responseObject];
    } error:^(NSError * _Nullable error) {
        [self showLogText:[NSString stringWithFormat:@"%@",error]];
    }];
    
}



-(void)af_post_http_session
{
    AFHTTPSessionManager *httpSessionManger = [AFHTTPSessionManager manager];
    httpSessionManger.requestSerializer = [AFJSONRequestSerializer serializer];
    httpSessionManger.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //设置请求头
    [httpSessionManger.requestSerializer setValue:@"application/json;UTF-8" forHTTPHeaderField:@"ContentType"];
    
    NSDictionary *parameters = @{@"name": @"stan",@"height":@"170cm",@"houb":@"play blaskboll",@"work":@"deveper"};

    
    [httpSessionManger POST:[host stringByAppendingString:fileMethod] parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self showLogText:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showLogText:[NSString stringWithFormat:@"%@",error]];
    }];
    
    
}











-(void)showLogText:(NSString*)text
{
    NSLog(@"返回:%@",text);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.textView.text = [self.textView.text stringByAppendingFormat:@" \n%@",text];
        CGFloat h = self.textView.contentSize.height -  [UIScreen mainScreen].bounds.size.height;
        if (h>0) {
            [self.textView setContentOffset:CGPointMake(0, h+44)];
        }
        
    });
}

-(void)LOG_VC
{
    logVc = [[UIViewController alloc] init];
    self.textView.text = @"";
    [logVc.view addSubview:self.textView];
    logVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:logVc animated:YES completion:nil];
    
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(screenW-65.0,44,60,44)];
    labe.text = @"关闭";
    labe.textAlignment = NSTextAlignmentCenter;
    labe.font = [UIFont systemFontOfSize:20];;
    labe.layer.borderColor = UIColor.blackColor.CGColor;
    labe.layer.borderWidth = 1;
    labe.backgroundColor = UIColor.whiteColor;
    [logVc.view addSubview:labe];
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    labe.userInteractionEnabled = YES;
    [labe addGestureRecognizer:gest];
    
}
-(void)close
{
    [logVc dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark-懒加载
-(UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
        _textView.backgroundColor = [UIColor colorWithRed:55/255.0 green:116/255.0 blue:67/255.0 alpha:1];
        _textView.textColor = [UIColor colorWithRed:253/255.0 green:239/255.0 blue:174/255.0 alpha:1];
        _textView.editable = YES;
    }
    return _textView;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
-(NSArray *)titlesArray
{
    if (!_titlesArray) {
        _titlesArray =  [NSArray arrayWithObjects:
                         @"AF 下载文件",@"SC 下载文件",
                         @"AF 上传文件",@"SC 上传文件",
                         @"AF 多文件上传",@"SC 多文件上传",
                         @"AF1 多文件上传",@"AF_POST_JSON_norm",
                         @"AF_app_urlencoded",@"AF_app_json",
                         @"sc_post_json",@"af_post_http_session",
                         nil];
    }
    return _titlesArray;
}
@end
