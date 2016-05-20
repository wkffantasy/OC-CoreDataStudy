//
//  ViewController.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/19.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "ViewController.h"

#import "common.h"

#import "OneModleController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  self.automaticallyAdjustsScrollViewInsets = NO;
  
  
  [self setupButton];
}

- (void)setupButton{

  
  NSArray * array = @[
                      @"一个简单的model的增删改查，没有文件",
                      @"一个model，有音频的文件"
                      ];
  
  CGFloat buttonH = 40;
  CGFloat buttonX = 20;
  CGFloat buttonW = kScreenWidth - 2 * buttonX;
  for (int i = 0; i<array.count; i++) {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:array[i] forState:UIControlStateNormal];
    button.frame = CGRectMake(buttonX, i*buttonH+20 + 64, buttonW, buttonH);
    button.tag = 100+i;
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
  }
  

}

- (void)clickButton:(UIButton *)button{
  
  int tag = (int)button.tag;
  switch (tag) {
    case 100:{
      
      OneModleController * omVC = [[OneModleController alloc]init];
      [self.navigationController pushViewController:omVC animated:YES];
    
    }
      break;
    case 101:{
      
      
      
    }
      break;
      
    default:
      break;
  }
  
}




@end
