//
//  UIView+NSLayoutConstraint.h
//  SearchClient
//
//  Created by Alex Hill on 11/9/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "UIKit/UIKit.h"

@interface UIView (NSLayoutConstraint)

- (void)asc_fillSuperview;
- (void)asc_centerInParentHMultiplier:(float)hMultiplier hConstant:(float)hConstant vMultiplier:(float)vMultiplier vConstant:(float)vConstant;
- (NSLayoutConstraint *)asc_centerHorizontallyInParent;
- (NSLayoutConstraint *)asc_centerHorizontallyInParentMultiplier:(float)multiplier;
- (NSLayoutConstraint *)asc_widthProportionalToParentWidth:(float)proportion constant:(float)constant;
- (NSLayoutConstraint *)asc_heightProportionalToParentHeight:(float)proportion constant:(float)constant;
- (NSLayoutConstraint *)asc_heightProportionalToWidth:(float)proportion constant:(float)constant;
- (NSLayoutConstraint *)asc_pinEdge:(NSLayoutAttribute)edge toParentEdge:(NSLayoutAttribute)parentEdge constant:(float)constant;
- (NSLayoutConstraint *)asc_pinToEdgeOfParent:(NSLayoutAttribute)edge constant:(float)constant;
- (NSLayoutConstraint *)asc_pinEdge:(NSLayoutAttribute)edge toEdge:(NSLayoutAttribute)otherEdge ofSibling:(UIView *)sibling constant:(float)constant;
- (NSLayoutConstraint *)asc_setAttribute:(NSLayoutAttribute)attribute toConstant:(float)constant;

- (void)removeAllConstraints;

@end
