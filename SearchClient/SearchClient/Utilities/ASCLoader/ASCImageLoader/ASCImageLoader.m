//
//  ASCImageLoader.m
//  SearchClient
//
//  Created by Alex Hill on 11/28/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCImageLoader.h"

@interface ASCImageLoader ()

@end

@implementation ASCImageLoader

- (ASCLoaderType)type {
    return ASCLoaderTypeImage;
}

- (void)createRequest {
    self.request = [self.requestParameters objectForKey:@"imageUrl"];
}

- (void)processResponse {
    UIImage *result = (UIImage *)self.responseObject;
    
    if (result) {
        self.parsedResult = result;
        [self informDelegateLoadingFinished];
    } else {
        [self informDelegateLoadingFailed:[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorDataNotAllowed userInfo:nil]];
    }
}

- (void)prepareForLoad {
    [super prepareForLoad];
    
    self.operation.responseSerializer = [AFImageResponseSerializer serializer];
}

@end
