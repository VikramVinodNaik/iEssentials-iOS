//
//  AccountSettingsCell.m
//  iEssentials
//
//  Created by Krishna on 6/28/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "AccountSettingsCell.h"

@interface AccountSettingsCell ()

- (IBAction)btnChangePasswordPressed:(id)sender;
@end

@implementation AccountSettingsCell

- (void)awakeFromNib {
    // Initialization code
    _isEditing = NO;
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [clearButton setFrame:CGRectMake(0, 0, 40, self.txtConfirmPassword.frame.size.height)];
    [clearButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [clearButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearTextField:) forControlEvents:UIControlEventTouchUpInside];
    
    self.txtConfirmPassword.rightViewMode = UITextFieldViewModeAlways; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [self.txtConfirmPassword setRightView:clearButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark Actions
- (IBAction)btnChangePasswordPressed:(id)sender {
    
    if(_changePasswordClicked)
        _changePasswordClicked(self, NO);
}

- (void) clearTextField:(UIButton *)sender{
    
        if(_changePasswordClicked)
            _changePasswordClicked(self, YES);
}

#pragma mark UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(CustomErrorTextField *)textField
{
    _isEditing = YES;
    [textField showError:NO withMessage:nil];
}

- (BOOL)textField:(CustomErrorTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if([string isEqualToString:@""])
        return YES;
    
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if([[str stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""])
    {
        return NO;
    }
    else if (textField.maxLength > 0 && textField.text.length >= textField.maxLength)
    {
        return NO;
    }
    else
    {
        if(textField == _txtPhone)
        {
            if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
            {
                return NO;
            }
            
            int length = (int)[self getLength:textField.text];
            //NSLog(@"Length  =  %d ",length);
            
            if(length == 10)
            {
                if(range.length == 0)
                    return NO;
            }
            
            if(length == 3)
            {
                NSString *num = [self formatNumber:textField.text];
                textField.text = [NSString stringWithFormat:@"(%@) ",num];
                
                if(range.length > 0)
                    textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
            }
            else if(length == 6)
            {
                NSString *num = [self formatNumber:textField.text];
                //NSLog(@"%@",[num  substringToIndex:3]);
                //NSLog(@"%@",[num substringFromIndex:3]);
                textField.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
                
                if(range.length > 0)
                    textField.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
            }
            
            return YES;
        }
        return YES;
    }
}


- (NSString *)formatNumber:(NSString *)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSLog(@"%@", mobileNumber);
    
    int length = (int)[mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        NSLog(@"%@", mobileNumber);
        
    }
    
    return mobileNumber;
}

- (int)getLength:(NSString *)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = (int)[mobileNumber length];
    
    return length;
}


@end
