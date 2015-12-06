//
//  ASCTableViewWebSearchResultCell.h
//  SearchClient
//
//  Created by Alex Hill on 11/28/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewSearchResultCell.h"
#import "ASCTableViewWebSearchResultCellModel.h"

extern NSString * const ASCTableViewWebSearchResultCellIdentifier;

@interface ASCTableViewWebSearchResultCell : ASCTableViewSearchResultCell

@property (nonatomic) ASCTableViewWebSearchResultCellModel *cellModel;

@end
