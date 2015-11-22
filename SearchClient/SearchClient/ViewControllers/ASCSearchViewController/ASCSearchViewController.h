//
//  ASCSearchViewController.h
//  SearchClient
//
//  Created by Alex Hill on 10/21/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASCViewController.h"

@class ASCSearchView, ASCSearchViewModel, ASCSearchTableViewDelegateAndDatasource;

@interface ASCSearchViewController : ASCViewController

@property (nonatomic, strong) ASCSearchViewModel *searchViewModel;
@property (nonatomic) ASCSearchTableViewDelegateAndDatasource *searchTableViewDD;
@property (weak) ASCSearchView *searchView;

- (void)presentViewControllerWithQuery:(NSString *)query;

@end
