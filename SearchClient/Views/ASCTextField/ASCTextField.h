//
//  ASCTextField.h
//  SearchClient
//
//  Created by Alex Hill on 10/19/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASCTextField;

@interface ASCTextField : UITextField

@property (nonatomic, assign) float verticalPadding;
@property (nonatomic, assign) float horizontalPadding;
@property (nonatomic) UIColor *cancelButtonColor;

@end
