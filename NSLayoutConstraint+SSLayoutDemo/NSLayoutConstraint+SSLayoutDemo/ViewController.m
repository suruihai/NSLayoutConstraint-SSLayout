//
//  ViewController.m
//  NSLayoutConstraint+SSLayoutDemo
//
//  Created by suruihai on 2017/1/23.
//  Copyright © 2017年 ruihai. All rights reserved.
//

#import "ViewController.h"
#import "NSLayoutConstraint+SSLayout.h"

@interface ViewController ()
@property (strong, nonatomic) UIView *blueView;
@property (strong, nonatomic) UIView *redView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self prepareLayout];
}

- (void)dealloc {
    NSLog(@"dealloc---%@", [self class]);
}

- (void)setupUI {
    [self.view addSubview:self.blueView];
    [self.view addSubview:self.redView];
}

- (void)prepareLayout {
    [self.blueView activateConstraints:^() {
        self.blueView.height_attr.constant = 50;
        self.blueView.width_attr.constant = 50;
        [self.blueView.top_attr equalTo:self.view.top_attr constant:64];
        [self.blueView.leading_attr equalTo:self.view.leading_attr constant:10];
    }];
    
    [self.redView activateConstraints:^{
        self.redView.height_attr.constant = 100;
        self.redView.width_attr = self.blueView.width_attr;
        self.redView.top_attr = self.blueView.top_attr;
        self.redView.leading_attr = self.blueView.trailing_attr;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.blueView.width_attr.constant == 50) {
        self.blueView.width_attr.constant = 100;
    } else {
        self.blueView.width_attr.constant = 50;
    }
}

- (UIView *)blueView {
    if (_blueView == nil) {
        _blueView = [[UIView alloc] init];
        _blueView.backgroundColor = [UIColor blueColor];
    }
    return _blueView;
}

- (UIView *)redView {
    if (_redView == nil) {
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}


@end
