//
//  ASCTableViewSearchResultCell.h
//  SearchClient
//
//  Created by Alex Hill on 11/14/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASCSearchResultModel.h"
#import "TTTAttributedLabel.h"
#import <QuartzCore/QuartzCore.h>

extern CGFloat const ASCTableViewCellContentPadding;

@class TTTAttributedLabel, ASCSearchResultModel;

@interface ASCTableViewSearchResultCell : UITableViewCell

@property (strong) TTTAttributedLabel *titleLabel;
@property (strong) UILabel *contentLabel;
@property (strong) UILabel *urlLabel;
@property (strong) UIView *dividerView;
@property (nonatomic) ASCSearchResultModel *cellModel;
@property NSMutableAttributedString *titleLabelText;
@property NSMutableAttributedString *contentLabelText;

- (void)setup;
- (void)parseCellAttributes;
- (CGFloat)intrinsicHeightForWidth:(CGFloat)width;

@end
