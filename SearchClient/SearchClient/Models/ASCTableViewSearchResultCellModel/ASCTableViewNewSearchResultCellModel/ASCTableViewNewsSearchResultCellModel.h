//
//  ASCTableViewNewsSearchResultCellModel.h
//  SearchClient
//
//  Created by Alex Hill on 12/5/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewSearchResultCellModel.h"

@interface ASCTableViewNewsSearchResultCellModel : ASCTableViewSearchResultCellModel

@property (nonatomic, copy) NSString *publishedDateLabelText;
@property (nonatomic, copy) NSString *publisherLabelText;

@end
