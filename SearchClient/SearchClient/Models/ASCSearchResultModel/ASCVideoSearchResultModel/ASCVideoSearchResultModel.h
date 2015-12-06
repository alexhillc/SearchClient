//
//  ASCVideoSearchResultModel.h
//  SearchClient
//
//  Created by Alex Hill on 12/6/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchResultModel.h"

@interface ASCVideoSearchResultModel : ASCSearchResultModel

@property (nonatomic) CGSize thumbSize;
@property (nonatomic, strong) NSURL *thumbImgUrl;
@property (nonatomic, strong) NSNumber *runTime;

@end
