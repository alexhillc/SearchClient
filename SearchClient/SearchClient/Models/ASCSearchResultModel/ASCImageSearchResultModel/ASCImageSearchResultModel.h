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
@property (nonatomic) CGSize imgSize;
@property (nonatomic, strong) NSURL *thumbImgUrl;
@property (nonatomic, strong) NSURL *imgUrl;
@property (nonatomic, copy) NSString *contentType;

@end
