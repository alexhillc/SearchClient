//
//  ASCTableView.m
//  SearchClient
//
//  Created by Alex Hill on 10/24/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableView.h"

@implementation ASCTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    self.separatorColor = [UIColor lightGrayColor];
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
}

@end
