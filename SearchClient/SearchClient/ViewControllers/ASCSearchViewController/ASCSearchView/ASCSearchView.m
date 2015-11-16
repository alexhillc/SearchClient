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

const CGFloat ASCSearchTextFieldHeight = 40.0;
const CGFloat ASCTableViewExpandedOffsetY = 69.0;
const CGFloat ASCSearchTextFieldExpandedOffsetY = 24.0;
const CGFloat ASCSearchTextFieldContractedMultiplierOffsetY = 0.48;
const CGFloat ASCSearchTextFieldContractedMultiplierWidth = 0.75;
const CGFloat ASCSearchTextFieldExpandedMultiplierWidth = 0.95;
const NSTimeInterval ASCSearchViewAnimationDuration = 0.2;

@interface ASCSearchView()

@property (nonatomic, assign) ASCSearchViewSearchState state;
@property (nonatomic, assign) BOOL isFirstLayout;
@property UIView *sTableView;

@property (nonatomic, weak) NSLayoutConstraint *searchTextFieldConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *searchTextFieldConstraintHeight;
@property (nonatomic, weak) NSLayoutConstraint *searchTextFieldConstraintWidth;
@property (nonatomic, weak) NSLayoutConstraint *searchTextFieldConstraintCenter;
@property (nonatomic, weak) NSLayoutConstraint *tableViewConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *tableViewConstraintHeight;
@property (nonatomic, weak) NSLayoutConstraint *tableViewConstraintWidth;
@property (nonatomic, weak) NSLayoutConstraint *tableViewConstraintCenter;
@property (nonatomic, weak) NSLayoutConstraint *sTableViewConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *sTableViewConstraintHeight;
@property (nonatomic, weak) NSLayoutConstraint *sTableViewConstraintWidth;
@property (nonatomic, weak) NSLayoutConstraint *sTableViewConstraintCenter;
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
    
    self.tableView = [[ASCTableView alloc] init];
    self.tableView.alpha = 0;
    self.tableView.hidden = YES;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.tableView];
    
    self.sTableView = [[UIView alloc] init];
    self.sTableView.backgroundColor = [UIColor whiteColor];
    self.sTableView.alpha = 0;
    self.sTableView.hidden = YES;
    self.sTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.sTableView.clipsToBounds = NO;
    self.sTableView.layer.cornerRadius = 1.5;
    self.sTableView.layer.masksToBounds = NO;
    self.sTableView.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.sTableView.layer.shadowRadius = 1.;
    self.sTableView.layer.shadowOpacity = 0.08;
    
    [self insertSubview:self.sTableView belowSubview:self.tableView];
    
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
        self.tableViewConstraintTop = [self.tableView asc_pinEdge:NSLayoutAttributeTop toParentEdge:NSLayoutAttributeTop constant:ASCTableViewExpandedOffsetY];
        self.tableViewConstraintHeight = [self.tableView asc_setAttribute:NSLayoutAttributeHeight toConstant:self.bounds.size.height * 0.35];
        self.tableViewConstraintWidth = [self.tableView asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth];
        self.tableViewConstraintCenter = [self.tableView asc_centerHorizontallyInParent];
        
        // sTableView constraints
        self.sTableViewConstraintTop = [self.sTableView asc_pinEdge:NSLayoutAttributeTop toParentEdge:NSLayoutAttributeTop constant:ASCTableViewExpandedOffsetY];
        self.sTableViewConstraintHeight = [self.sTableView asc_setAttribute:NSLayoutAttributeHeight toConstant:self.bounds.size.height * 0.35];
        self.sTableViewConstraintWidth = [self.sTableView asc_setAttribute:NSLayoutAttributeWidth toConstant:self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth];
        self.sTableViewConstraintCenter = [self.sTableView asc_centerHorizontallyInParent];
        
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
    
    // Update constraints based on search state
    if (self.state == ASCSearchViewSearchStateInactive) {
        self.searchTextFieldConstraintTop.constant = self.bounds.size.height * ASCSearchTextFieldContractedMultiplierOffsetY;
        self.searchTextFieldConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldContractedMultiplierWidth;
        self.tableViewConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
        self.sTableViewConstraintWidth.constant = self.tableViewConstraintWidth.constant;
    } else {
        self.searchTextFieldConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
        self.tableViewConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
        self.sTableViewConstraintWidth.constant = self.tableViewConstraintWidth.constant;
    }
}

#pragma mark - Helper methods
- (void)expandToKeyboardHeight:(CGFloat)keyboardHeight {
    self.state = ASCSearchViewSearchStateActive;

    [self layoutIfNeeded];

    self.searchTextFieldConstraintTop.constant = ASCSearchTextFieldExpandedOffsetY;
    self.searchTextFieldConstraintWidth.constant = self.bounds.size.width * ASCSearchTextFieldExpandedMultiplierWidth;
    self.tableViewConstraintHeight.constant = self.bounds.size.height - keyboardHeight - ASCTableViewExpandedOffsetY - 10.0;
    self.sTableViewConstraintHeight.constant = self.tableViewConstraintHeight.constant;
    
    __weak ASCSearchView *weakSelf = self;
    
    [UIView animateWithDuration:ASCSearchViewAnimationDuration animations:^{
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        weakSelf.titleLabelSecondary.hidden = YES;
        weakSelf.titleLabelPrimary.hidden = YES;
        
        [UIView animateWithDuration:ASCSearchViewAnimationDuration animations:^{
            weakSelf.tableView.hidden = NO;
            weakSelf.tableView.alpha = 1;
            
            weakSelf.sTableView.hidden = NO;
            weakSelf.sTableView.alpha = 1;
        }];
    }];
}

- (void)contract {
    self.state = ASCSearchViewSearchStateInactive;
    
    __weak ASCSearchView *weakSelf = self;
    [UIView animateWithDuration:ASCSearchViewAnimationDuration animations:^{
        weakSelf.tableView.alpha = 0;
        weakSelf.sTableView.alpha = 0;
    } completion:^(BOOL finished) {
        weakSelf.tableView.hidden = YES;
        weakSelf.sTableView.hidden = YES;
        
        weakSelf.titleLabelSecondary.hidden = NO;
        weakSelf.titleLabelPrimary.hidden = NO;
        
        [weakSelf layoutIfNeeded];
        
        weakSelf.searchTextFieldConstraintTop.constant = weakSelf.bounds.size.height * ASCSearchTextFieldContractedMultiplierOffsetY;
        weakSelf.searchTextFieldConstraintWidth.constant = weakSelf.bounds.size.width * ASCSearchTextFieldContractedMultiplierWidth;
        
        [UIView animateWithDuration:ASCSearchViewAnimationDuration animations:^{
            [weakSelf layoutIfNeeded];
        }];
    }];
}

@end
