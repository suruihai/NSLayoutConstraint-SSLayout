//
//  ViewController.m
//  SSLayoutEfficiencyTest
//
//  Created by suruihai on 2017/1/23.
//  Copyright © 2017年 ruihai. All rights reserved.
//

#import "ViewController.h"
#import "NSLayoutConstraint+SSLayout.h"
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
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self setupUI];
}

- (void)dealloc {
    NSLog(@"dealloc---%@", [self class]);
}

- (void)setupUI {
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
    [self.view removeConstraints:self.view.constraints];
    [self.blueView removeConstraints:self.blueView.constraints];
    objc_removeAssociatedObjects(self.blueView);
}

- (IBAction)SSAB {
    [self clear];
    double start = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<10000; i++) {
        [self.blueView activateConstraints:^() {
            self.blueView.height_attr.constant = 50;
            self.blueView.width_attr.constant = 50;
            self.blueView.top_attr = self.view.top_attr;
            self.blueView.leading_attr = self.view.leading_attr;
        }];
    }
    NSLog(@"duration---%f", CFAbsoluteTimeGetCurrent() - start);
    //    NSLog(@"view constraints---%@", self.view.constraints);
    //    NSLog(@"blueview constraints---%@", self.blueView.constraints);
}

- (IBAction)SSNM {
    [self clear];
    double start = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<10000; i++) {
        [self.blueView activateConstraints:^() {
            [self.blueView.height_attr equalTo:nil constant:50];
            [self.blueView.width_attr equalTo:nil constant:50];
            [self.blueView.top_attr equalTo:self.view.top_attr];
            [self.blueView.leading_attr equalTo:self.view.leading_attr];
        }];
    }
    NSLog(@"duration---%f", CFAbsoluteTimeGetCurrent() - start);
    //    NSLog(@"view constraints---%@", self.view.constraints);
    //    NSLog(@"blueview constraints---%@", self.blueView.constraints);
}

- (IBAction)ANCHOR {
    [self clear];
    if (self.blueView.translatesAutoresizingMaskIntoConstraints) {
        self.blueView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    double start = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<10000; i++) {
        [self.view addConstraint:[self.blueView.heightAnchor constraintEqualToConstant:50]];
        [self.view addConstraint:[self.blueView.widthAnchor constraintEqualToConstant:50]];
        [self.view addConstraint:[self.blueView.topAnchor constraintEqualToAnchor:self.view.topAnchor]];
        [self.view addConstraint:[self.blueView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor]];
    }
    NSLog(@"duration---%f", CFAbsoluteTimeGetCurrent() - start);
    //    NSLog(@"view constraints---%@", self.view.constraints);
    //    NSLog(@"blueview constraints---%@", self.blueView.constraints);
}

- (IBAction)DEFAULT {
    [self clear];
    if (self.blueView.translatesAutoresizingMaskIntoConstraints) {
        self.blueView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    double start = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<10000; i++) {
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50 ss_priority:UILayoutPriorityRequired]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50 ss_priority:UILayoutPriorityRequired]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0 ss_priority:UILayoutPriorityRequired]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0 ss_priority:UILayoutPriorityRequired]];
    }
    NSLog(@"duration---%f", CFAbsoluteTimeGetCurrent() - start);
    //    NSLog(@"view constraints---%@", self.view.constraints);
    //    NSLog(@"blueview constraints---%@", self.blueView.constraints);
}

- (IBAction)DEFAULT2 {
    [self clear];
    if (self.blueView.translatesAutoresizingMaskIntoConstraints) {
        self.blueView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    double start = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<10000; i++) {
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:4];
        [arrayM addObject:[NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50 ss_priority:UILayoutPriorityRequired]];
        [arrayM addObject:[NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50 ss_priority:UILayoutPriorityRequired]];
        [arrayM addObject:[NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0 ss_priority:UILayoutPriorityRequired]];
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
    for (int i=0; i<10000; i++) {
        [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(50);
            make.top.equalTo(self.view.mas_top);
            make.leading.equalTo(self.view.mas_leading);
        }];
    }
    NSLog(@"duration---%f", CFAbsoluteTimeGetCurrent() - start);
    //    NSLog(@"view constraints---%@", self.view.constraints);
    //    NSLog(@"blueview constraints---%@", self.blueView.constraints);
}

@end
