//
//  ASCTableViewImageSearchResultsCell.h
//  SearchClient
//
//  Created by Alex Hill on 11/28/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewSearchResultCell.h"
#import "ASCImageSearchResultModel.h"

extern NSString * const ASCTableViewImageSearchResultCellIdentifier;

@class ASCAsyncImageView;

@interface ASCTableViewImageSearchResultCell : ASCTableViewSearchResultCell

@property (nonatomic) ASCImageSearchResultModel *cellModel;

@end
