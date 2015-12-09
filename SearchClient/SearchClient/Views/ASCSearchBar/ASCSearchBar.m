//
//  ASCSearchBar.m
//  SearchClient
//
//  Created by Alex Hill on 11/25/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchBar.h"
#import "ASCTextField.h"
#import "ASCCollectionView.h"
#import "ASCCollectionViewCell.h"

@interface ASCSearchBar ()

@property (nonatomic, assign) BOOL isFirstLayout;
@property UIView *sliderView;

@end

@implementation ASCSearchBar

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.isFirstLayout = YES;
    
    self.textField = [[ASCTextField alloc] init];
    self.textField.horizontalPadding = 10.0;
    self.textField.cancelButtonColor = [UIColor darkGrayColor];
    [self.textField setFont:[UIFont systemFontOfSize:16.]];
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.textField];
    
    self.dividerView = [[UIView alloc] init];
    self.dividerView.backgroundColor = [UIColor colorWithRed:216./255. green:216./255. blue:216./255. alpha:1];
    self.dividerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.dividerView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[ASCCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.collectionView];
    
    self.sliderView = [[UIView alloc] init];
    self.sliderView.backgroundColor = [UIColor googleBlueColor];
    
    [self.collectionView addSubview:self.sliderView];
    
    self.layer.cornerRadius = 1.5;
    self.layer.masksToBounds = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isFirstLayout) {
        [self.textField asc_pinEdge:NSLayoutAttributeTop toParentEdge:NSLayoutAttributeTop constant:0.];
        [self.textField asc_pinEdge:NSLayoutAttributeLeft toParentEdge:NSLayoutAttributeLeft constant:0.];
        [self.textField asc_pinEdge:NSLayoutAttributeRight toParentEdge:NSLayoutAttributeRight constant:0.];
        [self.textField asc_setAttribute:NSLayoutAttributeHeight toConstant:50.];
        
        [self.dividerView asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom ofSibling:self.textField constant:0.];
        [self.dividerView asc_pinEdge:NSLayoutAttributeLeft toParentEdge:NSLayoutAttributeLeft constant:0.];
        [self.dividerView asc_pinEdge:NSLayoutAttributeRight toParentEdge:NSLayoutAttributeRight constant:0.];
        [self.dividerView asc_setAttribute:NSLayoutAttributeHeight toConstant:0.5];
        
        [self.collectionView asc_pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom ofSibling:self.dividerView constant:0.];
        [self.collectionView asc_pinEdge:NSLayoutAttributeLeft toParentEdge:NSLayoutAttributeLeft constant:0.];
        [self.collectionView asc_pinEdge:NSLayoutAttributeRight toParentEdge:NSLayoutAttributeRight constant:0.];
        [self.collectionView asc_setAttribute:NSLayoutAttributeHeight toConstant:40.];
        
        self.isFirstLayout = NO;
    }
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(self.bounds.size.width, self.collectionView.hidden?50:90.5);
}

- (void)updateSliderPositionToOffset:(CGFloat)offset withWidth:(CGFloat)width {
    self.sliderView.frame = CGRectMake(offset, 38., width, 2.);
}

- (void)updateSliderPositionToOffset:(CGFloat)offset indexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    ASCCollectionViewCell *cell = (ASCCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    self.selectedIndex = indexPath.row;
    
    __weak ASCSearchBar *weakSelf = self;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.sliderView.frame = CGRectMake(offset, cell.frame.size.height - 2., cell.frame.size.width, 2.);
        }];
    } else {
        self.sliderView.frame = CGRectMake(offset, cell.frame.size.height - 2., cell.frame.size.width, 2.);
    }
    
    if ([self.delegate respondsToSelector:@selector(searchBar:didChangeToSearchOptionIndex:)]) {
        [self.delegate searchBar:self didChangeToSearchOptionIndex:indexPath.row];
    }
}

@end
