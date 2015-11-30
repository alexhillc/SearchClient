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

@property (nonatomic, weak) ASCView *ascView;
@property (nonatomic, strong) NSMutableDictionary *cachedCollectionViewCellWidths;
@property (nonatomic, strong) NSArray *searchOptions;

@end

@implementation ASCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ascView = (ASCView *)self.view;
    
    self.cachedCollectionViewCellWidths = [[NSMutableDictionary alloc] init];
    
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
    
    [self.searchHistoryViewModel loadSearchHistory];

    self.searchOptions = [[NSArray alloc] initWithObjects:@"WEB", @"IMAGES", @"NEWS", @"SHOPPING", @"VIDEOS", @"BOOKS", nil];
    
    ASCCollectionViewCell *sliderSizingCell = [[ASCCollectionViewCell alloc] init];
    sliderSizingCell.textLabel.text = [self.searchOptions objectAtIndex:0];

    CGFloat height = 30.;
    CGFloat width = sliderSizingCell.intrinsicContentSize.width;
    [self.ascView.searchBar updateSliderPositionToOffset:0. withSize:CGSizeMake(width, height)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak ASCViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.ascView.searchBar updateSliderPositionToOffset:0. indexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO];
    });
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.view setNeedsUpdateConstraints];
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    __block CGFloat totalOffset = 0;
    
    NSInteger i;
    for (i = 0; i < indexPath.row; ++i) {
        totalOffset += [[self.cachedCollectionViewCellWidths objectForKey:[NSString stringWithFormat:ASCCollectionViewCachedWidthsStringFormat,
                                                                           i]] floatValue];
    }
    
    [self.ascView.searchBar updateSliderPositionToOffset:totalOffset indexPath:indexPath animated:YES];
}

@end
