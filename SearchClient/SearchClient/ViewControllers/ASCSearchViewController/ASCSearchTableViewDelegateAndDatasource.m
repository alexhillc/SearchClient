//
//  ASCSearchTableViewDelegate.m
//  SearchClient
//
//  Created by Alex Hill on 11/17/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchTableViewDelegateAndDatasource.h"
#import "ASCSearchViewModel.h"
#import "ASCTableViewSearchCell.h"

@implementation ASCSearchTableViewDelegateAndDatasource

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASCTableViewSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:ASCTableViewSearchCellIdentifier];
    if (!cell) {
        cell = [[ASCTableViewSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ASCTableViewSearchCellIdentifier];
    }
    
    cell.textLabel.text = [self.viewModel.searchHistoryData objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.searchHistoryData.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(ddDelegate:didSelectText:)]) {
        [self.delegate ddDelegate:self didSelectText:[self.viewModel.searchHistoryData objectAtIndex:indexPath.row]];
    }
}

@end
