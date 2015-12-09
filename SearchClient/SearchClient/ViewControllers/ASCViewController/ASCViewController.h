//
//  ASCViewController.h
//  SearchClient
//
//  Created by Alex Hill on 10/27/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASCSearchHistoryViewModel.h"
#import "ASCSearchHistoryTableViewDelegateAndDatasource.h"
#import "ASCTextField.h"

@class ASCSearchHistoryTableViewDelegateAndDatasource, ASCView;

@interface ASCViewController : UIViewController <ASCViewModelDelegate, ASCTextFieldDelegate>

@property (nonatomic, strong) ASCView *ascView;
@property (nonatomic, strong) ASCSearchHistoryViewModel *searchHistoryViewModel;
@property (nonatomic) ASCSearchHistoryTableViewDelegateAndDatasource *searchHistoryTableViewDD;
@property (nonatomic, strong) NSMutableDictionary *cachedCollectionViewCellWidths;
@property (nonatomic, strong) UIView *presentedViewControllerSnapshotView;

/**
 * @brief Presents a new ASCSearchResultsViewController transparently 
 *        to the user with the specified query
 */
- (void)presentViewControllerWithQuery:(NSString *)query;

@end
