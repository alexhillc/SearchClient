//
//  ASCTableViewSpellSearchResultCell.h
//  SearchClient
//
//  Created by Alex Hill on 12/6/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewSearchResultCell.h"
#import "ASCTableViewSpellSearchResultCellModel.h"

extern NSString * const ASCTableViewSpellSearchResultCellIdentifier;

@interface ASCTableViewSpellSearchResultCell : ASCTableViewSearchResultCell

@property (nonatomic) ASCTableViewSpellSearchResultCellModel *cellModel;
@property (strong) UILabel *suggestedSpellingLabel;

@end
