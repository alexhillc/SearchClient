//
//  ASCSearchView.m
//  SearchClient
//
//  Created by Alex Hill on 10/19/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchView.h"
#import "ASCSearchResultsView.h"

#define GoogleBlue [UIColor colorWithRed:72.0/255.0 green:133.0/255.0 blue:237.0/255.0 alpha:1.0]
#define GoogleGreen [UIColor colorWithRed:53.0/255.0 green:168.0/255.0 blue:83.0/255.0 alpha:1.0]
#define GoogleYellow [UIColor colorWithRed:251.0/255.0 green:188.0/255.0 blue:5.0/255.0 alpha:1.0]
#define GoogleRed [UIColor colorWithRed:254.0/255.0 green:67.0/255.0 blue:53.0/255.0 alpha:1.0]

@interface ASCSearchView()

@property (nonatomic, weak) NSLayoutConstraint *titleLabelSecondaryConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelSecondaryConstraintCenter;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelPrimaryConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelPrimaryConstraintCenter;

@end

@implementation ASCSearchView

- (void)setup {
    [super setup];
    
    self.searchTableView.alpha = 0;
    self.shadowSearchTableView.alpha = 0;
    
    self.titleLabelSecondary = [[UILabel alloc] init];
    self.titleLabelSecondary.font = [UIFont systemFontOfSize:12];
    self.titleLabelSecondary.text = @"SEARCH API";
    self.titleLabelSecondary.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.titleLabelSecondary];
    
    NSMutableAttributedString *titleLabelText = [[NSMutableAttributedString alloc] initWithString:@"Google"];
    [titleLabelText addAttribute:NSForegroundColorAttributeName value:GoogleBlue range:NSMakeRange(0, 1)];
    [titleLabelText addAttribute:NSForegroundColorAttributeName value:GoogleRed range:NSMakeRange(1, 1)];
    [titleLabelText addAttribute:NSForegroundColorAttributeName value:GoogleYellow range:NSMakeRange(2, 1)];
    [titleLabelText addAttribute:NSForegroundColorAttributeName value:GoogleBlue range:NSMakeRange(3, 1)];
    [titleLabelText addAttribute:NSForegroundColorAttributeName value:GoogleGreen range:NSMakeRange(4, 1)];
    [titleLabelText addAttribute:NSForegroundColorAttributeName value:GoogleRed range:NSMakeRange(5, 1)];
    
    self.titleLabelPrimary = [[UILabel alloc] init];
    self.titleLabelPrimary.font = [UIFont boldSystemFontOfSize:42];
    self.titleLabelPrimary.attributedText = [titleLabelText copy];
    self.titleLabelPrimary.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview:self.titleLabelPrimary];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isFirstLayout) {
        // searchTextField constraints
        self.searchTextFieldConstraintTop = [self.searchTextField asc_pinEdge:NSLayoutAttributeTop toParentEdge:NSLayoutAttributeTop
                                                                     constant:self.bounds.size.height * ASCViewTextFieldContractedMultiplierOffsetY];
        self.searchTextFieldConstraintHeight = [self.searchTextField asc_setAttribute:NSLayoutAttributeHeight toConstant:ASCViewTextFieldHeight];
        self.searchTextFieldConstraintWidth = [self.searchTextField asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCViewTextFieldContractedMultiplierWidth];
        self.searchTextFieldConstraintCenter = [self.searchTextField asc_centerHorizontallyInParent];
        
        // searchTableView constraints
        self.searchTableViewConstraintTop = [self.searchTableView asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom
                                                                    ofSibling:self.searchTextField constant:0.5];
        self.searchTableViewConstraintHeight = [self.searchTableView asc_setAttribute:NSLayoutAttributeHeight toConstant:0.];
        self.searchTableViewConstraintWidth = [self.searchTableView asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCViewTextFieldContractedMultiplierWidth];
        self.searchTableViewConstraintCenter = [self.searchTableView asc_centerHorizontallyInParent];
        
        // shadowSearchTableView constraints
        [self.shadowSearchTableView asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.searchTableView constant:0];
        [self.shadowSearchTableView asc_pinEdge:NSLayoutAttributeLeft toEdge:NSLayoutAttributeLeft ofSibling:self.searchTableView constant:0];
        [self.shadowSearchTableView asc_pinEdge:NSLayoutAttributeRight toEdge:NSLayoutAttributeRight ofSibling:self.searchTableView constant:0];
        [self.shadowSearchTableView asc_pinEdge:NSLayoutAttributeBottom toEdge:NSLayoutAttributeBottom ofSibling:self.searchTableView constant:0];
        
        // titleLabelSecondary constraints
        self.titleLabelSecondaryConstraintTop = [self.titleLabelSecondary asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.searchTextField constant:-40.];
        self.titleLabelSecondaryConstraintCenter = [self.titleLabelSecondary asc_centerHorizontallyInParent];
        
        // titleLabelPrimary constraints
        self.titleLabelPrimaryConstraintTop = [self.titleLabelPrimary asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.titleLabelSecondary constant:-53.];
        self.titleLabelPrimaryConstraintCenter = [self.titleLabelPrimary asc_centerHorizontallyInParent];
        
        self.isFirstLayout = NO;
    } 
}

#pragma mark - Helper methods
- (void)expandToKeyboardHeight:(CGFloat)keyboardHeight {
    [self layoutIfNeeded];

    self.searchTextFieldConstraintTop.constant = ASCViewTextFieldExpandedOffsetY;
    self.searchTextFieldConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth;
    self.searchTableViewConstraintHeight.constant = self.bounds.size.height - keyboardHeight - ASCViewTableViewExpandedOffsetY - 10.0;
    self.searchTableViewConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth;
    
    __weak ASCSearchView *weakSelf = self;
    
    [UIView animateWithDuration:ASCViewAnimationDuration animations:^{
        weakSelf.searchTableView.hidden = NO;
        weakSelf.searchTableView.alpha = 1;
        
        weakSelf.shadowSearchTableView.hidden = NO;
        weakSelf.shadowSearchTableView.alpha = 1;
        
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        weakSelf.titleLabelSecondary.hidden = YES;
        weakSelf.titleLabelPrimary.hidden = YES;
    }];
}

- (void)contract {
    [self layoutIfNeeded];

    __weak ASCSearchView *weakSelf = self;
    [UIView animateWithDuration:ASCViewAnimationDuration animations:^{
        weakSelf.searchTableView.alpha = 0;
        weakSelf.shadowSearchTableView.alpha = 0;
        
        weakSelf.titleLabelSecondary.hidden = NO;
        weakSelf.titleLabelPrimary.hidden = NO;
        
        weakSelf.searchTextFieldConstraintTop.constant = weakSelf.bounds.size.height * ASCViewTextFieldContractedMultiplierOffsetY;
        weakSelf.searchTextFieldConstraintWidth.constant = weakSelf.bounds.size.width * ASCViewTextFieldContractedMultiplierWidth;
        weakSelf.searchTableViewConstraintHeight.constant = 0.;
        weakSelf.searchTableViewConstraintWidth.constant = weakSelf.bounds.size.width * ASCViewTextFieldContractedMultiplierWidth;
        [weakSelf layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        weakSelf.searchTableView.hidden = YES;
        weakSelf.shadowSearchTableView.hidden = YES;
    }];
}

- (BOOL)isExpanded {
    return self.searchTextFieldConstraintTop.constant == ASCViewTextFieldExpandedOffsetY;
}

- (void)updateConstraints {
    [super updateConstraints];
    
    if (![self isExpanded]) {
        self.searchTextFieldConstraintTop.constant = self.bounds.size.height * ASCViewTextFieldContractedMultiplierOffsetY;
        self.searchTextFieldConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldContractedMultiplierWidth;
        self.searchTableViewConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldContractedMultiplierWidth;
    } else {
        self.searchTextFieldConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth;
        self.searchTableViewConstraintWidth.constant = self.bounds.size.width * ASCViewTextFieldExpandedMultiplierWidth;
    }
}

- (void)hideSearchTableViewAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [self layoutIfNeeded];
    self.searchTableViewConstraintHeight.constant = 0;
    
    __weak ASCView *weakSelf = self;
    void (^animations)(void) = ^void(void) {
        [weakSelf layoutIfNeeded];
    };
    
    if (animated) {
        [UIView animateWithDuration:ASCViewAnimationDuration animations:animations completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    } else {
        animations();
        
        if (completion) {
            completion();
        }
    }
}

@end
