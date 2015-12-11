//
//  ASCSearchResultsTableViewDelegate.m
//  SearchClient
//
//  Created by Alex Hill on 11/17/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchResultsTableViewDelegateAndDatasource.h"
#import "ASCTableViewWebSearchResultCell.h"
#import "ASCTableViewImageSearchResultCell.h"
#import "ASCTableViewNewsSearchResultCell.h"
#import "ASCTableViewSpellSearchResultCell.h"
#import "ASCTableViewVideoSearchResultCell.h"
#import "ASCTableViewRelatedSearchResultCell.h"
#import "ASCSearchResultsViewModel.h"
#import "ASCSearchResultsViewController.h"

@implementation ASCSearchResultsTableViewDelegateAndDatasource

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASCTableViewSearchResultCellModel *cellModel = [self.vc.searchResultsViewModel.data objectAtIndex:indexPath.section];
    
    ASCTableViewSearchResultCell *cell = nil;
    if ([cellModel isKindOfClass:[ASCTableViewWebSearchResultCellModel class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:ASCTableViewWebSearchResultCellIdentifier];
        
        if (!cell) {
            cell = [[ASCTableViewWebSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:ASCTableViewWebSearchResultCellIdentifier];
        }
    } else if ([cellModel isKindOfClass:[ASCTableViewImageSearchResultCellModel class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:ASCTableViewImageSearchResultCellIdentifier];
        
        if (!cell) {
            cell = [[ASCTableViewImageSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:ASCTableViewImageSearchResultCellIdentifier];
        }
        
        cell.asyncImageViewFirst.delegate = self.vc;
        cell.asyncImageViewSecond.delegate = self.vc;
        cell.asyncImageViewThird.delegate = self.vc;
        
    } else if ([cellModel isKindOfClass:[ASCTableViewNewsSearchResultCellModel class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:ASCTableViewNewsSearchResultCellIdentifier];
        
        if (!cell) {
            cell = [[ASCTableViewNewsSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:ASCTableViewNewsSearchResultCellIdentifier];
        }
    } else if ([cellModel isKindOfClass:[ASCTableViewSpellSearchResultCellModel class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:ASCTableViewSpellSearchResultCellIdentifier];
        
        if (!cell) {
            cell = [[ASCTableViewSpellSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:ASCTableViewSpellSearchResultCellIdentifier];
        }
    } else if ([cellModel isKindOfClass:[ASCTableViewVideoSearchResultCellModel class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:ASCTableViewVideoSearchResultCellIdentifier];
        
        if (!cell) {
            cell = [[ASCTableViewVideoSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:ASCTableViewVideoSearchResultCellIdentifier];
        }
    } else if ([cellModel isKindOfClass:[ASCTableViewRelatedSearchResultCellModel class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:ASCTableViewRelatedSearchResultCellIdentifier];
        
        if (!cell) {
            cell = [[ASCTableViewRelatedSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:ASCTableViewRelatedSearchResultCellIdentifier];
        }
    }
    
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    cell.titleLabel.delegate = self.vc;
    cell.cellModel = cellModel;
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > 0) {
        scrollView.bounces = YES;
    } else {
        scrollView.bounces = NO;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.vc.searchResultsViewModel.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 7.;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cachedCellHeight = [[self.vc.cachedResultsTableViewCellHeights objectForKey:
                                [NSString stringWithFormat:ASCSearchResultsTableViewCachedCellHeightsStringFormat, indexPath]] floatValue];
    if (!cachedCellHeight) {
        ASCTableViewSearchResultCellModel *cellModel = [self.vc.searchResultsViewModel.data objectAtIndex:indexPath.section];
        cachedCellHeight = [ASCTableViewSearchResultCell intrinsicHeightForWidth:tableView.frame.size.width cellModel:cellModel];
        [self.vc.cachedResultsTableViewCellHeights setObject:@(cachedCellHeight)
                                                      forKey:[NSString stringWithFormat:ASCSearchResultsTableViewCachedCellHeightsStringFormat,
                                                              indexPath]];
        
    }
    
    return cachedCellHeight;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
