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

@property (copy, nonatomic) NSString * downloadUrl;

@property (strong, nonatomic) NSURLSessionDownloadTask* downloadTask;

@property (strong, nonatomic) NSURLSession* session;

@property (copy, nonatomic) NSString * filePath;

@end

@implementation DownloadTool

- (NSString *)applicationDocumentUrlString {
  
  return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"AllMyAudio"];
}

- (instancetype)initWithUrl:(NSString *)downloadUrl{
  
  if (self = [super init]) {
    
    NSAssert(downloadUrl.length > 0, @"");
    
    NSFileManager * mgr = [NSFileManager defaultManager];
    
    _filePath = [self applicationDocumentUrlString];
    
    NSError * error;
    if (![mgr fileExistsAtPath:_filePath]) {
      
      [mgr createDirectoryAtPath:_localPath withIntermediateDirectories:YES attributes:nil error:&error];
      
    }
    
    if (error) {
      //TODO: (fantasy) always failed
      NSLog(@"create failed  %@",error.localizedDescription);
    }
    
    _localPath = [_filePath stringByAppendingPathComponent:downloadUrl];
    
    _downloadUrl = downloadUrl;
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
    
  }];
  
}

#pragma mark -- NSURLSessionDownloadDelegate

//下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
  
  self.downloadStatus = DownloadStatusHaveFinished;
  
  NSFileManager * mgr = [NSFileManager defaultManager];
  [mgr moveItemAtPath:location.path toPath:_localPath error:nil];
  
  if (self.finishedBlock) {
    self.finishedBlock();
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
