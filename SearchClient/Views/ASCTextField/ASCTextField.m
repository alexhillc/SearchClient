//
//  ASCTextField.m
//  SearchClient
//
//  Created by Alex Hill on 10/19/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import "ASCTextField.h"
#import <QuartzCore/QuartzCore.h>

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
    self.cancelButton.frame = CGRectMake(0, 0, 75.0, 40.0);
    [self.cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:12. weight:UIFontWeightMedium];
    [self.cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.borderStyle = UITextBorderStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.rightViewMode = UITextFieldViewModeWhileEditing;
    self.rightView = self.cancelButton;
    self.font = [UIFont systemFontOfSize:13.0];
    
    self.layer.cornerRadius = 1.5;
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.layer.shadowRadius = 1.;
    self.layer.shadowOpacity = 0.08;
    
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
