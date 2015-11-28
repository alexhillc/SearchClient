//
//  ASCCollectionViewCell.m
//  SearchClient
//
//  Created by Alex Hill on 11/27/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCCollectionViewCell.h"

NSString * const ASCCollectionViewCellReuseIdentifier = @"ASCCollectionViewCellReuseIdentifier";

@implementation ASCCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor colorWithRed:243./255. green:243./255. blue:243./255. alpha:1];
    
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.textColor = [UIColor googleBlueColor];
    self.textLabel.font = [UIFont boldSystemFontOfSize:10.];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.textLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.textLabel sizeToFit];
    self.textLabel.frame = CGRectMake((self.frame.size.width - self.textLabel.frame.size.width) / 2,
                                      (self.frame.size.height - self.textLabel.frame.size.height) / 2,
                                                                self.textLabel.frame.size.width,
                                                                self.textLabel.frame.size.height);
}

- (CGFloat)intrinsicWidthForHeight:(CGFloat)height {
    self.bounds = CGRectMake(0, 0, 0, height);
    [self layoutSubviews];
    
    CGFloat width = self.textLabel.frame.size.width + 30.;
    
    return width;
}

@end
