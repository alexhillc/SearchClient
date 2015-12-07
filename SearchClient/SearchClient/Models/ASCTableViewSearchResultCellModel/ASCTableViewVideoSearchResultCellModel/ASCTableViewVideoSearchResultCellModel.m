//
//  ASCTableViewVideoSearchResultCellModel.m
//  SearchClient
//
//  Created by Alex Hill on 12/6/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewVideoSearchResultCellModel.h"
#import "ASCVideoSearchResultModel.h"

@implementation ASCTableViewVideoSearchResultCellModel

- (instancetype)initWithModels:(NSArray *)models {
    [NSException raise:NSInternalInconsistencyException
                format:@"This should never happen. Don't call %@ here.", NSStringFromSelector(_cmd)];
    
    return nil;
}

- (instancetype)initWithModel:(ASCSearchResultModel *)model {
    NSAssert([model isKindOfClass:[ASCVideoSearchResultModel class]], @"Invalid class type");
    if ([model isKindOfClass:[ASCVideoSearchResultModel class]]) {
        ASCVideoSearchResultModel *videoSearchModel = (ASCVideoSearchResultModel *)model;
        
        if (self = [[ASCTableViewVideoSearchResultCellModel alloc] init]) {
            self.titleLabelText = videoSearchModel.title;
            self.urlLabelText = [videoSearchModel.url absoluteString];
            self.url = videoSearchModel.url;
            self.thumbImgUrl = videoSearchModel.thumbImgUrl;
            self.thumbSize = videoSearchModel.thumbSize;
            
            NSInteger constant = [videoSearchModel.runTime integerValue] / 1000.;
            NSInteger seconds = constant % 60;
            constant /= 60;
            NSInteger minutes = constant % 60;
            constant /= 60;
            NSInteger hours = constant % 24;
            
            if (hours != 0 && minutes != 0) {
                self.runtimeLabelText = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
            } else {
                self.runtimeLabelText = [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
            }
        }
    }
    
    return self;
}

@end
