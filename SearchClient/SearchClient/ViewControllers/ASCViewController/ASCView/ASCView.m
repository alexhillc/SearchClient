//
//  ASCView.m
//  SearchClient
//
//  Created by Alex Hill on 11/21/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCView.h"

#define ASCViewBackgroundColor [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0]

CGFloat const ASCViewTextFieldHeight = 40.0;
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
    
    self.searchTableView = [[ASCTableView alloc] init];
    self.searchTableView.hidden = YES;
    self.searchTableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    self.searchTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.searchTableView];
    
    self.shadowSearchTableView = [[UIView alloc] init];
    self.shadowSearchTableView.backgroundColor = [UIColor whiteColor];
    self.shadowSearchTableView.hidden = YES;
    self.shadowSearchTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.shadowSearchTableView.clipsToBounds = NO;
    self.shadowSearchTableView.layer.cornerRadius = 1.5;
    self.shadowSearchTableView.layer.masksToBounds = NO;
    self.shadowSearchTableView.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.shadowSearchTableView.layer.shadowRadius = 1.;
    self.shadowSearchTableView.layer.shadowOpacity = 0.08;
    
    [self insertSubview:self.shadowSearchTableView belowSubview:self.searchTableView];
}

- (BOOL)isExpanded {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return nil;
}

- (void)contract {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void)expandToKeyboardHeight:(CGFloat)keyboardHeight {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

@end
