//
//  AddDownloadTaskController.h
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/20.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SuperContollerNeedReload)();

@interface AddDownloadTaskController : UIViewController

@property (copy, nonatomic) SuperContollerNeedReload  needReload;

@end
