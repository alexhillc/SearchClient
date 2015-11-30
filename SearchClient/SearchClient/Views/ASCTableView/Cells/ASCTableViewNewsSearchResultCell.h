//
//  ASCTableViewNewsSearchResultCell.h
//  SearchClient
//
//  Created by Alex Hill on 11/29/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewSearchResultCell.h"
#import "ASCNewsSearchResultModel.h"

@class ASCAsyncImageView;

@interface ASCTableViewNewsSearchResultCell : ASCTableViewSearchResultCell

@property (nonatomic) ASCNewsSearchResultModel *cellModel;
@property ASCAsyncImageView *asyncImageView;

@end
