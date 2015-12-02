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
@property   UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation ASCAsyncImageView

- (instancetype)init {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped)];
        self.tapGestureRecognizer.numberOfTapsRequired = 1;
        
        [self addGestureRecognizer:self.tapGestureRecognizer];
    }
    
    return self;
}

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
    self.imageLoader.delegate = self;

    [self.imageLoader startLoad];
}

- (void)loaderDidFinishLoadWithSuccess:(ASCLoader *)loader {
    __weak ASCAsyncImageView *weakSelf = self;
     
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            weakSelf.image = (UIImage *)weakSelf.imageLoader.parsedResult;
        } completion:nil];
    });
}

- (void)loader:(ASCLoader *)loader didFinishWithFailure:(NSError *)error {
    // do something here
}

- (void)imageTapped {
    if ([self.delegate respondsToSelector:@selector(imageViewTapped:)]) {
        [self.delegate imageViewTapped:self];
    }
}

- (void)scaleToWidth:(CGFloat)width {
    CGFloat oldWidth = self.imageSize.width;
    CGFloat oldHeight = self.imageSize.height;
    
    CGFloat scaleFactor = width / oldWidth;
    
    CGFloat newHeight = oldHeight * scaleFactor;
    CGFloat newWidth = oldWidth * scaleFactor;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    self.imageSize = newSize;
}

@end
