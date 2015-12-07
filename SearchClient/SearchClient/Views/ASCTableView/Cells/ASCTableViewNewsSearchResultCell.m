//
//  ASCTableViewNewsSearchResultCell.m
//  SearchClient
//
//  Created by Alex Hill on 11/29/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewNewsSearchResultCell.h"

NSString * const ASCTableViewNewsSearchResultCellIdentifier = @"ASCTableViewNewsSearchResultCellIdentifier";

@implementation ASCTableViewNewsSearchResultCell

@dynamic cellModel;

- (void)setup {
    [super setup];
    
    self.textLabel.hidden = YES;
    
    NSArray *keys = [[NSArray alloc] initWithObjects:(id)kCTForegroundColorAttributeName,(id)kCTUnderlineStyleAttributeName, kCTFontAttributeName, nil];
    NSArray *objects = [[NSArray alloc] initWithObjects:[UIColor blueColor],[NSNumber numberWithInt:kCTUnderlineStyleNone], [UIFont systemFontOfSize:16.], nil];
    NSDictionary *linkAttributes = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    
    self.titleLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:16.];
    self.titleLabel.linkAttributes = linkAttributes;
    self.titleLabel.numberOfLines = 0;
    
    [self addSubview:self.titleLabel];
    
    self.publisherLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.publisherLabel.font = [UIFont systemFontOfSize:14.];
    self.publisherLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.publisherLabel.numberOfLines = 1;
    [self.publisherLabel setTextColor:[UIColor colorWithRed:102./255. green:102./255. blue:102./255. alpha:1]];
    
    [self addSubview:self.publisherLabel];
    
    self.publishedDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.publishedDateLabel.font = [UIFont systemFontOfSize:14.];
    self.publishedDateLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.publishedDateLabel.numberOfLines = 1;
    [self.publishedDateLabel setTextColor:[UIColor colorWithRed:102./255. green:102./255. blue:102./255. alpha:1]];
    
    [self addSubview:self.publishedDateLabel];
    
    self.dividerView = [[UIView alloc] init];
    self.dividerView.backgroundColor = [UIColor colorWithRed:241./255. green:241./255. blue:241./255. alpha:1];
    
    [self addSubview:self.dividerView];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.font = [UIFont systemFontOfSize:14.];
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(ASCTableViewCellContentPadding, ASCTableViewCellContentPadding, self.frame.size.width - (2 * ASCTableViewCellContentPadding), 0);
    [self.titleLabel sizeToFit];
    
    self.publisherLabel.frame = CGRectMake(ASCTableViewCellContentPadding, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 2.,
                                           self.frame.size.width - (2 * ASCTableViewCellContentPadding), 0);
    [self.publisherLabel sizeToFit];
    
    self.publishedDateLabel.frame = CGRectMake(self.publisherLabel.frame.origin.x + self.publisherLabel.frame.size.width, self.publisherLabel.frame.origin.y,
                                               self.frame.size.width - (2 * ASCTableViewCellContentPadding), 0);
    [self.publishedDateLabel sizeToFit];
    
    self.dividerView.frame = CGRectMake(0, self.publisherLabel.frame.origin.y + self.publisherLabel.frame.size.height + ASCTableViewCellContentPadding,
                                        self.frame.size.width, 1);
    
    self.contentLabel.frame = CGRectMake(ASCTableViewCellContentPadding, self.dividerView.frame.origin.y + self.dividerView.frame.size.height +
                                         ASCTableViewCellContentPadding, self.frame.size.width - (2 * ASCTableViewCellContentPadding), 0);
    [self.contentLabel sizeToFit];
}

- (void)setCellModel:(ASCTableViewNewsSearchResultCellModel *)cellModel {
    [super setCellModel:cellModel];
    
    self.titleLabel.text = self.cellModel.titleLabelText;
    [self.titleLabel addLinkToURL:self.cellModel.url withRange:NSMakeRange(0, self.cellModel.titleLabelText.length)];
    self.contentLabel.attributedText = self.cellModel.contentLabelText;
    self.publisherLabel.text = cellModel.publisherLabelText;
    self.publishedDateLabel.text = [[@" \u00B7 " stringByAppendingString:cellModel.publishedDateLabelText] stringByAppendingString:@" ago"];
}

- (CGFloat)intrinsicHeightForWidth:(CGFloat)width {
    static ASCTableViewNewsSearchResultCell *sizingCell;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [[ASCTableViewNewsSearchResultCell alloc] init];
    });
    
    sizingCell.bounds = CGRectMake(0, 0, width, 0);
    sizingCell.cellModel = self.cellModel;
    [sizingCell layoutSubviews];
    
    CGFloat height = sizingCell.titleLabel.frame.size.height + sizingCell.contentLabel.frame.size.height + sizingCell.publisherLabel.frame.size.height +
                    sizingCell.dividerView.frame.size.height + 2. + (4 * ASCTableViewCellContentPadding);
    
    return height;
}

@end
