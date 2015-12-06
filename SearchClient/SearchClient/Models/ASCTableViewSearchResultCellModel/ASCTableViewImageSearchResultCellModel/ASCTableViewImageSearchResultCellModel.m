//
//  ASCTableViewImageSearchResultCellModel.m
//  SearchClient
//
//  Created by Alex Hill on 12/3/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewImageSearchResultCellModel.h"
#import "ASCImageSearchResultModel.h"

@implementation ASCTableViewImageSearchResultCellModel

- (instancetype)initWithModels:(NSArray *)models {
    if (self = [[ASCTableViewImageSearchResultCellModel alloc] init]) {
        NSAssert(models.count <= 3, @"Invalid model capacity");
        if (models.count <= 3) {
            ASCImageSearchResultModel *firstModel = [models objectAtIndex:0];
            ASCImageSearchResultModel *secondModel = [models objectAtIndex:1];
            ASCImageSearchResultModel *thirdModel = [models objectAtIndex:2];
            
            NSAssert([firstModel isKindOfClass:[ASCImageSearchResultModel class]], @"Invalid class type");
            if ([firstModel isKindOfClass:[ASCImageSearchResultModel class]]) {
                self.imgSizeFirst = firstModel.imgSize;
                self.imgUrlFirst = firstModel.imgUrl;
                self.thumbImgUrlFirst = firstModel.thumbImgUrl;
                self.thumbSizeFirst = firstModel.thumbSize;
                
                self.imgSizeSecond = secondModel.imgSize;
                self.imgUrlSecond = secondModel.imgUrl;
                self.thumbImgUrlSecond = secondModel.thumbImgUrl;
                self.thumbSizeSecond = secondModel.thumbSize;
                
                self.imgSizeThird = thirdModel.imgSize;
                self.imgUrlThird = thirdModel.imgUrl;
                self.thumbImgUrlThird = thirdModel.thumbImgUrl;
                self.thumbSizeThird = thirdModel.thumbSize;
            }
        }
    }
    
    return self;
}

- (instancetype)initWithModel:(ASCSearchResultModel *)model {
    [NSException raise:NSInternalInconsistencyException
                format:@"This should never happen. Don't call %@ here.", NSStringFromSelector(_cmd)];
    
    return nil;
}

@end
