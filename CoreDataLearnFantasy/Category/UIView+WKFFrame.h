//
//  UIView+WKFFrame.h
//  
//
//  Created by toncent on 15/4/2.
//  Copyright (c) 2015年 toncent. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  对于UIView 直接.语法 能拿到 下面四个属性
 */

@interface UIView (WKFFrame)


@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;


@end
