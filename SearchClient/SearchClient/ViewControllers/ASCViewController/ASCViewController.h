//
//  ASCViewController.h
//  SearchClient
//
//  Created by Alex Hill on 10/27/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASCSearchViewModel.h"
#import "ASCSearchTableViewDelegateAndDatasource.h"
#import "ASCTextField.h"

@class ASCSearchTableViewDelegateAndDatasource, ASCView;

@interface ASCViewController : UIViewController <ASCViewModelDelegate, ASCTextFieldDelegate>

@property (nonatomic, strong) ASCSearchViewModel *searchViewModel;
@property (nonatomic) ASCSearchTableViewDelegateAndDatasource *searchTableViewDD;

@end
