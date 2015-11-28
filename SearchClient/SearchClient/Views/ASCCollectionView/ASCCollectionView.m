//
//  ASCCollectionView.m
//  SearchClient
//
//  Created by Alex Hill on 11/27/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCCollectionView.h"

@implementation ASCCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor colorWithRed:243./255. green:243./255. blue:243./255. alpha:1];
    self.showsHorizontalScrollIndicator = NO;
}

@end
