//
//  ASCTableViewSearchResultCell.m
//  SearchClient
//
//  Created by Alex Hill on 11/14/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewSearchResultCell.h"
#import "ASCTableViewWebSearchResultCell.h"
#import "ASCTableViewImageSearchResultCell.h"
#import "ASCTableViewNewsSearchResultCell.h"
#import "ASCTableViewVideoSearchResultCell.h"
#import "ASCTableViewRelatedSearchResultCell.h"
#import "ASCTableViewSpellSearchResultCell.h"

CGFloat const ASCTableViewCellContentPadding = 10.;

@implementation ASCTableViewSearchResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = NO;
    self.layer.cornerRadius = 1.5;
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.layer.shadowRadius = 1.;
    self.layer.shadowOpacity = 0.08;
}

+ (CGFloat)intrinsicHeightForWidth:(CGFloat)width cellModel:(ASCTableViewSearchResultCellModel *)cellModel {
    if ([cellModel isKindOfClass:[ASCTableViewWebSearchResultCellModel class]]) {
        return [ASCTableViewWebSearchResultCell intrinsicHeightForWidth:width cellModel:cellModel];
    } else if ([cellModel isKindOfClass:[ASCTableViewImageSearchResultCellModel class]]) {
        return [ASCTableViewImageSearchResultCell intrinsicHeightForWidth:width cellModel:cellModel];
    } else if ([cellModel isKindOfClass:[ASCTableViewNewsSearchResultCellModel class]]) {
        return [ASCTableViewNewsSearchResultCell intrinsicHeightForWidth:width cellModel:cellModel];
    } else if ([cellModel isKindOfClass:[ASCTableViewVideoSearchResultCellModel class]]) {
        return [ASCTableViewVideoSearchResultCell intrinsicHeightForWidth:width cellModel:cellModel];
    } else if ([cellModel isKindOfClass:[ASCTableViewRelatedSearchResultCellModel class]]) {
        return [ASCTableViewRelatedSearchResultCell intrinsicHeightForWidth:width cellModel:cellModel];
    } else if ([cellModel isKindOfClass:[ASCTableViewSpellSearchResultCellModel class]]) {
        return [ASCTableViewRelatedSearchResultCell intrinsicHeightForWidth:width cellModel:cellModel];
    }
    
    return 0;
}

- (void)parseCellAttributes {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
}

@end
