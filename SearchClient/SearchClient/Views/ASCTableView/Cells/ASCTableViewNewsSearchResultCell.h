//
//  ASCTableViewNewsSearchResultCell.h
//  SearchClient
//
//  Created by Alex Hill on 11/29/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewSearchResultCell.h"
#import "ASCTableViewNewsSearchResultCellModel.h"

extern NSString * const ASCTableViewNewsSearchResultCellIdentifier;

@class ASCAsyncImageView;

@interface ASCTableViewNewsSearchResultCell : ASCTableViewSearchResultCell

@property (nonatomic) ASCTableViewNewsSearchResultCellModel *cellModel;
@property (strong) UILabel *publishedDateLabel;
@property (strong) UILabel *publisherLabel;

@end
