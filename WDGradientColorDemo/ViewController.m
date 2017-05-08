//
//  ViewController.m
//  WDGradientColorDemo
//
//  Created by wangwendong on 2017/5/8.
//  Copyright © 2017年 Sunricher. All rights reserved.
//


#import "ViewController.h"
#import "WDGradientCircle.h"

@interface ViewController () <WDGradientCircleDelegate>
@property (weak, nonatomic) IBOutlet WDGradientCircle *circle;
@property (weak, nonatomic) IBOutlet UIView *show;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _circle.delegate = self;
}


- (void)gradientCircle:(WDGradientCircle *)circle didMoveToColor:(UIColor *)color {
    _show.backgroundColor = color;
}

- (void)gradientCircle:(WDGradientCircle *)circle didSelectedColor:(UIColor *)color {
    self.view.backgroundColor = color;
    _show.backgroundColor = color;
}

@end
