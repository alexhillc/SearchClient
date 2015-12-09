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

#define ASCViewBackgroundColor [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0]

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
@property (nonatomic, weak) NSLayoutConstraint *searchHistoryTableViewConstraintTop;
@property (nonatomic, weak) NSLayoutConstraint *searchHistoryTableViewConstraintHeight;
@property (nonatomic, weak) NSLayoutConstraint *searchHistoryTableViewConstraintWidth;
@property (nonatomic, weak) NSLayoutConstraint *searchHistoryTableViewConstraintCenter;

@property (nonatomic, assign) BOOL isFirstLayout;

@property ASCSearchBar *searchBar;
@property UIView *shadowSearchBar;
@property ASCTableView *searchHistoryTableView;
@property UIView *shadowSearchHistoryTableView;

- (void)setup;
- (void)updateLayoutWithOrientation:(CGSize)screenSize;

/**
 * @brief Hides the search history table view, adjusts constraints so that the searchbar's collection view
 *        is shown transparently to the user
 */
- (void)hideSearchHistoryTableViewAnimated:(BOOL)animated completion:(void (^)(void))completion;

/**
 * @brief Expands the search bar and search history table view to a height specified by the height
 */
- (void)expandToHeight:(CGFloat)height completion:(void (^)(void))completion;

/**
 * @brief Contracts the search bar and search history table view to the default value
 */
- (void)contract;

/**
 * @brief Uses values specific to the view to determine if the view is expanded or not
 */
- (BOOL)isExpanded;

@end
