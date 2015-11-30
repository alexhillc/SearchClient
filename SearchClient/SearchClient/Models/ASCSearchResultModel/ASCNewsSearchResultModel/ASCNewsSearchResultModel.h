//
//  ASCNewsSearchResultModel.h
//  SearchClient
//
//  Created by Alex Hill on 11/29/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchResultModel.h"

@interface ASCNewsSearchResultModel : ASCSearchResultModel

@property (nonatomic) CGSize thumbSize;
@property (nonatomic, strong) NSURL *thumbImgUrl;
@property (nonatomic, strong) NSURL *imgUrl;
@property (nonatomic, strong) NSURL *clusterUrl;
@property (nonatomic, strong) NSDate *publishedDate;
@property (nonatomic, copy) NSString *publisher;

@end
