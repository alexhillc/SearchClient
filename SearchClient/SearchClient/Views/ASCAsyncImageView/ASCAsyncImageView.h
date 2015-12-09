//
//  ASCAsyncImageView.h
//  SearchClient
//
//  Created by Alex Hill on 11/28/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASCAsyncImageView;

/**
 * @brief A delegate that is capable of telling the responder if the view is tapped
 */
@protocol ASCAsyncImageViewDelegate <NSObject>

@optional
- (void)imageViewTapped:(ASCAsyncImageView *)imageView;

@end

@interface ASCAsyncImageView : UIImageView

@property (nonatomic, weak) id<ASCAsyncImageViewDelegate> delegate;
@property (nonatomic) NSURL *imageUrl;
@property (nonatomic) CGSize imageSize;
@property (nonatomic) NSURL *largeImageUrl;
@property (nonatomic) CGSize largeImageSize;

@end
