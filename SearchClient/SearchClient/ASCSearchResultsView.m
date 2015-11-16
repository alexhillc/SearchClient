//
//  ASCSearchResultsView.m
//  SearchClient
//
//  Created by Alex Hill on 11/14/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchResultsView.h"
#import "ASCTableView.h"

#define ASCSearchViewBackgroundColor [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0]

@interface ASCSearchResultsView()

@property (nonatomic, assign) BOOL isFirstLayout;

@property (nonatomic, weak) NSLayoutConstraint *searchResultsTableViewConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *searchResultsTableViewConstraintLeft;
@property (nonatomic, weak) NSLayoutConstraint *searchResultsTableViewConstraintRight;
@property (nonatomic, weak) NSLayoutConstraint *searchResultsTableViewConstraintBottom;

@end

@implementation ASCSearchResultsView

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.isFirstLayout = YES;
    
    self.backgroundColor = ASCSearchViewBackgroundColor;
    
    self.tableView = [[ASCTableView alloc] init];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.tableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isFirstLayout) {
        // searchResultsTableView constraints
        self.searchResultsTableViewConstraintTop = [self.tableView asc_pinEdge:NSLayoutAttributeTop toParentEdge:NSLayoutAttributeTop constant:10.];
        self.searchResultsTableViewConstraintLeft = [self.tableView asc_pinEdge:NSLayoutAttributeLeft toParentEdge:NSLayoutAttributeLeft constant:10.];
        self.searchResultsTableViewConstraintRight = [self.tableView asc_pinEdge:NSLayoutAttributeRight toParentEdge:NSLayoutAttributeRight constant:-10.];
        self.searchResultsTableViewConstraintRight = [self.tableView asc_pinEdge:NSLayoutAttributeBottom toParentEdge:NSLayoutAttributeBottom constant:-10.];

        self.isFirstLayout = NO;
    }
}

@end
