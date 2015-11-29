//
//  ASCTableViewWebSearchResultCell.m
//  SearchClient
//
//  Created by Alex Hill on 11/28/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewWebSearchResultCell.h"

NSString * const ASCTableViewWebSearchResultCellIdentifier = @"ASCTableViewWebSearchResultCellIdentifier";

@implementation ASCTableViewWebSearchResultCell

@dynamic cellModel;

- (void)setup {
    [super setup];

    self.textLabel.hidden = YES;
    
    NSArray *keys = [[NSArray alloc] initWithObjects:(id)kCTForegroundColorAttributeName,(id)kCTUnderlineStyleAttributeName, kCTFontAttributeName, nil];
    NSArray *objects = [[NSArray alloc] initWithObjects:[UIColor blueColor],[NSNumber numberWithInt:kCTUnderlineStyleNone], [UIFont systemFontOfSize:14.], nil];
    NSDictionary *linkAttributes = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    
    self.titleLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:14.];
    self.titleLabel.linkAttributes = linkAttributes;
    self.titleLabel.numberOfLines = 0;
    
    [self addSubview:self.titleLabel];
    
    self.urlLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.urlLabel.font = [UIFont systemFontOfSize:11.];
    self.urlLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.urlLabel.numberOfLines = 1;
    [self.urlLabel setTextColor:[UIColor colorWithRed:0 green:100./255. blue:0 alpha:1]];
    
    [self addSubview:self.urlLabel];
    
    self.dividerView = [[UIView alloc] init];
    self.dividerView.backgroundColor = [UIColor colorWithRed:241./255. green:241./255. blue:241./255. alpha:1];
    
    [self addSubview:self.dividerView];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.font = [UIFont systemFontOfSize:12.];
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(ASCTableViewCellContentPadding, ASCTableViewCellContentPadding, self.frame.size.width - (2 * ASCTableViewCellContentPadding), 0);
    [self.titleLabel sizeToFit];
    
    self.urlLabel.frame = CGRectMake(ASCTableViewCellContentPadding, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height,
                                     self.frame.size.width - (2 * ASCTableViewCellContentPadding), 13.5);
    
    self.dividerView.frame = CGRectMake(0, self.urlLabel.frame.origin.y + self.urlLabel.frame.size.height + ASCTableViewCellContentPadding,
                                        self.frame.size.width, 1);
    
    self.contentLabel.frame = CGRectMake(ASCTableViewCellContentPadding, self.dividerView.frame.origin.y + self.dividerView.frame.size.height +
                                         ASCTableViewCellContentPadding, self.frame.size.width - (2 * ASCTableViewCellContentPadding), 0);
    [self.contentLabel sizeToFit];
}

- (void)setCellModel:(ASCSearchResultModel *)cellModel {
    [super setCellModel:cellModel];
    
    [self parseCellAttributes];
    
    self.titleLabel.attributedText = self.titleLabelText;
    [self.titleLabel addLinkToURL:self.cellModel.url withRange:NSMakeRange(0, self.titleLabelText.length)];
    self.contentLabel.attributedText = self.contentLabelText;
    self.urlLabel.text = [self.cellModel.url absoluteString];
}

- (void)parseCellAttributes {
    self.titleLabelText = [[NSMutableAttributedString alloc] initWithString:self.cellModel.titleNoFormatting];
    [self.titleLabelText replaceHtmlSymbols];
    
    self.contentLabelText = [[NSMutableAttributedString alloc] initWithString:self.cellModel.content];
    [self.contentLabelText replaceHtmlSymbols];
    
    NSArray *keys = [[NSArray alloc] initWithObjects:(id)kCTFontAttributeName, nil];
    NSArray *objects = [[NSArray alloc] initWithObjects:[UIFont boldSystemFontOfSize:12.], nil];
    [self.contentLabelText replaceOccurancesOfHtmlTag:@"b" withAttributes:[[NSDictionary alloc] initWithObjects:objects forKeys:keys]];
}

- (CGFloat)intrinsicHeightForWidth:(CGFloat)width {
    static ASCTableViewWebSearchResultCell *sizingCell;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [[ASCTableViewWebSearchResultCell alloc] init];
    });
    
    sizingCell.bounds = CGRectMake(0, 0, width, 0);
    sizingCell.cellModel = self.cellModel;
    [sizingCell layoutSubviews];
    
    CGFloat height = sizingCell.titleLabel.frame.size.height + sizingCell.contentLabel.frame.size.height + sizingCell.urlLabel.frame.size.height + sizingCell.dividerView.frame.size.height + (4 * ASCTableViewCellContentPadding);
    
    return height;
}

@end
