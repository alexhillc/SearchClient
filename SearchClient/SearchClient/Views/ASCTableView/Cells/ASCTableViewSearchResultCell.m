//
//  ASCTableViewSearchResultCell.m
//  SearchClient
//
//  Created by Alex Hill on 11/14/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewSearchResultCell.h"
#import "ASCSearchResultModel.h"
#import "TTTAttributedLabel.h"
#import <QuartzCore/QuartzCore.h>

NSString * const ASCTableViewSearchResultCellIdentifier = @"ASCTableViewSearchResultCellIdentifier";
CGFloat const contentPadding = 10.;

@implementation ASCTableViewSearchResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    self.textLabel.hidden = YES;
    
    NSArray *keys = [[NSArray alloc] initWithObjects:(id)kCTForegroundColorAttributeName,(id)kCTUnderlineStyleAttributeName, nil];
    NSArray *objects = [[NSArray alloc] initWithObjects:[UIColor blueColor],[NSNumber numberWithInt:kCTUnderlineStyleNone], nil];
    NSDictionary *linkAttributes = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    
    self.titleLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:16.];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    self.titleLabel.linkAttributes = linkAttributes;
    
    [self addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.font = [UIFont systemFontOfSize:14. weight:UIFontWeightLight];
    self.contentLabel.numberOfLines = 3;
    
    [self addSubview:self.contentLabel];
    
    self.clipsToBounds = NO;
    self.layer.cornerRadius = 1.5;
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.layer.shadowRadius = 1.;
    self.layer.shadowOpacity = 0.08;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width - (2 * contentPadding);
    self.titleLabel.frame = CGRectMake(contentPadding, contentPadding, width, 0);
    [self.titleLabel sizeToFit];
    
    self.contentLabel.frame = CGRectMake(contentPadding, self.titleLabel.frame.size.height + contentPadding, width, 0);
    [self.contentLabel sizeToFit];
}

- (void)setCellModel:(ASCSearchResultModel *)cellModel {
    _cellModel = cellModel;
    
    self.titleLabel.text = self.cellModel.titleNoFormatting;
    [self.titleLabel addLinkToURL:self.cellModel.url withRange:NSMakeRange(0, self.cellModel.titleNoFormatting.length)];
    self.contentLabel.text = self.cellModel.content;
}

@end
