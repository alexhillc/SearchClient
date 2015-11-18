//
//  ASCSearchView.m
//  SearchClient
//
//  Created by Alex Hill on 10/19/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchView.h"
#import "ASCTextField.h"
#import "ASCTableView.h"
#import "DRPLoadingSpinner.h"
#import <QuartzCore/QuartzCore.h>

#define GoogleBlue [UIColor colorWithRed:72.0/255.0 green:133.0/255.0 blue:237.0/255.0 alpha:1.0]
#define GoogleGreen [UIColor colorWithRed:53.0/255.0 green:168.0/255.0 blue:83.0/255.0 alpha:1.0]
#define GoogleYellow [UIColor colorWithRed:251.0/255.0 green:188.0/255.0 blue:5.0/255.0 alpha:1.0]
#define GoogleRed [UIColor colorWithRed:254.0/255.0 green:67.0/255.0 blue:53.0/255.0 alpha:1.0]

#define ASCSearchViewBackgroundColor [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]

CGFloat const ASCSearchTextFieldHeight = 40.0;
CGFloat const ASCTableViewExpandedOffsetY = 69.0;
CGFloat const ASCSearchTextFieldExpandedOffsetY = 24.0;
CGFloat const ASCSearchTextFieldContractedMultiplierOffsetY = 0.48;
CGFloat const ASCSearchTextFieldContractedMultiplierWidth = 0.75;
CGFloat const ASCSearchTextFieldExpandedMultiplierWidth = 0.95;
NSTimeInterval const ASCSearchViewAnimationDuration = 0.25;

@interface ASCSearchView()

@property (nonatomic, assign) BOOL isFirstLayout;
@property DRPLoadingSpinner *loadingSpinner;

@property (nonatomic, weak) NSLayoutConstraint *searchTextFieldConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *searchTextFieldConstraintHeight;
@property (nonatomic, weak) NSLayoutConstraint *searchTextFieldConstraintWidth;
@property (nonatomic, weak) NSLayoutConstraint *searchTextFieldConstraintCenter;
@property (nonatomic, weak) NSLayoutConstraint *searchTableViewConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *searchTableViewConstraintHeight;
@property (nonatomic, weak) NSLayoutConstraint *searchTableViewConstraintWidth;
@property (nonatomic, weak) NSLayoutConstraint *searchTableViewConstraintCenter;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelSecondaryConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelSecondaryConstraintCenter;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelPrimaryConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelPrimaryConstraintCenter;
@property (nonatomic, weak) NSLayoutConstraint *searchResultsTableViewConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *searchResultsTableViewConstraintBottom;
@property (nonatomic, weak) NSLayoutConstraint *searchResultsTableViewConstraintWidth;
@property (nonatomic, weak) NSLayoutConstraint *searchResultsTableViewConstraintCenter;

@end

@implementation ASCSearchView

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.isFirstLayout = YES;
    
    self.backgroundColor = ASCSearchViewBackgroundColor;
    
    self.searchTextField = [[ASCTextField alloc] init];
    self.searchTextField.horizontalPadding = 10.0;
    self.searchTextField.cancelButtonColor = [UIColor darkGrayColor];
    self.searchTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.searchTextField];
    
    self.searchTableView = [[ASCTableView alloc] init];
    self.searchTableView.alpha = 0;
    self.searchTableView.hidden = YES;
    self.searchTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.searchTableView];
    
    self.shadowSearchTableView = [[UIView alloc] init];
    self.shadowSearchTableView.backgroundColor = [UIColor whiteColor];
    self.shadowSearchTableView.alpha = 0;
    self.shadowSearchTableView.hidden = YES;
    self.shadowSearchTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.shadowSearchTableView.clipsToBounds = NO;
    self.shadowSearchTableView.layer.cornerRadius = 1.5;
    self.shadowSearchTableView.layer.masksToBounds = NO;
    self.shadowSearchTableView.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.shadowSearchTableView.layer.shadowRadius = 1.;
    self.shadowSearchTableView.layer.shadowOpacity = 0.08;
    
    [self insertSubview:self.shadowSearchTableView belowSubview:self.searchTableView];
    
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
    
    self.searchResultsTableView = [[ASCTableView alloc] init];
    self.searchResultsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchResultsTableView.backgroundColor = [UIColor clearColor];
    self.searchResultsTableView.hidden = YES;
    
    [self addSubview:self.searchResultsTableView];
    
    self.loadingSpinner = [[DRPLoadingSpinner alloc] init];
    self.loadingSpinner.translatesAutoresizingMaskIntoConstraints = NO;
    self.loadingSpinner.hidden = YES;
    
    [self addSubview:self.loadingSpinner];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isFirstLayout) {
        // searchTextField constraints
        self.searchTextFieldConstraintTop = [self.searchTextField asc_pinEdge:NSLayoutAttributeTop toParentEdge:NSLayoutAttributeTop
                                 constant:self.bounds.size.height * ASCSearchTextFieldContractedMultiplierOffsetY];
        self.searchTextFieldConstraintHeight = [self.searchTextField asc_setAttribute:NSLayoutAttributeHeight toConstant:ASCSearchTextFieldHeight];
        self.searchTextFieldConstraintWidth = [self.searchTextField asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCSearchTextFieldContractedMultiplierWidth];
        self.searchTextFieldConstraintCenter = [self.searchTextField asc_centerHorizontallyInParent];
        
        // searchTableView constraints
        self.searchTableViewConstraintTop = [self.searchTableView asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom
                                                        ofSibling:self.searchTextField constant:5.];
        self.searchTableViewConstraintHeight = [self.searchTableView asc_setAttribute:NSLayoutAttributeHeight toConstant:ASCSearchTextFieldHeight];
        self.searchTableViewConstraintWidth = [self.searchTableView asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCSearchTextFieldContractedMultiplierWidth];
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
        
        // searchResultsTableView constraints
        self.searchResultsTableViewConstraintTop = [self.searchResultsTableView asc_pinEdge:NSLayoutAttributeTop toParentEdge:NSLayoutAttributeTop
                                                                                   constant:ASCSearchTextFieldExpandedOffsetY + ASCSearchTextFieldHeight + 5.];
        self.searchResultsTableViewConstraintBottom = [self.searchResultsTableView asc_pinEdge:NSLayoutAttributeBottom toParentEdge:NSLayoutAttributeBottom
                                                                                      constant:-5.];
        self.searchResultsTableViewConstraintWidth = [self.searchResultsTableView asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth];
        self.searchResultsTableViewConstraintCenter = [self.searchResultsTableView asc_centerHorizontallyInParent];
        
        [self.loadingSpinner asc_setAttribute:NSLayoutAttributeHeight toConstant:self.loadingSpinner.intrinsicContentSize.height];
        [self.loadingSpinner asc_setAttribute:NSLayoutAttributeWidth toConstant:self.loadingSpinner.intrinsicContentSize.width];
        [self.loadingSpinner asc_pinEdge:NSLayoutAttributeCenterX toEdge:NSLayoutAttributeCenterX ofSibling:self.searchResultsTableView constant:0.];
        [self.loadingSpinner asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.searchResultsTableView constant:30.];
        
        self.isFirstLayout = NO;
    } 
}

- (void)updateConstraints {
    [super updateConstraints];
    
    if (![self isExpanded]) {
        self.searchTextFieldConstraintTop.constant = self.bounds.size.height * ASCSearchTextFieldContractedMultiplierOffsetY;
        self.searchTextFieldConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldContractedMultiplierWidth;
        self.searchTableViewConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
    } else {
        self.searchTextFieldConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
        self.searchTableViewConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
    }
}

#pragma mark - Helper methods
- (void)expandToKeyboardHeight:(CGFloat)keyboardHeight {
    [self layoutIfNeeded];

    self.searchTextFieldConstraintTop.constant = ASCSearchTextFieldExpandedOffsetY;
    self.searchTextFieldConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
    self.searchTableViewConstraintHeight.constant = self.bounds.size.height - keyboardHeight - ASCTableViewExpandedOffsetY - 10.0;
    self.searchTableViewConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
    
    __weak ASCSearchView *weakSelf = self;
    
    [UIView animateWithDuration:ASCSearchViewAnimationDuration animations:^{
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
    [UIView animateWithDuration:ASCSearchViewAnimationDuration animations:^{
        weakSelf.searchTableView.alpha = 0;
        weakSelf.shadowSearchTableView.alpha = 0;
        
        weakSelf.titleLabelSecondary.hidden = NO;
        weakSelf.titleLabelPrimary.hidden = NO;
        
        weakSelf.searchTextFieldConstraintTop.constant = weakSelf.bounds.size.height * ASCSearchTextFieldContractedMultiplierOffsetY;
        weakSelf.searchTextFieldConstraintWidth.constant = weakSelf.bounds.size.width * ASCSearchTextFieldContractedMultiplierWidth;
        weakSelf.searchTableViewConstraintHeight.constant = weakSelf.searchTextFieldConstraintHeight.constant;
        weakSelf.searchTableViewConstraintWidth.constant = weakSelf.bounds.size.width * ASCSearchTextFieldContractedMultiplierWidth;
        [weakSelf layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        weakSelf.searchTableView.hidden = YES;
        weakSelf.shadowSearchTableView.hidden = YES;
    }];
}

- (void)startLoadingAnimation {
    self.searchResultsTableView.hidden = YES;
    self.loadingSpinner.hidden = NO;
    [self.loadingSpinner startAnimating];
}

- (void)stopLoadingAnimation {
    [self.loadingSpinner stopAnimating];
    self.loadingSpinner.hidden = YES;
    self.searchResultsTableView.hidden = NO;
}

- (BOOL)isExpanded {
    return self.searchTextFieldConstraintTop.constant == ASCSearchTextFieldExpandedOffsetY;
}

- (BOOL)isDisplayingResults {
    return !self.searchResultsTableView.hidden || !self.loadingSpinner.hidden;
}

@end
