//
//  NSLayoutConstraint+SSLayout.h
//  NSLayoutConstraint+SSLayout
//
//  Created by suruihai on 2017/1/23.
//  Copyright © 2017年 ruihai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSLayoutAttribute : NSObject

@property (assign, nonatomic) NSLayoutAttribute attribute;

/*
 *  use weak reference since view carries a pointer pointing the attribute
 */
@property (weak, nonatomic) UIView* view;

/*
 *  only use in NSLayoutAttributeWidth | NSLayoutAttributeHeight, for convenience use, example: self.view.height_attr.constant = 50;
 */
@property (assign, nonatomic) CGFloat constant;

/**
 *  example: [self.view.top_attr lesserThan:[[UIApplication sharedApplication].delegate window].top_attr]
 */
- (NSLayoutConstraint *)lesserThan:(SSLayoutAttribute *)attr;
- (NSLayoutConstraint *)lesserThan:(SSLayoutAttribute *)attr constant:(CGFloat)constant;
- (NSLayoutConstraint *)lesserThan:(SSLayoutAttribute *)attr constant:(CGFloat)constant priority:(UILayoutPriority)priority;
- (NSLayoutConstraint *)lesserThan:(SSLayoutAttribute *)attr constant:(CGFloat)constant multiplier:(CGFloat)multiplier priority:(UILayoutPriority)priority;

/**
 *  example: [self.view.top_attr greaterThan:[[UIApplication sharedApplication].delegate window].top_attr]
 */
- (NSLayoutConstraint *)greaterThan:(SSLayoutAttribute *)attr;
- (NSLayoutConstraint *)greaterThan:(SSLayoutAttribute *)attr constant:(CGFloat)constant;
- (NSLayoutConstraint *)greaterThan:(SSLayoutAttribute *)attr constant:(CGFloat)constant priority:(UILayoutPriority)priority;
- (NSLayoutConstraint *)greaterThan:(SSLayoutAttribute *)attr constant:(CGFloat)constant multiplier:(CGFloat)multiplier priority:(UILayoutPriority)priority;

/**
 *  example: [self.view.top_attr equalTo:[[UIApplication sharedApplication].delegate window].top_attr]
 */
- (NSLayoutConstraint *)equalTo:(SSLayoutAttribute *)attr;
- (NSLayoutConstraint *)equalTo:(SSLayoutAttribute *)attr constant:(CGFloat)constant;
- (NSLayoutConstraint *)equalTo:(SSLayoutAttribute *)attr constant:(CGFloat)constant priority:(UILayoutPriority)priority;
- (NSLayoutConstraint *)equalTo:(SSLayoutAttribute *)attr constant:(CGFloat)constant multiplier:(CGFloat)multiplier priority:(UILayoutPriority)priority;
@end

/**
 * SSLayoutAttribute construction function
 */
static inline SSLayoutAttribute *SSLayoutAttributeMake(id view, NSLayoutAttribute attribute) {
    SSLayoutAttribute *attr = [[SSLayoutAttribute alloc] init];
    attr.view = view;
    attr.attribute = attribute;
    return attr;
}

@interface NSLayoutConstraint (SSLayout)

/**
 *  expanded the original method with priority
 */
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)constant ss_priority:(UILayoutPriority)priority;

@end

@interface UIView(SSLayout)
@property (strong, nonatomic) SSLayoutAttribute *left_attr;
@property (strong, nonatomic) SSLayoutAttribute *right_attr;
@property (strong, nonatomic) SSLayoutAttribute *top_attr;
@property (strong, nonatomic) SSLayoutAttribute *bottom_attr;
@property (strong, nonatomic) SSLayoutAttribute *leading_attr;
@property (strong, nonatomic) SSLayoutAttribute *trailing_attr;
@property (strong, nonatomic) SSLayoutAttribute *width_attr;
@property (strong, nonatomic) SSLayoutAttribute *height_attr;
@property (strong, nonatomic) SSLayoutAttribute *centerX_attr;
@property (strong, nonatomic) SSLayoutAttribute *centerY_attr;
@property (strong, nonatomic) SSLayoutAttribute *lastBaseline_attr;
@property (strong, nonatomic) SSLayoutAttribute *firstBaseLine_attr;

// used while making constraint to a reference object, aka safeAreaLayoutGuide, only applicable for iOS11 or newer.
// only getter is implemented, because setting a layoutguide's constraint has no point.
@property (strong, nonatomic) SSLayoutAttribute *left_attr_safe;
@property (strong, nonatomic) SSLayoutAttribute *right_attr_safe;
@property (strong, nonatomic) SSLayoutAttribute *top_attr_safe;
@property (strong, nonatomic) SSLayoutAttribute *bottom_attr_safe;
@property (strong, nonatomic) SSLayoutAttribute *leading_attr_safe;
@property (strong, nonatomic) SSLayoutAttribute *trailing_attr_safe;
@property (strong, nonatomic) SSLayoutAttribute *centerX_attr_safe;
@property (strong, nonatomic) SSLayoutAttribute *centerY_attr_safe;

/**
 *  activate all constraints written in the block parameter, also store them in a mutablearray for further use. Constraints should be relative to its view, which is the caller of this method
 */
- (void)activateConstraints:(void (^)(void))constraints;

- (void)activateAllConstraints;
/**
 *  activate specific constraint
 */
- (void)activateConstraintAccordingToAttribute:(SSLayoutAttribute *)attribute;
- (void)activateConstraintAccordingToAttribute:(SSLayoutAttribute *)attribute andAttribute:(SSLayoutAttribute *)otherAttribute;
- (void)activateConstraintAccordingToAttribute:(SSLayoutAttribute *)attribute andAttribute:(SSLayoutAttribute *)otherAttribute relation:(NSLayoutRelation)relation;

- (void)deactivateAllConstraints;
- (void)deactivateAllConstraintsAndAssociatedObjects;
/**
 *  deactivate specific constraint, will destroy the constraint object. If only temporary deactivate, use constraintAccordingToAttribute:andAttribute: to get the constraint object and set its active = NO
 */
- (void)deactivateConstraintAccordingToAttribute:(SSLayoutAttribute *)attribute;
- (void)deactivateConstraintAccordingToAttribute:(SSLayoutAttribute *)attribute andAttribute:(SSLayoutAttribute *)otherAttribute;
- (void)deactivateConstraintAccordingToAttribute:(SSLayoutAttribute *)attribute andAttribute:(SSLayoutAttribute *)otherAttribute relation:(NSLayoutRelation)relation;

- (NSMutableArray<NSLayoutConstraint *> *)allConstraints;
/**
 *  get specific constraint
 */
- (NSLayoutConstraint *)constraintAccordingToAttribute:(SSLayoutAttribute *)attribute;
- (NSLayoutConstraint *)constraintAccordingToAttribute:(SSLayoutAttribute *)attribute andAttribute:(SSLayoutAttribute *)otherAttribute;
- (NSLayoutConstraint *)constraintAccordingToAttribute:(SSLayoutAttribute *)attribute andAttribute:(SSLayoutAttribute *)otherAttribute relation:(NSLayoutRelation)relation;

@end
