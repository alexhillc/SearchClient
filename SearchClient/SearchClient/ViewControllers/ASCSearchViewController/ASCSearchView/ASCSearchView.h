//
//  ASCSearchView.h
//  SearchClient
//
//  Created by Alex Hill on 10/19/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASCSearchView, ASCTableView, ASCTextField;

extern NSTimeInterval const ASCSearchViewAnimationDuration;

@interface ASCSearchView : UIView

@property ASCTextField *searchTextField;
@property ASCTableView *searchTableView;
@property (nonatomic) UILabel *titleLabelPrimary;
@property (nonatomic) UILabel *titleLabelSecondary;

- (void)expandToKeyboardHeight:(CGFloat)keyboardHeight;
- (void)contract;
- (BOOL)isSearching;

@end
