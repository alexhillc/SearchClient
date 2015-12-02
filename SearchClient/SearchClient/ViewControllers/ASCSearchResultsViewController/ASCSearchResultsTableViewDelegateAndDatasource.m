//
//  ASCSearchResultsTableViewDelegate.m
//  SearchClient
//
//  Created by Alex Hill on 11/17/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchResultsTableViewDelegateAndDatasource.h"
#import "ASCTableViewSearchResultCell.h"
#import "ASCTableViewWebSearchResultCell.h"
#import "ASCTableViewImageSearchResultCell.h"
#import "ASCSearchResultsViewModel.h"
#import "ASCSearchResultsViewController.h"
#import "ASCWebSearchResultModel.h"
#import "ASCImageSearchResultModel.h"

@implementation ASCSearchResultsTableViewDelegateAndDatasource

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASCSearchResultModel *cellModel = [self.vc.searchResultsViewModel.data objectAtIndex:indexPath.section];
    
    ASCTableViewSearchResultCell *cell = nil;
    if ([cellModel isKindOfClass:[ASCWebSearchResultModel class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:ASCTableViewWebSearchResultCellIdentifier];
        
        if (!cell) {
            cell = [[ASCTableViewWebSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:ASCTableViewWebSearchResultCellIdentifier];
        }
    } else if ([cellModel isKindOfClass:[ASCImageSearchResultModel class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:ASCTableViewImageSearchResultCellIdentifier];
        
        if (!cell) {
            cell = [[ASCTableViewImageSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:ASCTableViewImageSearchResultCellIdentifier];
        }
        
        cell.asyncImageView.delegate = self.vc;
    }
    
    cell.titleLabel.delegate = self.vc;
    cell.cellModel = cellModel;
    
    return cell;
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
        ASCTableViewSearchResultCell *cell = (ASCTableViewSearchResultCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        cachedCellHeight = [cell intrinsicHeightForWidth:tableView.frame.size.width];
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
