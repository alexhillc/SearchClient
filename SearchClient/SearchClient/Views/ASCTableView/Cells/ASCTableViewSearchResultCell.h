//
//  ASCTableViewSearchResultCell.h
//  SearchClient
//
//  Created by Alex Hill on 11/14/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTTAttributedLabel, ASCSearchResultModel;

extern NSString * const ASCTableViewSearchResultCellIdentifier;

@interface ASCTableViewSearchResultCell : UITableViewCell

@property (strong) TTTAttributedLabel *titleLabel;
@property (strong) UILabel *contentLabel;
@property (strong) UILabel *urlLabel;
@property (strong) UIView *dividerView;
@property (nonatomic) ASCSearchResultModel *cellModel;

- (CGFloat)intrinsicHeightForWidth:(CGFloat)width;

@end
