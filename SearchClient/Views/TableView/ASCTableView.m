//
//  ASCTableView.m
//  SearchClient
//
//  Created by Alex Hill on 10/24/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableView.h"

#define ASCTableViewBorderColor [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1].CGColor

@implementation ASCTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = ASCTableViewBorderColor;
}

@end
