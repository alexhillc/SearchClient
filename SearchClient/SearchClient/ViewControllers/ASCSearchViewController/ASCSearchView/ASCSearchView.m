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
@property UIView *sSearchTableView;

@property (nonatomic, weak) NSLayoutConstraint *searchTextFieldConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *searchTextFieldConstraintHeight;
@property (nonatomic, weak) NSLayoutConstraint *searchTextFieldConstraintWidth;
@property (nonatomic, weak) NSLayoutConstraint *searchTextFieldConstraintCenter;
@property (nonatomic, weak) NSLayoutConstraint *tableViewConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *tableViewConstraintHeight;
@property (nonatomic, weak) NSLayoutConstraint *tableViewConstraintWidth;
@property (nonatomic, weak) NSLayoutConstraint *tableViewConstraintCenter;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelSecondaryConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelSecondaryConstraintCenter;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelPrimaryConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *titleLabelPrimaryConstraintCenter;

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
    
    self.sSearchTableView = [[UIView alloc] init];
    self.sSearchTableView.backgroundColor = [UIColor whiteColor];
    self.sSearchTableView.alpha = 0;
    self.sSearchTableView.hidden = YES;
    self.sSearchTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.sSearchTableView.clipsToBounds = NO;
    self.sSearchTableView.layer.cornerRadius = 1.5;
    self.sSearchTableView.layer.masksToBounds = NO;
    self.sSearchTableView.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.sSearchTableView.layer.shadowRadius = 1.;
    self.sSearchTableView.layer.shadowOpacity = 0.08;
    
    [self insertSubview:self.sSearchTableView belowSubview:self.searchTableView];
    
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
                                 constant:self.bounds.size.height * ASCSearchTextFieldContractedMultiplierOffsetY];
        self.searchTextFieldConstraintHeight = [self.searchTextField asc_setAttribute:NSLayoutAttributeHeight toConstant:ASCSearchTextFieldHeight];
        self.searchTextFieldConstraintWidth = [self.searchTextField asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCSearchTextFieldContractedMultiplierWidth];
        self.searchTextFieldConstraintCenter = [self.searchTextField asc_centerHorizontallyInParent];
        
        // tableView constraints
        self.tableViewConstraintTop = [self.searchTableView asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom
                                                        ofSibling:self.searchTextField constant:5.];
        self.tableViewConstraintHeight = [self.searchTableView asc_setAttribute:NSLayoutAttributeHeight toConstant:ASCSearchTextFieldHeight];
        self.tableViewConstraintWidth = [self.searchTableView asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCSearchTextFieldContractedMultiplierWidth];
        self.tableViewConstraintCenter = [self.searchTableView asc_centerHorizontallyInParent];
        
        // sSearchTableView constraints
        [self.sSearchTableView asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.searchTableView constant:0];
        [self.sSearchTableView asc_pinEdge:NSLayoutAttributeLeft toEdge:NSLayoutAttributeLeft ofSibling:self.searchTableView constant:0];
        [self.sSearchTableView asc_pinEdge:NSLayoutAttributeRight toEdge:NSLayoutAttributeRight ofSibling:self.searchTableView constant:0];
        [self.sSearchTableView asc_pinEdge:NSLayoutAttributeBottom toEdge:NSLayoutAttributeBottom ofSibling:self.searchTableView constant:0];
        
        // titleLabelSecondary constraints
        self.titleLabelSecondaryConstraintTop = [self.titleLabelSecondary asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.searchTextField constant:-40.];
        self.titleLabelSecondaryConstraintCenter = [self.titleLabelSecondary asc_centerHorizontallyInParent];
        
        // titleLabelPrimary constraints
        self.titleLabelPrimaryConstraintTop = [self.titleLabelPrimary asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofSibling:self.titleLabelSecondary constant:-53.];
        self.titleLabelPrimaryConstraintCenter = [self.titleLabelPrimary asc_centerHorizontallyInParent];
        
        self.isFirstLayout = NO;
    } 
}

- (void)updateConstraints {
    [super updateConstraints];
    
    if (![self isSearching]) {
        self.searchTextFieldConstraintTop.constant = self.bounds.size.height * ASCSearchTextFieldContractedMultiplierOffsetY;
        self.searchTextFieldConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldContractedMultiplierWidth;
        self.tableViewConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
    } else {
        self.searchTextFieldConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
        self.tableViewConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
    }
}

#pragma mark - Helper methods
- (void)expandToKeyboardHeight:(CGFloat)keyboardHeight {
    [self layoutIfNeeded];

    self.searchTextFieldConstraintTop.constant = ASCSearchTextFieldExpandedOffsetY;
    self.searchTextFieldConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
    self.tableViewConstraintHeight.constant = self.bounds.size.height - keyboardHeight - ASCTableViewExpandedOffsetY - 10.0;
    self.tableViewConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
    
    __weak ASCSearchView *weakSelf = self;
    
    [UIView animateWithDuration:ASCSearchViewAnimationDuration animations:^{
        weakSelf.searchTableView.hidden = NO;
        weakSelf.searchTableView.alpha = 1;
        
        weakSelf.sSearchTableView.hidden = NO;
        weakSelf.sSearchTableView.alpha = 1;
        
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
        weakSelf.sSearchTableView.alpha = 0;
        
        weakSelf.titleLabelSecondary.hidden = NO;
        weakSelf.titleLabelPrimary.hidden = NO;
        
        weakSelf.searchTextFieldConstraintTop.constant = weakSelf.bounds.size.height * ASCSearchTextFieldContractedMultiplierOffsetY;
        weakSelf.searchTextFieldConstraintWidth.constant = weakSelf.bounds.size.width * ASCSearchTextFieldContractedMultiplierWidth;
        weakSelf.tableViewConstraintHeight.constant = weakSelf.searchTextFieldConstraintHeight.constant;
        weakSelf.tableViewConstraintWidth.constant = weakSelf.bounds.size.width * ASCSearchTextFieldContractedMultiplierWidth;
        [weakSelf layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        weakSelf.searchTableView.hidden = YES;
        weakSelf.sSearchTableView.hidden = YES;
    }];
}

- (BOOL)isSearching {
    return self.searchTextFieldConstraintTop.constant == ASCSearchTextFieldExpandedOffsetY;
}

@end
