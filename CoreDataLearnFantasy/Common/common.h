//
//  common.h
//  My-OCTools
//
//  Created by fantasy on 16/4/21.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#ifndef common_h
#define common_h

// height or width
#define kScreenWidth   [UIApplication sharedApplication].keyWindow.frame.size.width
#define kScreenHeight  [UIApplication sharedApplication].keyWindow.frame.size.height

//颜色 rgb 和16进制颜色
#define RGBcolor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBAcolor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define HEXRGBcolor(h) RGBcolor(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF))
#define HEXRGBAcolor(h,a) RGBAcolor(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF), a)
//随机色
#define RandomColor RGBcolor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//解决循环引用
#define weakify(va) \
autoreleasepool {} \
__weak __typeof__(va) metamacro_concat(va, _weak_) = (va);

#define strongify(va) \
try {} @finally {} \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong __typeof__(va) va = metamacro_concat(va, _weak_);\
_Pragma("clang diagnostic pop")
#define metamacro_concat(A, B) A ## B


// all import
#import "UIView+WKFFrame.h"
#import "PersonEntity.h"

#endif /* common_h */

