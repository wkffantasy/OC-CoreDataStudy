//
//  DownloadTool.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/20.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "DownloadTool.h"
#import "common.h"

@interface DownloadTool ()<NSURLSessionDownloadDelegate>



@property (strong, nonatomic) NSURLSessionDownloadTask* downloadTask;

@property (strong, nonatomic) NSURLSession* session;

@property (copy, nonatomic) NSString * filePath;


@end

@implementation DownloadTool

- (NSString *)applicationDocumentUrlString {
  
  return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"AllMyAudio"];
}

- (instancetype)initWithUrl:(NSString *)downloadUrl andFileName:(NSString *)name{
  
  if (self = [super init]) {
    
    NSAssert(downloadUrl.length > 0, @"");
    
    NSFileManager * mgr = [NSFileManager defaultManager];
    
    _filePath = [self applicationDocumentUrlString];
    
    NSError * error;
    if (![mgr fileExistsAtPath:_filePath]) {
      
      [mgr createDirectoryAtPath:_filePath withIntermediateDirectories:YES attributes:nil error:&error];
      
    }
    
    if (error) {

      NSLog(@"create failed  %@",error.localizedDescription);
    }
    
    
    _downloadUrl = downloadUrl;
    _fileName    = name;
    _localPath = [NSString stringWithFormat:@"%@/%@.mp3",_filePath,name];
    
    self.downloadStatus = DownloadStatusNotBegan;
    NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
  }
  return self;
  
}



- (void)startDownload{
  
  self.downloadTask = [self.session downloadTaskWithURL:[NSURL URLWithString:self.downloadUrl]];
  self.downloadStatus = DownloadStatusDoing;
  [self.downloadTask resume];
  
  
}

- (void)goonDownload{

  self.downloadStatus = DownloadStatusDoing;
  self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
  
  [self.downloadTask resume]; // 开始任务
  
  self.resumeData = nil;
  
}

- (void)pause{
  
  @weakify(self);
  [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
    @strongify(self);
    
    self.downloadStatus = DownloadStatusIsPause;
    self.resumeData = resumeData;
    self.downloadTask = nil;
    
    if (_pauseBlock) {
      self.pauseBlock(self.resumeData);
    }
    
  }];
  
}

#pragma mark -- NSURLSessionDownloadDelegate

//下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
  
  NSAssert(_localPath.length > 0, @"");
  self.downloadStatus = DownloadStatusHaveFinished;
  NSFileManager * mgr = [NSFileManager defaultManager];
  NSError * removeError ;
  //如果该路径下文件已经存在 删除
  if ([mgr fileExistsAtPath:_localPath]) {
    [mgr removeItemAtPath:_localPath error:&removeError];
    
  }
  if (removeError) {
    NSLog(@"already exist remove faile %@",removeError.localizedDescription);
  }
  
  NSError * error ;
  [mgr moveItemAtPath:location.path toPath:_localPath error:&error];
  if (error) {
    
    NSLog(@"move failed %@",error.localizedDescription);
    
  }
  
  if (self.finishedBlock) {
    
    self.finishedBlock(self);
  }
  
}

//下载中
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{

  if (self.downloadingBlock) {
    self.downloadingBlock(totalBytesWritten,totalBytesExpectedToWrite);
  }
  
}
//
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{

  
  
}

@end
