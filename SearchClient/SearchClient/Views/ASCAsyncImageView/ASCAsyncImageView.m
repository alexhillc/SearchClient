//
//  ASCAsyncImageView.m
//  SearchClient
//
//  Created by Alex Hill on 11/28/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCAsyncImageView.h"
#import "ASCImageLoader.h"

@interface ASCAsyncImageView () <ASCLoaderDelegate>

@property ASCImageLoader *imageLoader;

@end

@implementation ASCAsyncImageView

- (void)setImageUrl:(NSURL *)imageUrl {
    if (!imageUrl) {
        [self.imageLoader cancelLoad];
        self.image = nil;
        _imageUrl = nil;
        
        return;
    }
    
    self.image = nil;
    _imageUrl = imageUrl;
    
    self.imageLoader = [[ASCImageLoader alloc] initWithDelegate:self];
    self.imageLoader.requestParameters = [NSDictionary dictionaryWithObject:imageUrl forKey:@"imageUrl"];

    [self.imageLoader startLoad];
}

- (void)loaderDidFinishLoadWithSuccess:(ASCLoader *)loader {
    self.image = (UIImage *)self.imageLoader.parsedResult;
}

- (void)loader:(ASCLoader *)loader didFinishWithFailure:(NSError *)error {
    
}

@end
