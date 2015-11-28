//
//  ASCSearchBar.h
//  SearchClient
//
//  Created by Alex Hill on 11/25/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASCTextField, ASCCollectionView;

@interface ASCSearchBar : UIView

@property (strong) ASCTextField *textField;
@property (strong) UIView *dividerView;
@property (strong) ASCCollectionView *collectionView;

- (void)updateSliderPositionToOffset:(CGFloat)offset withSize:(CGSize)size;
- (void)updateSliderPositionToOffset:(CGFloat)offset indexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

@end
