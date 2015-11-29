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

NSString * const ASCTableViewImageSearchResultCellIdentifier = @"ASCTableViewImageSearchResultCellIdentifier";

@interface ASCTableViewImageSearchResultCell ()

@property NSMutableString *imageTitleLabelText;

@end

@implementation ASCTableViewImageSearchResultCell

@dynamic cellModel;

- (void)setup {
    [super setup];
    
    self.textLabel.hidden = YES;
    
    self.asyncImageView = [[ASCAsyncImageView alloc] init];
    
    [self addSubview:self.asyncImageView];
    
    self.imageTitleLabel = [[UILabel alloc] init];
    self.imageTitleLabel.font = [UIFont systemFontOfSize:11.];
    self.imageTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.imageTitleLabel.numberOfLines = 1;
    self.imageTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.imageTitleLabel];
    
    NSArray *keys = [[NSArray alloc] initWithObjects:(id)kCTForegroundColorAttributeName,(id)kCTUnderlineStyleAttributeName, kCTFontAttributeName, nil];
    NSArray *objects = [[NSArray alloc] initWithObjects:[UIColor blueColor],[NSNumber numberWithInt:kCTUnderlineStyleNone], [UIFont systemFontOfSize:14.], nil];
    NSDictionary *linkAttributes = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    
    self.titleLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:14.];
    self.titleLabel.linkAttributes = linkAttributes;
    self.titleLabel.numberOfLines = 0;
    
    [self addSubview:self.titleLabel];
    
    self.urlLabel = [[UILabel alloc] init];
    self.urlLabel.font = [UIFont systemFontOfSize:11.];
    self.urlLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.urlLabel.numberOfLines = 1;
    [self.urlLabel setTextColor:[UIColor colorWithRed:0 green:100./255. blue:0 alpha:1]];
    
    [self addSubview:self.urlLabel];
    
    self.dividerView = [[UIView alloc] init];
    self.dividerView.backgroundColor = [UIColor colorWithRed:241./255. green:241./255. blue:241./255. alpha:1];
    
    [self addSubview:self.dividerView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.asyncImageView.frame = CGRectMake((self.frame.size.width - self.asyncImageView.imageSize.width) / 2, ASCTableViewCellContentPadding,
                                      self.asyncImageView.imageSize.width, self.asyncImageView.imageSize.height);
    
    self.imageTitleLabel.frame = CGRectMake(ASCTableViewCellContentPadding, self.asyncImageView.frame.origin.y + self.asyncImageView.frame.size.height + 3.,
                                            self.frame.size.width - (2 * ASCTableViewCellContentPadding), 13.5);
    
    self.dividerView.frame = CGRectMake(0, self.imageTitleLabel.frame.origin.y + self.imageTitleLabel.frame.size.height + ASCTableViewCellContentPadding,
                                        self.frame.size.width, 1);
    
    self.titleLabel.frame = CGRectMake(ASCTableViewCellContentPadding, self.dividerView.frame.origin.y + self.dividerView.frame.size.height +
                                       ASCTableViewCellContentPadding, self.frame.size.width - (2 * ASCTableViewCellContentPadding), 0);
    [self.titleLabel sizeToFit];
    
    self.urlLabel.frame = CGRectMake(ASCTableViewCellContentPadding, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height,
                                     self.frame.size.width - (2 * ASCTableViewCellContentPadding), 13.5);
    
}

- (void)setCellModel:(ASCImageSearchResultModel *)cellModel {
    [super setCellModel:cellModel];
    
    [self parseCellAttributes];
    
    self.titleLabel.attributedText = self.titleLabelText;
    [self.titleLabel addLinkToURL:self.cellModel.contextUrl withRange:NSMakeRange(0, self.titleLabelText.length)];
    self.contentLabel.attributedText = self.contentLabelText;
    self.urlLabel.text = [self.cellModel.contextUrl absoluteString];
    [self.asyncImageView setImageSize:self.cellModel.thumbSize];
    [self.asyncImageView setImageUrl:self.cellModel.thumbUrl];
    self.imageTitleLabel.text = self.imageTitleLabelText;
}

- (void)parseCellAttributes {
    self.titleLabelText = [[NSMutableAttributedString alloc] initWithString:self.cellModel.titleNoFormatting];
    [self.titleLabelText replaceHtmlSymbols];
    
    self.contentLabelText = [[NSMutableAttributedString alloc] initWithString:self.cellModel.content];
    [self.contentLabelText replaceHtmlSymbols];
    
    NSArray *keys = [[NSArray alloc] initWithObjects:(id)kCTFontAttributeName, nil];
    NSArray *objects = [[NSArray alloc] initWithObjects:[UIFont boldSystemFontOfSize:12.], nil];
    [self.contentLabelText replaceOccurancesOfHtmlTag:@"b" withAttributes:[[NSDictionary alloc] initWithObjects:objects forKeys:keys]];
    
    self.imageTitleLabelText = [[NSMutableString alloc] initWithString:[self.cellModel.url absoluteString]];
    NSArray *split = [self.imageTitleLabelText componentsSeparatedByString:@"/"];
    self.imageTitleLabelText = [split lastObject];
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
    
    CGFloat height = sizingCell.asyncImageView.frame.size.height + sizingCell.imageTitleLabel.frame.size.height +
    sizingCell.titleLabel.frame.size.height + sizingCell.urlLabel.frame.size.height + sizingCell.dividerView.frame.size.height
    + (4 * ASCTableViewCellContentPadding) + 3.;
    
    return height;
}

@end
