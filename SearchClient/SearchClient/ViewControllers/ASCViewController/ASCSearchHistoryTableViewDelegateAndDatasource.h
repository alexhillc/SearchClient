//
//  ASCSearchTableViewDelegate.h
//  SearchClient
//
//  Created by Alex Hill on 11/17/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASCViewController;

@interface ASCSearchHistoryTableViewDelegateAndDatasource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) ASCViewController *vc;

@end
