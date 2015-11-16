//
//  ASCSearchView.h
//  SearchClient
//
//  Created by Alex Hill on 10/19/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASCSearchView, ASCTableView, ASCTextField;

typedef NS_ENUM(NSInteger, ASCSearchViewSearchState) {
    ASCSearchViewSearchStateInactive,
    ASCSearchViewSearchStateActive
};

@interface ASCSearchView : UIView

@property ASCTextField *searchTextField;
@property ASCTableView *tableView;
@property (nonatomic) UILabel *titleLabelPrimary;
@property (nonatomic) UILabel *titleLabelSecondary;
@property (nonatomic, readonly) ASCSearchViewSearchState state;

- (void)expandToKeyboardHeight:(CGFloat)keyboardHeight;
- (void)contract;

@end
