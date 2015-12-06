//
//  ASCImageLoader.m
//  SearchClient
//
//  Created by Alex Hill on 11/28/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCImageLoader.h"

@implementation ASCImageLoader

- (ASCLoaderType)type {
    return ASCLoaderTypeImage;
}

- (void)createRequest {
    self.requestUrl = [self.requestParameters objectForKey:@"imageUrl"];
}

- (void)processResponse {
    UIImage *resultImage = [UIImage imageWithData:self.responseData];

    if (resultImage) {
        self.parsedResult = resultImage;
        [self informDelegateLoadingFinished];
    } else {
        [self informDelegateLoadingFailed:[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCannotParseResponse userInfo:nil]];
    }
}

@end
