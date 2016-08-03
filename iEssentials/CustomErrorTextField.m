//
//  ApTextField.m
//  Tennis League
//
//  Created by Krishna on 2/13/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

#import "CustomErrorTextField.h"

@interface CustomErrorTextField ()
{
    UIView *errorView;
}

@property(strong, nonatomic)IBInspectable NSString *errorMessage;
@property(strong, nonatomic)IBInspectable NSString *invalidInputError;
@property(strong, nonatomic)IBInspectable NSString *inputRegex;

@end

@implementation CustomErrorTextField


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    //Set Place holder color
//    placeHolderColor = self.textColor;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{ NSForegroundColorAttributeName : self.textColor}];
    self.attributedPlaceholder = str;
    
//    self.background = [UIImage imageNamed:@"textfield_bg"];
    
    // Drawing code
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height - 1, self.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:bottomBorder];
}


- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 0, 0);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 0, 0);
}

-(void)showError:(BOOL)showError withMessage:(NSString *)errorMessage
{
    if(showError)
    {
        //Set Error Icon
        UIImageView *vwIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textvalidation_error"]];
        [vwIcon setFrame:CGRectMake(0, 0, 20, 20)];
        
        [self setRightViewMode:UITextFieldViewModeAlways];
        self.rightView = vwIcon;
        
        //Show error label
        CGRect rect = self.bounds;
        
        rect.origin.x += rect.size.width-190;
        rect.origin.y += rect.size.height - 10;
        rect.size.width = 200;
        
        CGPoint pt = [self convertPoint:rect.origin toView:self.superview];
        rect.origin = pt;
 
        if(!errorView)
        errorView = [[UIView alloc] initWithFrame:rect];
        
        UIImageView *vwImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"errorlabel_bg"]];
        vwImage.frame = CGRectMake(rect.size.width/2, 0, rect.size.width/2, 25);
        [errorView addSubview:vwImage];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(rect.size.width/2, 0, rect.size.width/2 - 5, 25)];
        lbl.textAlignment = NSTextAlignmentRight;
        lbl.font = [UIFont fontWithName:@"Helvetica" size:7];
        lbl.adjustsFontSizeToFitWidth = YES;
        [lbl setText:errorMessage];
        lbl.textColor = [UIColor whiteColor];
        
        [errorView addSubview:lbl];
        
        [self.superview addSubview:errorView];
    }
    else
    {
        self.rightView = nil;
        [errorView removeFromSuperview];
    }
}

-(BOOL)isValidateInput
{
    BOOL result = NO;
    if([self.text isEqualToString:@""] && _errorMessage)
    {
        [self showError:YES withMessage:_errorMessage];
    }
    else if (![self validateInputWithString:self.text])
    {
        [self showError:YES withMessage:_invalidInputError];
    }
    else
    {
        [self showError:NO withMessage:nil];
        result = YES;
    }
    
    return result;
}

- (BOOL)validateInputWithString:(NSString *)aString
{
    if(!_inputRegex || [_inputRegex isEqualToString:@""])
    {
        return YES;
        
    }
    
    //[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}
    NSString *emailRegex = [NSString stringWithFormat:@"%@", _inputRegex];
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    BOOL result = [emailTest evaluateWithObject:aString];
    
    return result;
}

-(void)showCustomError:(NSString *)errorMessage
{
    [self showError:YES withMessage:errorMessage];
}

//
//#pragma mark TextField Delegate Method
//- (void)textFieldDidBeginEditing:(AppTextField *)textField
//{
//    [textField showError:NO withMessage:nil];
//
//}
//
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
// 
//    if([string isEqualToString:@""])
//        return YES;
//    
//    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    if([[str stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""])
//    {
//        self.textColor = placeHolderColor;
//        return NO;
//    }
//    else if (self.maxLength > 0 && textField.text.length >= self.maxLength)
//    {
//        return NO;
//    }
//    else
//    {
//        self.textColor = [UIColor blackColor];
//        return YES;
//    }
//}

@end
