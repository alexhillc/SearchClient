//
//  ASCSearchViewModel.h
//  SearchClient
//
//  Created by Alex Hill on 11/17/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASCViewModel.h"

@interface ASCSearchHistoryViewModel : ASCViewModel

/**
 * @brief Load search history from system cache
 */
- (void)loadSearchHistory;

@end
