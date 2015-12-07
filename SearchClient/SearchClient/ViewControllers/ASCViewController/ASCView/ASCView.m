//
//  ASCView.m
//  SearchClient
//
//  Created by Alex Hill on 11/21/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCView.h"

CGFloat const ASCViewTableViewExpandedOffsetY = 69.0;
CGFloat const ASCViewTextFieldExpandedOffsetY = 24.0;
CGFloat const ASCViewTextFieldContractedMultiplierOffsetY = 0.48;
CGFloat const ASCViewTextFieldContractedMultiplierWidth = 0.75;
CGFloat const ASCViewTextFieldExpandedMultiplierWidth = 0.97;
NSTimeInterval const ASCViewAnimationDuration = 0.25;

@implementation ASCView

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.isFirstLayout = YES;
    
    self.backgroundColor = ASCViewBackgroundColor;
    
    self.searchBar = [[ASCSearchBar alloc] init];
    self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.searchBar];
    
    self.shadowSearchBar = [[UIView alloc] init];
    self.shadowSearchBar.backgroundColor = [UIColor whiteColor];
    self.shadowSearchBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.shadowSearchBar.clipsToBounds = NO;
    self.shadowSearchBar.layer.cornerRadius = 1.5;
    self.shadowSearchBar.layer.masksToBounds = NO;
    self.shadowSearchBar.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.shadowSearchBar.layer.shadowRadius = 1.;
    self.shadowSearchBar.layer.shadowOpacity = 0.08;

    [self insertSubview:self.shadowSearchBar belowSubview:self.searchBar];
    
    self.searchHistoryTableView = [[ASCTableView alloc] init];
    self.searchHistoryTableView.hidden = YES;
    self.searchHistoryTableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    self.searchHistoryTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.searchHistoryTableView];
    
    self.shadowSearchHistoryTableView = [[UIView alloc] init];
    self.shadowSearchHistoryTableView.backgroundColor = [UIColor whiteColor];
    self.shadowSearchHistoryTableView.hidden = YES;
    self.shadowSearchHistoryTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.shadowSearchHistoryTableView.clipsToBounds = NO;
    self.shadowSearchHistoryTableView.layer.cornerRadius = 1.5;
    self.shadowSearchHistoryTableView.layer.masksToBounds = NO;
    self.shadowSearchHistoryTableView.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.shadowSearchHistoryTableView.layer.shadowRadius = 1.;
    self.shadowSearchHistoryTableView.layer.shadowOpacity = 0.08;
    
    [self insertSubview:self.shadowSearchHistoryTableView belowSubview:self.searchHistoryTableView];
}

- (BOOL)isExpanded {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return NO;
}

- (void)contract {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void)expandToHeight:(CGFloat)height completion:(void (^)(void))completion {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

@end
