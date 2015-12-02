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
    
    self.asyncImageView = [[ASCAsyncImageView alloc] init];
    
    [self addSubview:self.asyncImageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.asyncImageView.imageSize.width > self.frame.size.width) {
        [self.asyncImageView scaleToWidth:self.frame.size.width];
    }
    
    self.asyncImageView.frame = CGRectMake((self.frame.size.width - self.asyncImageView.imageSize.width) / 2, 0,
                                      self.asyncImageView.imageSize.width, self.asyncImageView.imageSize.height);
}

- (void)setCellModel:(ASCImageSearchResultModel *)cellModel {
    [super setCellModel:cellModel];
        
    [self.asyncImageView setImageSize:self.cellModel.thumbSize];
    [self.asyncImageView setImageUrl:self.cellModel.thumbImgUrl];
    [self.asyncImageView setLargeImageSize:self.cellModel.imgSize];
    [self.asyncImageView setLargeImageUrl:self.cellModel.imgUrl];
}

- (CGFloat)intrinsicHeightForWidth:(CGFloat)width {
    static ASCTableViewImageSearchResultCell *sizingCell;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [[ASCTableViewImageSearchResultCell alloc] init];
    });
    
    sizingCell.bounds = CGRectMake(0, 0, width, 0);
    sizingCell.cellModel = self.cellModel;
    [sizingCell.asyncImageView setImageUrl:nil];
    [sizingCell layoutSubviews];
    
    CGFloat height = sizingCell.asyncImageView.frame.size.height;
    
    return height;
}

@end
