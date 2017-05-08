//
//  WDGradientCircle.h
//  WDGradientColorDemo
//
//  Created by wangwendong on 2017/5/8.
//  Copyright © 2017年 Sunricher. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WDGradientCircle;

@protocol WDGradientCircleDelegate <NSObject>

@optional
- (void)gradientCircle:(WDGradientCircle *)circle didMoveToColor:(UIColor *)color;
- (void)gradientCircle:(WDGradientCircle *)circle didSelectedColor:(UIColor *)color;

@end

@interface WDGradientCircle : UIView

@property (weak, nonatomic) id<WDGradientCircleDelegate> delegate;

@end
