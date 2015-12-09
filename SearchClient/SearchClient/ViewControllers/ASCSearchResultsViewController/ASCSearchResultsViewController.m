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

NSString * const ASCSearchResultsTableViewCachedCellHeightsStringFormat = @"cachedheight%@";

@interface ASCSearchResultsViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) ASCSearchResultsView *searchResultsView;
@property CGPoint originalCenter;

@end

@implementation ASCSearchResultsViewController

- (void)loadView {    
    self.view = [[ASCSearchResultsView alloc] init];
    self.searchResultsView = (ASCSearchResultsView *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    recognizer.minimumNumberOfTouches = 1;
    recognizer.maximumNumberOfTouches = 1;
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];
    
    self.cachedResultsTableViewCellHeights = [[NSMutableDictionary alloc] init];
    
    self.searchResultsTableViewDD = [[ASCSearchResultsTableViewDelegateAndDatasource alloc] init];
    self.searchResultsTableViewDD.vc = self;
    self.searchResultsView.searchResultsTableView.delegate = self.searchResultsTableViewDD;
    self.searchResultsView.searchResultsTableView.dataSource = self.searchResultsTableViewDD;

    self.searchResultsViewModel.delegate = self;
    
    [self.searchResultsView.searchResultsTableView registerClass:[ASCTableViewWebSearchResultCell class] forCellReuseIdentifier:ASCTableViewWebSearchResultCellIdentifier];
    [self.searchResultsView.searchResultsTableView registerClass:[ASCTableViewImageSearchResultCell class] forCellReuseIdentifier:ASCTableViewImageSearchResultCellIdentifier];
    
    [self.searchResultsView startLoadingAnimation];
    [self.searchResultsViewModel loadResultsWithQueryType:ASCQueryTypeWeb];
    self.searchResultsView.searchBar.textField.text = self.searchResultsViewModel.query;
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

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

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

- (void)presentResults {
    __weak ASCSearchResultsViewController *weakSelf = self;
    
    if (self.searchResultsViewModel.queryType == ASCQueryTypeImage) {
        [UIView animateWithDuration:ASCViewAnimationDuration animations:^{
            weakSelf.searchResultsView.layer.backgroundColor = [UIColor blackColor].CGColor;
            weakSelf.searchResultsView.searchResultsTableView.layer.backgroundColor = [UIColor blackColor].CGColor;
        } completion:nil];
    } else {
        [UIView animateWithDuration:ASCViewAnimationDuration animations:^{
            weakSelf.searchResultsView.layer.backgroundColor = ASCViewBackgroundColor.CGColor;
            weakSelf.searchResultsView.searchResultsTableView.layer.backgroundColor = ASCViewBackgroundColor.CGColor;
        } completion:nil];
    }
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self.searchResultsView startLoadingAnimation];
    self.searchResultsView.searchBar.textField.text = self.searchResultsViewModel.query;
    
    [self.searchResultsView endEditing:YES];
    [self.searchResultsViewModel loadResultsWithQueryType:self.searchResultsViewModel.queryType];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *panRecognizer = (UIPanGestureRecognizer *)gestureRecognizer;
        
        if (self.searchResultsView.searchResultsTableView.contentOffset.y == 0 && [panRecognizer velocityInView:panRecognizer.view].y > 0) {
            return YES;
        }
    }
    
    return NO;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:recognizer.view];
    
    CGRect viewFrame = self.view.frame;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.originalCenter = recognizer.view.center;
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (translation.y < 0) {
            return;
        }
        
        recognizer.view.center = CGPointMake(recognizer.view.center.x, self.originalCenter.y + translation.y);
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        __weak ASCSearchResultsViewController *weakSelf = self;
        
        if (viewFrame.origin.y > viewFrame.size.height / 4) {
            viewFrame.origin.y = viewFrame.size.height;
        } else {
            viewFrame.origin.y = 0;
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.view.frame = viewFrame;
        } completion:^(BOOL finished) {
            if (weakSelf.view.frame.origin.y == weakSelf.view.frame.size.height) {
                [weakSelf dismissViewControllerAnimated:NO completion:nil];
            }
        }];
    }
}

#pragma mark - ASCTextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.searchResultsViewModel.query = textField.text;
    [self presentResults];
    
    return YES;
}

- (void)textFieldDidCancel:(ASCTextField *)textField {
    [textField endEditing:YES];
}

#pragma mark - ASCViewModelDelegate
- (void)viewModelDidReceiveNewDataSet:(ASCViewModel *)viewModel {
    if ([viewModel isKindOfClass:[ASCSearchHistoryViewModel class]]) {
        [self.searchResultsView.searchHistoryTableView reloadData];
    } else if ([viewModel isKindOfClass:[ASCSearchResultsViewModel class]]) {
        [self.cachedResultsTableViewCellHeights removeAllObjects];

        __weak ASCSearchResultsViewController *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.searchResultsView.searchResultsTableView reloadData];
            [weakSelf.searchResultsView.searchResultsTableView setContentOffset:CGPointZero];
            [weakSelf.searchResultsView stopLoadingAnimation];
        });
    }
}

#pragma mark - Notifications
- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    __weak ASCSearchResultsViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.searchResultsView expandToHeight:keyboardSize.height completion:nil];
    });
}

- (void)keyboardWillHide:(NSNotification *)notification {
    __weak ASCSearchResultsViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.searchResultsView contract];
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
    imageInfo.referenceRect = imageView.frame;
    imageInfo.referenceView = imageView.superview;
    
    JTSImageViewController *imageViewController = [[JTSImageViewController alloc] initWithImageInfo:imageInfo
                                                                                               mode:JTSImageViewControllerMode_Image
                                                                                    backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    [imageViewController showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
}

@end
