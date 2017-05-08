//
//  WDGradientView.m
//  WDGradientColorDemo
//
//  Created by wangwendong on 2017/5/8.
//  Copyright © 2017年 Sunricher. All rights reserved.
//

#import "WDGradientView.h"

@implementation WDGradientView

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    NSInteger width = CGRectGetWidth(self.bounds);
    NSInteger height = CGRectGetHeight(self.bounds);
    
    UIColor *color = nil;
    for (NSInteger x = 0; x <= width; x++) {
        for (NSInteger y = 0; y <= height; y++) {
            color = [self colorAtPoint:CGPointMake(x, y) inSize:self.bounds.size];
            CGContextSetFillColorWithColor(ctx, color.CGColor);
            CGContextFillRect(ctx, CGRectMake(x, y, 1, 1));            
        }
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width / 2.0, height / 2.0) radius:width / 2.0 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.path = path.CGPath;
    circle.fillMode = kCAFillModeBoth;
    circle.fillColor = [UIColor redColor].CGColor;
    
    [self.layer addSublayer:circle];
    self.layer.mask = circle;
}

- (UIColor *)colorAtPoint:(CGPoint)point inSize:(CGSize)size {
    CGFloat R = size.width;
    if (size.width > size.height) {
        R = size.height;
    }
    
    CGFloat r = (R / 2.0);
    
    CGFloat x = (point.x - r);
    CGFloat y = (r - point.y);
    
    
    if (x == 0 && y == 0) {
        return [UIColor whiteColor];
    }
    
    CGFloat r_ = sqrt(pow(x, 2) + pow(y, 2));
    
    CGFloat sin = fabs(y / r_);
    CGFloat asinValue = asin(sin);
    
    CGFloat radian = 0;
    
    if (x == 0 || y == 0) {
        if (x == 0) {
            if (y < 0) {
                radian = M_PI;
            }
        }
        
        if (y == 0) {
            if (x > 0) {
                radian = M_PI_2;
            } else if (x < 0) {
                radian = M_PI_2 + M_PI;
            }
        }
    } else {
        if (x > 0) {
            if (y > 0) {
                radian = M_PI_2 - asinValue;
            } else if ( y < 0) {
                radian = M_PI_2 + asinValue;
            }
        } else if (x < 0) {
            if (y > 0) {
                radian = M_PI + M_PI_2 + asinValue;
            } else if (y < 0) {
                radian = M_PI + M_PI_2 - asinValue;
            }
        }
    }
    
    CGFloat hue = radian * 0.5 / M_PI;
    CGFloat saturation = sqrt(pow(x, 2) + pow(y, 2)) / r;
    
    if (hue > 1) {
        hue = 1;
    }
    
    if (saturation > 1) {
        saturation = 1;
    }
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:1 alpha:1];
}

@end
