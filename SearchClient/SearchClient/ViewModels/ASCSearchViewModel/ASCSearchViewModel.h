//
//  ASCSearchViewModel.h
//  SearchClient
//
//  Created by Alex Hill on 11/17/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASCViewModel.h"

@interface ASCSearchViewModel : ASCViewModel

@property (nonatomic, strong) NSArray *searchHistoryData;

- (void)loadSearchHistory;

@end
