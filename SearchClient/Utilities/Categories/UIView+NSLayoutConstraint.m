//
//  UIView+NSLayoutConstraint.m
//  SearchClient
//
//  Created by Alex Hill on 11/9/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "UIView+NSLayoutConstraint.h"

@implementation UIView (NSLayoutConstraint)

- (void)asc_centerInParentHMultiplier:(float)hMultiplier hConstant:(float)hConstant vMultiplier:(float)vMultiplier vConstant:(float)vConstant
{
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:hMultiplier constant:hConstant];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterY multiplier:vMultiplier constant:vConstant];
    
    [self.superview addConstraints:@[centerX, centerY]];
}

- (NSLayoutConstraint *)asc_centerHorizontallyInParent {
    return [self asc_centerHorizontallyInParentMultiplier:1];
}

- (NSLayoutConstraint *)asc_centerHorizontallyInParentMultiplier:(float)multiplier {
    assert(self.superview);
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:multiplier constant:0];
    
    [self.superview addConstraint:centerX];
    
    return centerX;
}

- (void)asc_fillSuperview {
    assert(self.superview);
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1. constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1. constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeWidth multiplier:1. constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeHeight multiplier:1. constant:0];
    
    [self.superview addConstraints:@[left, top, width, height]];
}

- (NSLayoutConstraint *)asc_widthProportionalToParentWidth:(float)proportion constant:(float)constant {
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeWidth multiplier:proportion constant:constant];
    [self.superview addConstraint:width];
    
    return width;
}
- (NSLayoutConstraint *)asc_heightProportionalToParentHeight:(float)proportion constant:(float)constant {
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeHeight multiplier:proportion constant:constant];
    [self.superview addConstraint:height];
    
    return height;
}

- (NSLayoutConstraint *)asc_heightProportionalToWidth:(float)proportion constant:(float)constant {
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:proportion constant:constant];
    [self addConstraint:height];
    
    return height;
}

- (NSLayoutConstraint *)asc_pinEdge:(NSLayoutAttribute)edge toParentEdge:(NSLayoutAttribute)parentEdge constant:(float)constant
{
    assert(self.superview);
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:edge relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:parentEdge multiplier:1 constant:constant];
    [self.superview addConstraint:constraint];
    
    return constraint;
}

- (NSLayoutConstraint *)asc_pinToEdgeOfParent:(NSLayoutAttribute)edge constant:(float)constant {
    return [self asc_pinEdge:edge toParentEdge:edge constant:constant];
}

- (NSLayoutConstraint *)asc_pinEdge:(NSLayoutAttribute)edge toEdge:(NSLayoutAttribute)otherEdge ofSibling:(UIView *)sibling constant:(float)constant {
    assert(self.superview);
    assert(self.superview == sibling.superview);
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:edge relatedBy:NSLayoutRelationEqual toItem:sibling attribute:otherEdge multiplier:1. constant:constant];
    
    [self.superview addConstraint:constraint];
    
    return constraint;
}

- (NSLayoutConstraint *)asc_setAttribute:(NSLayoutAttribute)attribute toConstant:(float)constant {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1. constant:constant];
    [self addConstraint:constraint];
    
    return constraint;
}

- (void)removeAllConstraints {
    assert(self.superview);
    
    NSMutableArray *removingArray = [NSMutableArray array];
    for (NSLayoutConstraint *constraint in [self.superview constraints]) {
        if (constraint.firstItem == self) {
            [removingArray addObject:constraint];
        }
    }
    
    [NSLayoutConstraint deactivateConstraints:removingArray];
}

@end
