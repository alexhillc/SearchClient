//
//  ASCSearchResultsTableViewDelegate.h
//  SearchClient
//
//  Created by Alex Hill on 11/17/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASCSearchResultsTableViewDelegateAndDatasource;

@protocol ASCSearchResultsTableViewDDDelegate <NSObject>

- (void)ddDelegate:(ASCSearchResultsTableViewDelegateAndDatasource *)ddDelegate didSelectUrl:(NSURL *)url;

@end

@class ASCSearchResultsViewModel;

@interface ASCSearchResultsTableViewDelegateAndDatasource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ASCSearchResultsViewModel *viewModel;
@property (nonatomic, weak) id<ASCSearchResultsTableViewDDDelegate> delegate;

@end
