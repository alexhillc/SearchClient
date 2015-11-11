//
//  ASCTextField.m
//  SearchClient
//
//  Created by Alex Hill on 10/19/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTextField.h"

#define ASCSearchTextFieldBorderColor [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1].CGColor

@interface ASCTextField ()

@property UIButton *cancelButton;
@property (nonatomic, assign) BOOL isFirstLayout;

@end

@implementation ASCTextField

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cancelButton.frame = CGRectMake(0, 0, 65.0, 40.0);
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.borderStyle = UITextBorderStyleLine;
    self.backgroundColor = [UIColor whiteColor];
    self.rightViewMode = UITextFieldViewModeWhileEditing;
    self.rightView = self.cancelButton;
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = ASCSearchTextFieldBorderColor;
    self.font = [UIFont systemFontOfSize:14.0];
    
    self.isFirstLayout = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isFirstLayout) {
        [self.cancelButton setTitleColor:self.cancelButtonColor forState:UIControlStateNormal];
        
        self.isFirstLayout = NO;
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + self.horizontalPadding,
                      bounds.origin.y + self.verticalPadding,
                      bounds.size.width - self.horizontalPadding * 2 - self.rightView.frame.size.width,
                      bounds.size.height - self.verticalPadding * 2);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

#pragma mark - Button actions
- (void)cancelButtonPressed:(UIButton *)button {
    self.text = @"";
    [self endEditing:YES];
}

@end
