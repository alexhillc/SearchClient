//
//  ASCSearchResultsTableViewDelegate.h
//  SearchClient
//
//  Created by Alex Hill on 11/17/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASCSearchResultsViewController;

@interface ASCSearchResultsTableViewDelegateAndDatasource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) ASCSearchResultsViewController *vc;

@end
