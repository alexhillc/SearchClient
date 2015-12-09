//
//  ASCViewController.m
//  SearchClient
//
//  Created by Alex Hill on 10/27/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCViewController.h"
#import "ASCView.h"
#import "ASCTableViewSearchHistoryCell.h"
#import "ASCCollectionViewCell.h"
#import "ASCCollectionView.h"

NSString * const ASCCollectionViewCachedWidthsStringFormat = @"cachedwidth%ld";

@interface ASCViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ASCSearchBarDelegate>

@property (nonatomic, strong) NSArray *searchOptions;

@end

@implementation ASCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.cachedCollectionViewCellWidths) {
        self.cachedCollectionViewCellWidths = [[NSMutableDictionary alloc] init];
    }
    
    self.searchHistoryTableViewDD = [[ASCSearchHistoryTableViewDelegateAndDatasource alloc] init];
    self.searchHistoryTableViewDD.vc = self;
    self.searchHistoryViewModel.delegate = self;
    
    self.ascView.searchHistoryTableView.delegate = self.searchHistoryTableViewDD;
    self.ascView.searchHistoryTableView.dataSource = self.searchHistoryTableViewDD;
    [self.ascView.searchHistoryTableView registerClass:[ASCTableViewSearchHistoryCell class] forCellReuseIdentifier:ASCTableViewSearchCellIdentifier];
    
    self.ascView.searchBar.textField.delegate = self;
    self.ascView.searchBar.delegate = self;
    self.ascView.searchBar.collectionView.delegate = self;
    self.ascView.searchBar.collectionView.dataSource = self;
    [self.ascView.searchBar.collectionView registerClass:[ASCCollectionViewCell class] forCellWithReuseIdentifier:ASCCollectionViewCellReuseIdentifier];
    
    self.searchOptions = [[NSArray alloc] initWithObjects:@"WEB", @"IMAGES", @"NEWS", @"VIDEOS", @"RELATED+SPELLING", nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.searchHistoryViewModel loadSearchHistory];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if (self.ascView.isFirstLayout) {
        ASCCollectionViewCell *sliderSizingCell = [[ASCCollectionViewCell alloc] init];
        sliderSizingCell.textLabel.text = [self.searchOptions objectAtIndex:self.ascView.searchBar.selectedIndex];
        CGFloat width = sliderSizingCell.intrinsicContentSize.width;
        
        __block CGFloat totalOffset = 0;
        
        for (int i = 0; i < self.ascView.searchBar.selectedIndex; ++i) {
            totalOffset += [[self.cachedCollectionViewCellWidths objectForKey:[NSString stringWithFormat:ASCCollectionViewCachedWidthsStringFormat,
                                                                               (long)i]] floatValue];
        }
        
        [self.ascView.searchBar updateSliderPositionToOffset:totalOffset withWidth:width];
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    [self.ascView updateLayoutWithOrientation:size];
}

#pragma mark - UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ASCCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[ASCCollectionViewCell alloc] init];
    }
    
    cell.textLabel.text = [self.searchOptions objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.searchOptions.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = collectionView.frame.size.height;
    CGFloat width = 0;
    if (![self.cachedCollectionViewCellWidths objectForKey:[NSString stringWithFormat:ASCCollectionViewCachedWidthsStringFormat, (long)indexPath.row]]) {
        ASCCollectionViewCell *sizingCell = [[ASCCollectionViewCell alloc] init];
        sizingCell.textLabel.text = [self.searchOptions objectAtIndex:indexPath.row];
        
        width = sizingCell.intrinsicContentSize.width;
        [self.cachedCollectionViewCellWidths setObject:@(width) forKey:[NSString stringWithFormat:ASCCollectionViewCachedWidthsStringFormat,
                                                                        (long)indexPath.row]];
        
    } else {
        width = [[self.cachedCollectionViewCellWidths objectForKey:[NSString stringWithFormat:ASCCollectionViewCachedWidthsStringFormat,
                                                                    (long)indexPath.row]] floatValue];
    }
    
    return CGSizeMake(width, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
                            minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    ASCCollectionViewCell *cell = (ASCCollectionViewCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    [cell.textLabel setTextColor:[UIColor redColor]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    __block CGFloat totalOffset = 0;
    
    NSInteger i;
    for (i = 0; i < indexPath.row; ++i) {
        totalOffset += [[self.cachedCollectionViewCellWidths objectForKey:[NSString stringWithFormat:ASCCollectionViewCachedWidthsStringFormat,
                                                                           (long)i]] floatValue];
    }
    
    [self.ascView.searchBar updateSliderPositionToOffset:totalOffset indexPath:indexPath animated:YES];
}

- (void)presentViewControllerWithQuery:(NSString *)query {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

@end
