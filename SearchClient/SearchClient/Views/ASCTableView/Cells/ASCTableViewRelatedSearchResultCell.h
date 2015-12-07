//
//  ASCTableViewrelatedSearchResultCell.h
//  SearchClient
//
//  Created by Alex Hill on 12/6/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewSearchResultCell.h"
#import "ASCTableViewRelatedSearchResultCellModel.h"

extern NSString * const ASCTableViewRelatedSearchResultCellIdentifier;

@interface ASCTableViewRelatedSearchResultCell : ASCTableViewSearchResultCell

@property (nonatomic) ASCTableViewRelatedSearchResultCellModel *cellModel;

@end
