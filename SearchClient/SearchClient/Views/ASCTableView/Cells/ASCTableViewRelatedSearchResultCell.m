//
//  ASCTableViewrelatedSearchResultCell.m
//  SearchClient
//
//  Created by Alex Hill on 12/6/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewRelatedSearchResultCell.h"

NSString * const ASCTableViewRelatedSearchResultCellIdentifier = @"ASCTableViewRelatedSearchResultCellIdentifier";

@implementation ASCTableViewRelatedSearchResultCell

@dynamic cellModel;

- (void)setup {
    [super setup];
    
    self.textLabel.hidden = YES;
    
    self.titleLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:16.];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.linkAttributes = @{ NSForegroundColorAttributeName:[UIColor blueColor],
                                        NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                                        NSFontAttributeName:[UIFont systemFontOfSize:16.] };
    
    [self addSubview:self.titleLabel];
    
    self.urlLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.urlLabel.font = [UIFont systemFontOfSize:14.];
    self.urlLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.urlLabel.numberOfLines = 1;
    [self.urlLabel setTextColor:[UIColor colorWithRed:0 green:100./255. blue:0 alpha:1]];
    
    [self addSubview:self.urlLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(ASCTableViewCellContentPadding, ASCTableViewCellContentPadding, self.frame.size.width - (2 * ASCTableViewCellContentPadding), 0);
    [self.titleLabel sizeToFit];
    
    self.urlLabel.frame = CGRectMake(ASCTableViewCellContentPadding, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 2.,
                                     self.frame.size.width - (2 * ASCTableViewCellContentPadding), 17.);
    
}

- (void)setCellModel:(ASCTableViewRelatedSearchResultCellModel *)cellModel {
    [super setCellModel:cellModel];
    
    self.titleLabel.attributedText = self.cellModel.titleLabelText;
    [self.titleLabel addLinkToURL:self.cellModel.url withRange:NSMakeRange(0, self.cellModel.titleLabelText.length)];
    self.urlLabel.text = self.cellModel.urlLabelText;
}

+ (CGFloat)intrinsicHeightForWidth:(CGFloat)width cellModel:(ASCTableViewSearchResultCellModel *)cellModel {
    static ASCTableViewRelatedSearchResultCell *sizingCell;
    
    // we have to make a sizing cell to get the intrinsic size.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [[ASCTableViewRelatedSearchResultCell alloc] init];
    });
    
    sizingCell.bounds = CGRectMake(0, 0, width, 0);
    sizingCell.cellModel = (ASCTableViewRelatedSearchResultCellModel *)cellModel;
    [sizingCell layoutSubviews];
    
    CGFloat height = sizingCell.titleLabel.frame.size.height + 2. + sizingCell.urlLabel.frame.size.height + (2 * ASCTableViewCellContentPadding);
    
    return height;
}

@end
