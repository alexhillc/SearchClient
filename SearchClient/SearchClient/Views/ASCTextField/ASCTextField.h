//
//  ASCTextField.h
//  SearchClient
//
//  Created by Alex Hill on 10/19/15.
//  Copyright © 2015 Alex Hill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASCTextField;

/**
 * @brief A delegate capable of telling the responder if the cancel button is tapped
 */
@protocol ASCTextFieldDelegate <UITextFieldDelegate>

@optional
- (void)textFieldDidCancel:(ASCTextField *)textField;

@end

@interface ASCTextField : UITextField

@property (nonatomic, weak) id<ASCTextFieldDelegate> delegate;
@property (nonatomic, assign) float verticalPadding;
@property (nonatomic, assign) float horizontalPadding;
@property (nonatomic) UIColor *cancelButtonColor;

@end
