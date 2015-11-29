//
//  ASCSearchBar.h
//  SearchClient
//
//  Created by Alex Hill on 11/25/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASCTextField, ASCCollectionView, ASCSearchBar;

@protocol ASCSearchBarDelegate <NSObject>

@optional
- (void)searchBar:(ASCSearchBar *)searchBar didChangeToSearchOptionIndex:(NSInteger)idx;

@end

@interface ASCSearchBar : UIView

@property (nonatomic, weak) id<ASCSearchBarDelegate> delegate;
@property ASCTextField *textField;
@property UIView *dividerView;
@property ASCCollectionView *collectionView;

- (void)updateSliderPositionToOffset:(CGFloat)offset withSize:(CGSize)size;
- (void)updateSliderPositionToOffset:(CGFloat)offset indexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

@end
