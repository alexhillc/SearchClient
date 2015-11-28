//
//  ASCView.h
//  SearchClient
//
//  Created by Alex Hill on 11/21/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASCTableView.h"
#import "ASCSearchBar.h"

extern CGFloat const ASCViewTextFieldHeight;
extern CGFloat const ASCViewTableViewExpandedOffsetY;
extern CGFloat const ASCViewTextFieldExpandedOffsetY;
extern CGFloat const ASCViewTextFieldContractedMultiplierOffsetY;
extern CGFloat const ASCViewTextFieldContractedMultiplierWidth;
extern CGFloat const ASCViewTextFieldExpandedMultiplierWidth;
extern NSTimeInterval const ASCViewAnimationDuration;

@interface ASCView : UIView

@property (nonatomic, weak) NSLayoutConstraint *searchBarConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *searchBarConstraintHeight;
@property (nonatomic, weak) NSLayoutConstraint *searchBarConstraintWidth;
@property (nonatomic, weak) NSLayoutConstraint *searchBarConstraintCenter;
@property (nonatomic, weak) NSLayoutConstraint *searchTableViewConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *searchTableViewConstraintHeight;
@property (nonatomic, weak) NSLayoutConstraint *searchTableViewConstraintWidth;
@property (nonatomic, weak) NSLayoutConstraint *searchTableViewConstraintCenter;

@property (nonatomic, assign) BOOL isFirstLayout;

@property ASCSearchBar *searchBar;
@property ASCTableView *searchTableView;
@property UIView *shadowSearchTableView;

- (void)setup;

- (void)expandToKeyboardHeight:(CGFloat)keyboardHeight;
- (void)contract;
- (BOOL)isExpanded;

@end
