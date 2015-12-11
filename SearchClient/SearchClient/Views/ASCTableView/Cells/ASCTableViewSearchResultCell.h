//
//  ASCTableViewSearchResultCell.h
//  SearchClient
//
//  Created by Alex Hill on 11/14/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
#import <QuartzCore/QuartzCore.h>

extern CGFloat const ASCTableViewCellContentPadding;

@class TTTAttributedLabel, ASCTableViewSearchResultCellModel, ASCAsyncImageView;

@interface ASCTableViewSearchResultCell : UITableViewCell

@property (strong) TTTAttributedLabel *titleLabel;
@property (strong) UILabel *contentLabel;
@property (strong) UILabel *urlLabel;
@property (strong) UIView *dividerView;
@property (nonatomic) ASCTableViewSearchResultCellModel *cellModel;
@property ASCAsyncImageView *asyncImageViewFirst;
@property ASCAsyncImageView *asyncImageViewSecond;
@property ASCAsyncImageView *asyncImageViewThird;

+ (CGFloat)intrinsicHeightForWidth:(CGFloat)width cellModel:(ASCTableViewSearchResultCellModel *)cellModel;

- (void)setup;

@end
