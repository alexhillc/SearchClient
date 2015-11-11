//
//  ASCViewModel.h
//  SearchClient
//
//  Created by Alex Hill on 10/27/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASCSearchResultsViewModel : NSObject

@property (nonatomic, strong) NSArray *resultsData;

- (void)loadResultsForQuery:(NSString *)query;

@end
