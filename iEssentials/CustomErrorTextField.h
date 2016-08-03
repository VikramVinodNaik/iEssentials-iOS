//
//  ApTextField.h
//  Tennis League
//
//  Created by Krishna on 2/13/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@protocol CustomErrorTextFieldDelegate;

@interface CustomErrorTextField : UITextField

@property(nonatomic)id<CustomErrorTextFieldDelegate> fieldDelegate;
@property(nonatomic)IBInspectable long maxLength;

-(BOOL)isValidateInput;
-(void)showError:(BOOL)showError withMessage:(NSString *)errorMessage;

-(void)showCustomError:(NSString *)errorMessage;
@end



@protocol CustomErrorTextFieldDelegate <NSObject>

- (void)appTextFieldDidBeginEditing:(CustomErrorTextField *)textField;

@end