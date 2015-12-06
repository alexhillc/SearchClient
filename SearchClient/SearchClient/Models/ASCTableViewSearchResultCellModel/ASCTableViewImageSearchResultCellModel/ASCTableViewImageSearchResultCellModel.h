//
//  ASCTableViewImageSearchResultCellModel.h
//  SearchClient
//
//  Created by Alex Hill on 12/3/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewSearchResultCellModel.h"

@interface ASCTableViewImageSearchResultCellModel : ASCTableViewSearchResultCellModel

@property (nonatomic) CGSize thumbSizeFirst;
@property (nonatomic) CGSize imgSizeFirst;
@property (nonatomic, strong) NSURL *thumbImgUrlFirst;
@property (nonatomic, strong) NSURL *imgUrlFirst;

@property (nonatomic) CGSize thumbSizeSecond;
@property (nonatomic) CGSize imgSizeSecond;
@property (nonatomic, strong) NSURL *thumbImgUrlSecond;
@property (nonatomic, strong) NSURL *imgUrlSecond;

@property (nonatomic) CGSize thumbSizeThird;
@property (nonatomic) CGSize imgSizeThird;
@property (nonatomic, strong) NSURL *thumbImgUrlThird;
@property (nonatomic, strong) NSURL *imgUrlThird;

@end
