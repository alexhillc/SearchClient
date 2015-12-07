//
//  ASCTableViewVideoSearchResultCell.h
//  SearchClient
//
//  Created by Alex Hill on 12/6/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewSearchResultCell.h"
#import "ASCTableViewVideoSearchResultCellModel.h"

extern NSString * const ASCTableViewVideoSearchResultCellIdentifier;

@interface ASCTableViewVideoSearchResultCell : ASCTableViewSearchResultCell

@property (nonatomic) ASCTableViewVideoSearchResultCellModel *cellModel;
@property (strong) UILabel *runtimeLabel;

@end
