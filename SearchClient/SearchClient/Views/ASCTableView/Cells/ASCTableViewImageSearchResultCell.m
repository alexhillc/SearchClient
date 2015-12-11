//
//  ASCTableViewImageSearchResultsCell.m
//  SearchClient
//
//  Created by Alex Hill on 11/28/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewImageSearchResultCell.h"
#import "ASCAsyncImageView.h"
#import "ASCImageSearchResultModel.h"
#import "JTSImageViewController.h"

NSString * const ASCTableViewImageSearchResultCellIdentifier = @"ASCTableViewImageSearchResultCellIdentifier";

@implementation ASCTableViewImageSearchResultCell

@dynamic cellModel;

- (void)setup {    
    self.textLabel.hidden = YES;
    self.backgroundColor = [UIColor blackColor];
    
    self.asyncImageViewFirst = [[ASCAsyncImageView alloc] init];
    self.asyncImageViewFirst.contentMode = UIViewContentModeScaleAspectFill;
    self.asyncImageViewFirst.clipsToBounds = YES;
    [self addSubview:self.asyncImageViewFirst];
    
    self.asyncImageViewSecond = [[ASCAsyncImageView alloc] init];
    self.asyncImageViewSecond.contentMode = UIViewContentModeScaleAspectFill;
    self.asyncImageViewSecond.clipsToBounds = YES;
    [self addSubview:self.asyncImageViewSecond];
    
    self.asyncImageViewThird = [[ASCAsyncImageView alloc] init];
    self.asyncImageViewThird.contentMode = UIViewContentModeScaleAspectFill;
    self.asyncImageViewThird.clipsToBounds = YES;
    [self addSubview:self.asyncImageViewThird];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat imageWidth = (self.frame.size.width - 14.) / 3.;
    CGFloat imageHeight = imageWidth;
    
    BOOL imagesLookSilly = imageWidth > self.asyncImageViewFirst.imageSize.width &&
                            imageWidth > self.asyncImageViewSecond.imageSize.width &&
                            imageWidth > self.asyncImageViewThird.imageSize.width;
    
    if (imagesLookSilly) {
        self.asyncImageViewFirst.frame = CGRectMake(0, 0, self.asyncImageViewFirst.imageSize.width, self.asyncImageViewFirst.imageSize.width);
        self.asyncImageViewSecond.frame = CGRectMake((self.frame.size.width - self.asyncImageViewSecond.imageSize.width) / 2, 0,
                                                     self.asyncImageViewSecond.imageSize.width, self.asyncImageViewSecond.imageSize.height);
        self.asyncImageViewThird.frame = CGRectMake(self.frame.size.width - self.asyncImageViewThird.imageSize.width, 0,
                                                    self.asyncImageViewThird.imageSize.width, self.asyncImageViewThird.imageSize.height);
    } else {
        self.asyncImageViewFirst.frame = CGRectMake(0, 0, imageWidth, imageHeight);
        self.asyncImageViewSecond.frame = CGRectMake(self.asyncImageViewFirst.frame.size.width + 7., 0, imageWidth, imageHeight);
        self.asyncImageViewThird.frame = CGRectMake(self.asyncImageViewSecond.frame.origin.x + self.asyncImageViewSecond.frame.size.width + 7.,
                                                    0, imageWidth, imageHeight);
    }
}

- (void)setCellModel:(ASCTableViewImageSearchResultCellModel *)cellModel {
    [super setCellModel:cellModel];
        
    [self.asyncImageViewFirst setImageSize:self.cellModel.thumbSizeFirst];
    [self.asyncImageViewFirst setImageUrl:self.cellModel.thumbImgUrlFirst];
    [self.asyncImageViewFirst setLargeImageSize:self.cellModel.imgSizeFirst];
    [self.asyncImageViewFirst setLargeImageUrl:self.cellModel.imgUrlFirst];
    
    [self.asyncImageViewSecond setImageSize:self.cellModel.thumbSizeSecond];
    [self.asyncImageViewSecond setImageUrl:self.cellModel.thumbImgUrlSecond];
    [self.asyncImageViewSecond setLargeImageSize:self.cellModel.imgSizeSecond];
    [self.asyncImageViewSecond setLargeImageUrl:self.cellModel.imgUrlSecond];
    
    [self.asyncImageViewThird setImageSize:self.cellModel.thumbSizeThird];
    [self.asyncImageViewThird setImageUrl:self.cellModel.thumbImgUrlThird];
    [self.asyncImageViewThird setLargeImageSize:self.cellModel.imgSizeThird];
    [self.asyncImageViewThird setLargeImageUrl:self.cellModel.imgUrlThird];
}

+ (CGFloat)intrinsicHeightForWidth:(CGFloat)width cellModel:(ASCTableViewSearchResultCellModel *)cellModel {
    static ASCTableViewImageSearchResultCell *sizingCell;
    
    // we have to make a sizing cell to get the intrinsic size.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [[ASCTableViewImageSearchResultCell alloc] init];
    });
    
    ASCTableViewImageSearchResultCellModel *imageCellModel = (ASCTableViewImageSearchResultCellModel *)cellModel;
    ASCTableViewImageSearchResultCellModel *model = [[ASCTableViewImageSearchResultCellModel alloc] init];
    model.imgSizeFirst = imageCellModel.imgSizeFirst;
    model.imgSizeSecond = imageCellModel.imgSizeSecond;
    model.imgSizeThird = imageCellModel.imgSizeThird;
    model.thumbSizeFirst = imageCellModel.thumbSizeFirst;
    model.thumbSizeSecond = imageCellModel.thumbSizeSecond;
    model.thumbSizeThird = imageCellModel.thumbSizeThird;
    
    sizingCell.bounds = CGRectMake(0, 0, width, 0);
    sizingCell.cellModel = imageCellModel;
    [sizingCell layoutSubviews];
    
    CGFloat height = sizingCell.asyncImageViewFirst.frame.size.height;
    
    if (sizingCell.asyncImageViewSecond.frame.size.height > height) {
        height = sizingCell.asyncImageViewSecond.frame.size.height;
    }
    
    if (sizingCell.asyncImageViewThird.frame.size.height > height) {
        height = sizingCell.asyncImageViewThird.frame.size.height;
    }
    
    return height;
}

@end
