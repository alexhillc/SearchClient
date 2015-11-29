//
//  ASCAsyncImageView.h
//  SearchClient
//
//  Created by Alex Hill on 11/28/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCAsyncImageView : UIImageView

@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic) CGSize imageSize;

@end
