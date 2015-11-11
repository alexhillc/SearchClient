//
//  ASCViewController.m
//  SearchClient
//
//  Created by Alex Hill on 10/27/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCViewController.h"

@interface ASCViewController ()

@end

@implementation ASCViewController

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.view setNeedsUpdateConstraints];
}

@end
