//
//  ASCTableViewSearchCell.m
//  SearchClient
//
//  Created by Alex Hill on 10/26/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTableViewSearchCell.h"

NSString *ASCTableViewSearchCellIdentifier = @"ASCTableViewSearchCellIdentifier";

@implementation ASCTableViewSearchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    self.textLabel.textColor = [UIColor darkGrayColor];
    self.textLabel.font = [UIFont systemFontOfSize:13.];
}

@end
