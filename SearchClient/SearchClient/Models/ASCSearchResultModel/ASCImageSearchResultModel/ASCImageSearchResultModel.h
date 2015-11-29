//
//  ASCImageSearchResultModel.h
//  SearchClient
//
//  Created by Alex Hill on 11/16/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchResultModel.h"

@interface ASCImageSearchResultModel : ASCSearchResultModel

@property (nonatomic) CGSize thumbSize;
@property (nonatomic) CGSize size;
@property (nonatomic, strong) NSURL *thumbUrl;
@property (nonatomic, strong) NSURL *contextUrl;

@end
