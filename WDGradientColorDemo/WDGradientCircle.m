//
//  WDGradientCircle.m
//  WDGradientColorDemo
//
//  Created by wangwendong on 2017/5/8.
//  Copyright © 2017年 Sunricher. All rights reserved.
//

#import "WDGradientCircle.h"

@interface WDGradientCircle () {
    CGFloat radius;
}

@end

@implementation WDGradientCircle

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    CGFloat R = width;
    
    if (width > height) {
        R = height;
    }
    
    radius = R / 2.0;
    
    for (NSInteger w = 0; w <= width; w++) {
        for (NSInteger h = 0; h <= height; h++) {
            UIColor *color = [self colorAtPoint:CGPointMake(w, h) radius:radius];
            CGContextSetFillColorWithColor(ctx, color.CGColor);
            CGContextFillRect(ctx, CGRectMake(w, h, 1, 1));
        }
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:0 endAngle:2 * M_PI clockwise:YES];
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.path = path.CGPath;
    circle.fillMode = kCAFillModeBoth;
    circle.fillColor = [UIColor redColor].CGColor;
    
    [self.layer addSublayer:circle];
    self.layer.mask = circle;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_delegate && [_delegate respondsToSelector:@selector(gradientCircle:didMoveToColor:)]) {
        [_delegate gradientCircle:self didMoveToColor:[self getTouchPointColor:touches.anyObject]];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_delegate && [_delegate respondsToSelector:@selector(gradientCircle:didMoveToColor:)]) {
        [_delegate gradientCircle:self didMoveToColor:[self getTouchPointColor:touches.anyObject]];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_delegate && [_delegate respondsToSelector:@selector(gradientCircle:didSelectedColor:)]) {
        [_delegate gradientCircle:self didSelectedColor:[self getTouchPointColor:touches.anyObject]];
    }
}

#pragma mark - private

- (UIColor *)getTouchPointColor:(UITouch *)touch {
    if (!touch) {
        return [UIColor clearColor];
    }
    
    return [self colorAtPoint:[touch locationInView:self] radius:radius];
}

- (UIColor *)colorAtPoint:(CGPoint)point radius:(CGFloat)r {
    CGFloat x = point.x - r;
    CGFloat y = r - point.y;
    
    if (x == 0 && y == 0) {
        return [UIColor whiteColor];
    }
    
    CGFloat xyRadius = sqrt(pow(x, 2) + pow(y, 2));
    CGFloat sin = fabs(y / xyRadius);
    CGFloat arcSin = asin(sin);
    
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
                radian = M_PI_2 - arcSin;
            } else if ( y < 0) {
                radian = M_PI_2 + arcSin;
            }
        } else if (x < 0) {
            if (y > 0) {
                radian = M_PI + M_PI_2 + arcSin;
            } else if (y < 0) {
                radian = M_PI + M_PI_2 - arcSin;
            }
        }
    }
    
    CGFloat hue = radian * 0.5 / M_PI;
    CGFloat saturation = xyRadius / r;
    
    if (hue > 1) {
        hue = 1;
    }
    if (saturation > 1) {
        saturation = 1;
    }
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:1.0 alpha:1.0];
}

@end
