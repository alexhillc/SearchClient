//
//  ASCSearchResultsViewController.m
//  SearchClient
//
//  Created by Alex Hill on 11/20/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCSearchResultsViewController.h"
#import "ASCSearchResultsView.h"
#import "ASCSearchResultsTableViewDelegateAndDatasource.h"
#import "ASCSearchResultsViewModel.h"
#import "ASCTextField.h"
#import "ASCTableViewWebSearchResultCell.h"
#import "ASCTableViewImageSearchResultCell.h"
#import "ASCTableViewSearchResultCell.h"
#import "ASCTableViewSearchHistoryCell.h"
#import "JTSImageViewController.h"
#import "ASCTableView.h"
#import <SafariServices/SafariServices.h>
#import "ASCCoverViewController.h"

NSString * const ASCSearchResultsTableViewCachedCellHeightsStringFormat = @"cachedheight%@";

@interface ASCSearchResultsViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) ASCSearchResultsView *ascView;
@property CGPoint originalCenter;
@property UIPanGestureRecognizer *recognizer;

@end

@implementation ASCSearchResultsViewController

@dynamic ascView;

- (void)loadView {    
    self.view = [[UIView alloc] init];
    
    self.ascView = [[ASCSearchResultsView alloc] init];
    self.ascView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.ascView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    self.recognizer.minimumNumberOfTouches = 1;
    self.recognizer.maximumNumberOfTouches = 1;
    self.recognizer.delegate = self;
    [self.ascView addGestureRecognizer:self.recognizer];
    
    self.cachedResultsTableViewCellHeights = [[NSMutableDictionary alloc] init];
    
    self.searchResultsTableViewDD = [[ASCSearchResultsTableViewDelegateAndDatasource alloc] init];
    self.searchResultsTableViewDD.vc = self;
    self.ascView.searchResultsTableView.delegate = self.searchResultsTableViewDD;
    self.ascView.searchResultsTableView.dataSource = self.searchResultsTableViewDD;

    self.searchResultsViewModel.delegate = self;
    
    [self.ascView.searchResultsTableView registerClass:[ASCTableViewWebSearchResultCell class] forCellReuseIdentifier:ASCTableViewWebSearchResultCellIdentifier];
    [self.ascView.searchResultsTableView registerClass:[ASCTableViewImageSearchResultCell class] forCellReuseIdentifier:ASCTableViewImageSearchResultCellIdentifier];
    
    [self presentResults];    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if (self.ascView.isFirstLayout) {
        [self.ascView asc_fillSuperview];
        
        CGRect snapshotFrame = self.snapshotView.frame;
        snapshotFrame.size.width = self.view.frame.size.width / 1.15;
        snapshotFrame.size.height = self.view.frame.size.height / 1.15;
        snapshotFrame.origin.x = (self.view.frame.size.width - snapshotFrame.size.width) / 2;
        snapshotFrame.origin.y = (self.view.frame.size.height - snapshotFrame.size.height) / 2;
        self.snapshotView.frame = snapshotFrame;
        
        [self.view insertSubview:self.snapshotView belowSubview:self.ascView];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [self.cachedResultsTableViewCellHeights removeAllObjects];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.searchResultsViewModel.queryType == ASCQueryTypeImage) {
        return UIStatusBarStyleLightContent;
    }
    
    return UIStatusBarStyleDefault;
}

- (void)presentViewControllerWithQuery:(NSString *)query {
    ASCSearchHistoryViewModel *searchHistoryViewModel = [[ASCSearchHistoryViewModel alloc] init];
    ASCSearchResultsViewModel *searchResultsViewModel = [[ASCSearchResultsViewModel alloc] init];
    searchResultsViewModel.query = query;
    searchResultsViewModel.queryType = self.ascView.searchBar.selectedIndex;
    
    ASCSearchResultsViewController *searchResultsViewController = [[ASCSearchResultsViewController alloc] init];
    searchResultsViewController.searchResultsViewModel = searchResultsViewModel;
    searchResultsViewController.searchHistoryViewModel = searchHistoryViewModel;
    searchResultsViewController.snapshotView = self.presentedViewControllerSnapshotView;
    searchResultsViewController.cachedCollectionViewCellWidths = self.cachedCollectionViewCellWidths;
    
    self.ascView.searchBar.textField.text = query;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    __weak ASCSearchResultsViewController *weakSelf = self;
    [self.ascView hideSearchHistoryTableViewAnimated:YES completion:^{
        [weakSelf presentViewController:searchResultsViewController animated:NO completion:^{
            weakSelf.ascView.searchBar.textField.text = weakSelf.searchResultsViewModel.query;
            weakSelf.ascView.searchResultsTableView.alpha = 1;
        }];
    }];
}

- (void)presentResults {
    __weak ASCSearchResultsViewController *weakSelf = self;
    
    if (self.searchResultsViewModel.queryType == ASCQueryTypeImage) {
        [UIView animateWithDuration:ASCViewAnimationDuration animations:^{
            weakSelf.ascView.layer.backgroundColor = [UIColor blackColor].CGColor;
            weakSelf.ascView.searchResultsTableView.layer.backgroundColor = [UIColor blackColor].CGColor;
        } completion:nil];
    } else {
        [UIView animateWithDuration:ASCViewAnimationDuration animations:^{
            weakSelf.ascView.layer.backgroundColor = ASCViewBackgroundColor.CGColor;
            weakSelf.ascView.searchResultsTableView.layer.backgroundColor = ASCViewBackgroundColor.CGColor;
        } completion:nil];
    }
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self.ascView startLoadingAnimation];
    self.ascView.searchBar.textField.text = self.searchResultsViewModel.query;
    self.ascView.searchBar.selectedIndex = self.searchResultsViewModel.queryType;
    
    [self.ascView endEditing:YES];
    [self.searchResultsViewModel loadResultsWithQueryType:self.searchResultsViewModel.queryType];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *panRecognizer = (UIPanGestureRecognizer *)gestureRecognizer;
        
        if (self.ascView.searchResultsTableView.contentOffset.y == 0 && [panRecognizer velocityInView:panRecognizer.view].y > 0) {
            return YES;
        }
    }
    
    return NO;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:recognizer.view];
    
    CGRect viewFrame = self.ascView.frame;
    
    // We need the original center to calculate the total translation
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.originalCenter = recognizer.view.center;
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // Limit the user's actions
        if (translation.y < 0) {
            return;
        }
        
        // Set the new center based on the translation
        recognizer.view.center = CGPointMake(recognizer.view.center.x, self.originalCenter.y + translation.y);

        CGFloat percentMoved = recognizer.view.frame.origin.y / recognizer.view.frame.size.height;
        CGFloat percentageHeight = percentMoved * (self.view.frame.size.height - (self.view.frame.size.height / 1.15)) + (self.view.frame.size.height / 1.15);
        CGFloat percentageWidth = percentMoved * (self.view.frame.size.width - (self.view.frame.size.width / 1.15)) + (self.view.frame.size.width / 1.15);
        
        // Based on the percentage the view moved, move the snapshot view
        CGRect snapshotFrame = self.snapshotView.frame;
        snapshotFrame.size.width = percentageWidth;
        snapshotFrame.size.height = percentageHeight;
        snapshotFrame.origin.x = (self.view.frame.size.width - snapshotFrame.size.width) / 2;
        snapshotFrame.origin.y = (self.view.frame.size.height - snapshotFrame.size.height) / 2;
        self.snapshotView.frame = snapshotFrame;
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        __weak ASCSearchResultsViewController *weakSelf = self;
        
        // Now that the user has stopped moving, we can animate the frame to the location it needs
        // to be in
        CGRect snapshotFrame = self.snapshotView.frame;
        if (viewFrame.origin.y > viewFrame.size.height / 4) {
            viewFrame.origin.y = viewFrame.size.height;
            
            snapshotFrame.size.width = self.view.frame.size.width;
            snapshotFrame.size.height = self.view.frame.size.height;
            snapshotFrame.origin.x = self.view.frame.origin.x;
            snapshotFrame.origin.y = self.view.frame.origin.y;
        } else {
            viewFrame.origin.y = 0;
            
            snapshotFrame.size.width = self.view.frame.size.width / 1.15;
            snapshotFrame.size.height = self.view.frame.size.height / 1.15;
            snapshotFrame.origin.x = (self.view.frame.size.width - snapshotFrame.size.width) / 2;
            snapshotFrame.origin.y = (self.view.frame.size.height - snapshotFrame.size.height) / 2;
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.ascView.frame = viewFrame;
            weakSelf.snapshotView.frame = snapshotFrame;
        } completion:^(BOOL finished) {
            if (weakSelf.ascView.frame.origin.y == weakSelf.ascView.frame.size.height) {
                // Finally, dismiss the view controller
                [weakSelf.ascView removeFromSuperview];
                [weakSelf dismissViewControllerAnimated:NO completion:nil];
            }
        }];
    }
}

#pragma mark - ASCTextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self presentViewControllerWithQuery:textField.text];
    
    return YES;
}

- (void)textFieldDidCancel:(ASCTextField *)textField {
    [textField endEditing:YES];
}

#pragma mark - ASCViewModelDelegate
- (void)viewModelDidReceiveNewDataSet:(ASCViewModel *)viewModel {
    if ([viewModel isKindOfClass:[ASCSearchHistoryViewModel class]]) {
        [self.ascView.searchHistoryTableView reloadData];
    } else if ([viewModel isKindOfClass:[ASCSearchResultsViewModel class]]) {
        [self.cachedResultsTableViewCellHeights removeAllObjects];

        __weak ASCSearchResultsViewController *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.ascView.searchResultsTableView reloadData];
            [weakSelf.ascView.searchResultsTableView setContentOffset:CGPointZero];
            [weakSelf.ascView stopLoadingAnimation];
            
            weakSelf.presentedViewControllerSnapshotView = [weakSelf.ascView snapshotViewAfterScreenUpdates:YES];
            weakSelf.presentedViewControllerSnapshotView.clipsToBounds = YES;
        });
    }
}

- (void)viewModelDidFailToLoadDataSet:(ASCViewModel *)viewModel error:(NSError *)error {
    if ([viewModel isKindOfClass:[ASCSearchResultsViewModel class]]) {
        __weak ASCSearchResultsViewController *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.ascView stopLoadingAnimation];
            
            // dispatch ahead another run loop, or else we run the risk of getting a blank snapshot
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.presentedViewControllerSnapshotView = [self.ascView snapshotViewAfterScreenUpdates:YES];
                weakSelf.presentedViewControllerSnapshotView.clipsToBounds = YES;
            });
        });
    }
}

#pragma mark - Notifications
- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    __weak ASCSearchResultsViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.ascView expandToHeight:keyboardSize.height completion:nil];
    });
}

- (void)keyboardWillHide:(NSNotification *)notification {
    __weak ASCSearchResultsViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.ascView contract];
    });
}

#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    if (NSClassFromString(@"SFSafariViewController") != Nil) {
        if ([url.scheme hasPrefix:@"http"]) {
            SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:url];
            [self presentViewController:safari animated:YES completion:nil];
            
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
        
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark - ASCSearchBarDelegate
- (void)searchBar:(ASCSearchBar *)searchBar didChangeToSearchOptionIndex:(NSInteger)idx {
    if (self.searchResultsViewModel.queryType != idx) {
        self.searchResultsViewModel.queryType = idx;
        [self presentResults];
    }
}

#pragma mark - JTSImageViewControllerDelegate
- (void)imageViewTapped:(ASCAsyncImageView *)imageView {
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.imageURL = imageView.largeImageUrl;
    imageInfo.placeholderImage = imageView.image;
    imageInfo.referenceRect = imageView.frame;
    imageInfo.referenceView = imageView.superview;
    
    JTSImageViewController *imageViewController = [[JTSImageViewController alloc] initWithImageInfo:imageInfo
                                                                                               mode:JTSImageViewControllerMode_Image
                                                                                    backgroundStyle:JTSImageViewControllerBackgroundOption_Blurred | JTSImageViewControllerBackgroundOption_Scaled];
    [imageViewController showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
}

@end
