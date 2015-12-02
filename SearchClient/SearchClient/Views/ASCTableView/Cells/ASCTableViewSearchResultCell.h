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

@class TTTAttributedLabel, ASCSearchResultModel, ASCAsyncImageView;

@interface ASCTableViewSearchResultCell : UITableViewCell

@property (strong) TTTAttributedLabel *titleLabel;
@property (strong) UILabel *contentLabel;
@property (strong) UILabel *urlLabel;
@property (strong) UIView *dividerView;
@property (nonatomic) ASCSearchResultModel *cellModel;
@property ASCAsyncImageView *asyncImageView;

- (void)setup;
- (CGFloat)intrinsicHeightForWidth:(CGFloat)width;

@end
