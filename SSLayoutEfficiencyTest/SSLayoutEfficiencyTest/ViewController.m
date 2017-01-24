//
//  ViewController.m
//  SSLayoutEfficiencyTest
//
//  Created by suruihai on 2017/1/23.
//  Copyright © 2017年 ruihai. All rights reserved.
//

#import "ViewController.h"
#import "NSLayoutConstraint+SSLayout.h"
#import "Masonry.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (strong, nonatomic) UIView *blueView;
@property (strong, nonatomic) UIView *redView;

- (IBAction)SSAB;
- (IBAction)SSNM;
- (IBAction)ANCHOR;
- (IBAction)DEFAULT;
- (IBAction)DEFAULT2;
- (IBAction)MASONRY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dealloc {
    NSLog(@"dealloc---%@", [self class]);
}

- (void)setupUI {
    [self.blueView removeFromSuperview];
    [self.redView removeFromSuperview];
    self.blueView = nil;
    self.redView = nil;
    [self.view addSubview:self.blueView];
    [self.view addSubview:self.redView];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    if (self.blueView.width_attr.constant == 50) {
//        self.blueView.width_attr.constant = 100;
//    } else {
//        self.blueView.width_attr.constant = 50;
//    }
//}

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

- (void)clear {
    
    [self setupUI];
    
    [self.redView activateConstraints:^{
        self.redView.height_attr.constant = 100;
        self.redView.width_attr.constant = 50;
        [self.redView.top_attr equalTo:self.view.top_attr constant:300];
        [self.redView.leading_attr equalTo:self.view.leading_attr constant:200];
    }];
}

// SSLayout Abbreviated Usage
- (IBAction)SSAB {
    [self clear];
    double start = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<1000; i++) {
        [self.blueView activateConstraints:^() {
            self.blueView.height_attr.constant = 50;
            self.blueView.width_attr = self.redView.width_attr;
            self.blueView.top_attr = self.redView.bottom_attr;
            self.blueView.leading_attr = self.view.leading_attr;
        }];
    }
    NSLog(@"duration---%f", CFAbsoluteTimeGetCurrent() - start);
    //    NSLog(@"view constraints---%@", self.view.constraints);
    //    NSLog(@"blueview constraints---%@", self.blueView.constraints);
}

// SSLayout Normal Usage
- (IBAction)SSNM {
    [self clear];
    double start = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<1000; i++) {
        [self.blueView activateConstraints:^() {
            [self.blueView.height_attr equalTo:nil constant:50];
            [self.blueView.width_attr equalTo:self.redView.width_attr];
            [self.blueView.top_attr equalTo:self.redView.bottom_attr];
            [self.blueView.leading_attr equalTo:self.view.leading_attr];
        }];
    }
    NSLog(@"duration---%f", CFAbsoluteTimeGetCurrent() - start);
    //    NSLog(@"view constraints---%@", self.view.constraints);
    //    NSLog(@"blueview constraints---%@", self.blueView.constraints);
}

// NSLayoutAnchor
- (IBAction)ANCHOR {
    [self clear];
    if (self.blueView.translatesAutoresizingMaskIntoConstraints) {
        self.blueView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    double start = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<1000; i++) {
        [self.view addConstraint:[self.blueView.heightAnchor constraintEqualToConstant:50]];
        [self.view addConstraint:[self.blueView.widthAnchor constraintEqualToAnchor:self.redView.widthAnchor]];
        [self.view addConstraint:[self.blueView.topAnchor constraintEqualToAnchor:self.redView.bottomAnchor]];
        [self.view addConstraint:[self.blueView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor]];
    }
    NSLog(@"duration---%f", CFAbsoluteTimeGetCurrent() - start);
    //    NSLog(@"view constraints---%@", self.view.constraints);
    //    NSLog(@"blueview constraints---%@", self.blueView.constraints);
}

// System Default Method appointed constraint owner
- (IBAction)DEFAULT {
    [self clear];
    if (self.blueView.translatesAutoresizingMaskIntoConstraints) {
        self.blueView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    double start = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<1000; i++) {
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50 ss_priority:UILayoutPriorityRequired]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeWidth multiplier:1 constant:0 ss_priority:UILayoutPriorityRequired]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeBottom multiplier:1 constant:0 ss_priority:UILayoutPriorityRequired]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0 ss_priority:UILayoutPriorityRequired]];
    }
    NSLog(@"duration---%f", CFAbsoluteTimeGetCurrent() - start);
    //    NSLog(@"view constraints---%@", self.view.constraints);
    //    NSLog(@"blueview constraints---%@", self.blueView.constraints);
}

// System Default Method without appointed owner
- (IBAction)DEFAULT2 {
    [self clear];
    if (self.blueView.translatesAutoresizingMaskIntoConstraints) {
        self.blueView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    double start = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<1000; i++) {
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:4];
        [arrayM addObject:[NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50 ss_priority:UILayoutPriorityRequired]];
        [arrayM addObject:[NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeWidth multiplier:1 constant:0 ss_priority:UILayoutPriorityRequired]];
        [arrayM addObject:[NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeBottom multiplier:1 constant:0 ss_priority:UILayoutPriorityRequired]];
        [arrayM addObject:[NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0 ss_priority:UILayoutPriorityRequired]];
        [NSLayoutConstraint activateConstraints:arrayM];
    }
    NSLog(@"duration---%f", CFAbsoluteTimeGetCurrent() - start);
    //    NSLog(@"view constraints---%@", self.view.constraints);
    //    NSLog(@"blueview constraints---%@", self.blueView.constraints);
}

- (IBAction)MASONRY {
    [self clear];
    double start = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<1000; i++) {
        [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.width.equalTo(self.redView.mas_width);
            make.top.equalTo(self.redView.mas_bottom);
            make.leading.equalTo(self.view.mas_leading);
        }];
    }
    NSLog(@"duration---%f", CFAbsoluteTimeGetCurrent() - start);
    //    NSLog(@"view constraints---%@", self.view.constraints);
    //    NSLog(@"blueview constraints---%@", self.blueView.constraints);
}

@end
