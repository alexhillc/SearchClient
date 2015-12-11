//
//  ASCTableViewVideoSearchResultCell.m
//  SearchClient
//
//  Created by Alex Hill on 12/6/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewVideoSearchResultCell.h"
#import "ASCAsyncImageView.h"

NSString * const ASCTableViewVideoSearchResultCellIdentifier = @"ASCTableViewVideoSearchResultCellIdentifier";

@implementation ASCTableViewVideoSearchResultCell

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
    
    self.urlLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.urlLabel.font = [UIFont systemFontOfSize:14.];
    self.urlLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.urlLabel.numberOfLines = 1;
    [self.urlLabel setTextColor:[UIColor colorWithRed:0 green:100./255. blue:0 alpha:1]];
    
    [self addSubview:self.urlLabel];
    
    self.runtimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.runtimeLabel.font = [UIFont systemFontOfSize:14.];
    [self.runtimeLabel setTextColor:[UIColor colorWithRed:102./255. green:102./255. blue:102./255. alpha:1]];
    self.runtimeLabel.numberOfLines = 1;
    
    [self addSubview:self.runtimeLabel];
    
    self.asyncImageViewFirst = [[ASCAsyncImageView alloc] init];
    
    [self addSubview:self.asyncImageViewFirst];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(ASCTableViewCellContentPadding, ASCTableViewCellContentPadding, self.frame.size.width - (2 * ASCTableViewCellContentPadding), 0);
    [self.titleLabel sizeToFit];
    
    self.asyncImageViewFirst.frame = CGRectMake(ASCTableViewCellContentPadding, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5., self.asyncImageViewFirst.imageSize.width, self.asyncImageViewFirst.imageSize.height);
    
    self.urlLabel.frame = CGRectMake(self.asyncImageViewFirst.frame.origin.x + self.asyncImageViewFirst.frame.size.width + 5., self.asyncImageViewFirst.frame.origin.y,
                                     self.frame.size.width - self.asyncImageViewFirst.frame.size.width - (2 * ASCTableViewCellContentPadding), 17.);
    
    self.runtimeLabel.frame = CGRectMake(self.urlLabel.frame.origin.x, self.urlLabel.frame.origin.y + self.urlLabel.frame.size.height + 5., self.urlLabel.frame.size.width, 0);
    [self.runtimeLabel sizeToFit];
}

- (void)setCellModel:(ASCTableViewVideoSearchResultCellModel *)cellModel {
    [super setCellModel:cellModel];
    
    self.titleLabel.text = self.cellModel.titleLabelText;
    [self.titleLabel addLinkToURL:self.cellModel.url withRange:NSMakeRange(0, self.cellModel.titleLabelText.length)];
    self.runtimeLabel.text = [@"Duration: " stringByAppendingString:self.cellModel.runtimeLabelText];
    self.urlLabel.text = self.cellModel.urlLabelText;
    [self.asyncImageViewFirst setImageUrl:self.cellModel.thumbImgUrl];
    [self.asyncImageViewFirst setImageSize:self.cellModel.thumbSize];
}

+ (CGFloat)intrinsicHeightForWidth:(CGFloat)width cellModel:(ASCTableViewSearchResultCellModel *)cellModel {
    static ASCTableViewVideoSearchResultCell *sizingCell;
    
    // we have to make a sizing cell to get the intrinsic size.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [[ASCTableViewVideoSearchResultCell alloc] init];
    });
    
    ASCTableViewVideoSearchResultCellModel *videoCellModel = (ASCTableViewVideoSearchResultCellModel *)cellModel;
    ASCTableViewVideoSearchResultCellModel *model = [[ASCTableViewVideoSearchResultCellModel alloc] init];
    model.thumbSize = videoCellModel.thumbSize;
    model.titleLabelText = videoCellModel.titleLabelText;
    model.url = videoCellModel.url;
    model.runtimeLabelText = videoCellModel.runtimeLabelText;
    model.urlLabelText = videoCellModel.urlLabelText;
    
    sizingCell.bounds = CGRectMake(0, 0, width, 0);
    sizingCell.cellModel = model;
    [sizingCell layoutSubviews];
    
    CGFloat height = sizingCell.titleLabel.frame.size.height + sizingCell.asyncImageViewFirst.frame.size.height + 5. + (2 * ASCTableViewCellContentPadding);
    
    return height;
}

@end
