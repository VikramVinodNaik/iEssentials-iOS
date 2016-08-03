//
//  CreateAccountVC.m
//  iEssentials
//
//  Created by Krishna on 6/29/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "CreateAccountVC.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface CreateAccountVC () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet CustomErrorTextField *txtUsername;
@property (weak, nonatomic) IBOutlet CustomErrorTextField *txtPassword;
@property (weak, nonatomic) IBOutlet CustomErrorTextField *txtConfirmPassword;
@property (weak, nonatomic) IBOutlet CustomErrorTextField *txtPhone;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)btnUploadProfilePicPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *vwContentView;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@end

@implementation CreateAccountVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelClicked)];
    
    self.navigationItem.leftBarButtonItem = item;
}


- (IBAction)btnUploadProfilePicPressed:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //    CGSize size= CGSizeMake(_imageView.frame.size.width, _imageView.frame.size.height);
    self.imageView.image = img;
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)toolBarButtonClicked:(id)sender
{
    UIButton *clickedButton = sender;
    if(clickedButton.tag == SAVE_TRAY_BUTTON_TAG && [self validateUI])
    {
        EssentialMemberObject *member = [[EssentialMemberObject alloc] init];
        
        member.username = self.txtUsername.text;
        member.password = self.txtPassword.text;
        member.phoneNumber = self.txtPhone.text;
        member.memberID = [EssentialWebServiceStore sharedStore].currentMember.memberID;
        UIImage *img = self.imageView.image;
        
        img = [self resizeImage:img];
        
        member.profileImage = img;
        
        [[EssentialWebServiceStore sharedStore] createMember:member completion:^(EssentialMemberObject *member, NSError *error) {
            
            if(member.memberID > 0)
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.yOffset = 150;
                hud.labelFont = [UIFont systemFontOfSize:9];
                [hud setLabelText:@"Congrats! You have successfully signed up."];
                [hud hide:YES afterDelay:3];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }
            else
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.yOffset = 150;
                hud.labelFont = [UIFont systemFontOfSize:9];
                [hud setLabelText:@"Could not sign up at this time. Please try later."];
                [hud hide:YES afterDelay:2];
            }
            
        }];
    }
}


-(UIImage *)resizeImage:(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 300.0;
    float maxWidth = 400.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth)
    {
        if(imgRatio < maxRatio)
        {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio)
        {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else
        {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithData:imageData];
    
}

-(void)setUpDefaultToolBar
{
    [super setUpCreateBtnToolBar];
}

-(void)cancelClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(BOOL)validateUI
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (CustomErrorTextField *txt in _vwContentView.subviews) {
        if([txt isKindOfClass:[CustomErrorTextField class]])
        {
            if(![txt isValidateInput])
            {
                [arr addObject:txt];
            }
            
            if(![self.txtPassword.text isEqualToString:self.txtConfirmPassword.text])
            {
                [arr addObject:self.txtConfirmPassword];
                [self.txtConfirmPassword showCustomError:@"Incorrect Confirm Password"];
            }
        }
        
    }
    
    if(arr.count == 0) // No Default Errors
    {
        if(![self.txtPassword.text isEqualToString:self.txtConfirmPassword.text])
        {
            [self.txtConfirmPassword showCustomError:@"Incorrect Confirm Password"];
        }
        else
        {
            NSLog(@"Correct Inputs");
            return YES;
        }
    }
    
    return NO;
}



#pragma mark TextField Delegate Method
- (void)textFieldDidBeginEditing:(CustomErrorTextField *)textField
{
    [textField showError:NO withMessage:nil];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(![self.scrollView focusNextTextField])
    {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
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
