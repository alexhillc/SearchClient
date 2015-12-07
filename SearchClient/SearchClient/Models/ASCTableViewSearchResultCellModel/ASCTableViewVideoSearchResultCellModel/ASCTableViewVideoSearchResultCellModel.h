//
//  ASCTableViewVideoSearchResultCellModel.h
//  SearchClient
//
//  Created by Alex Hill on 12/6/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewSearchResultCellModel.h"

@interface ASCTableViewVideoSearchResultCellModel : ASCTableViewSearchResultCellModel

@property (nonatomic) CGSize thumbSize;
@property (nonatomic, strong) NSURL *thumbImgUrl;
@property (nonatomic, copy) NSString *runtimeLabelText;

@end
