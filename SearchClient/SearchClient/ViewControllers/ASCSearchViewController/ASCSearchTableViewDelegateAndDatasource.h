//
//  ASCSearchTableViewDelegate.h
//  SearchClient
//
//  Created by Alex Hill on 11/17/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASCSearchViewModel, ASCSearchTableViewDelegateAndDatasource;

@protocol ASCSearchTableViewDDDelegate <NSObject>

- (void)ddDelegate:(ASCSearchTableViewDelegateAndDatasource *)ddDelegate didSelectText:(NSString *)text;

@end

@interface ASCSearchTableViewDelegateAndDatasource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ASCSearchViewModel *viewModel;
@property (nonatomic, weak) id<ASCSearchTableViewDDDelegate> delegate;

@end
