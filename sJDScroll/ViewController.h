//
//  ViewController.h
//  sJDScroll
//
//  Created by CaydenK on 2018/1/8.
//  Copyright © 2018年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define kSpaceW(W) W * (WIDTH / 375)
#define kSpaceH(H) H * (HEIGHT / 667)

#define iOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#define iOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define iOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define iOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)


#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kMinLeftspacing 12//距左一级间距

@interface ViewController : UIViewController


@end

