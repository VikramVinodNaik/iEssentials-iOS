//
//  CreateTrayVC.m
//  iEssentials
//
//  Created by Krishna on 7/6/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "CreateTrayVC.h"

@interface CreateTrayVC ()

@property (weak, nonatomic) IBOutlet UITextField *txtTrayName;
@property (weak, nonatomic) IBOutlet UITextField *txtSecAName;
@property (weak, nonatomic) IBOutlet UITextField *txtSecBName;
@property (weak, nonatomic) IBOutlet UITextField *txtSecCName;
@end

@implementation CreateTrayVC


-(void)setUpDefaultToolBar
{
    [super setUpSaveBtnToolBar];
}

- (void)toolBarButtonClicked:(id)sender
{
    UIButton *clickedButton = sender;
    if(clickedButton.tag == SAVE_TRAY_BUTTON_TAG)
    {
        NSDictionary *A = @{@"name": _txtSecAName.text, @"identfier":@"A"};
        NSDictionary *B = @{@"name": _txtSecBName.text, @"identfier":@"B"};
        NSDictionary *C = @{@"name": _txtSecCName.text, @"identfier":@"C"};
        
        NSDictionary *sections = @{@"A":A,
                                   @"B":B,
                                   @"C":C};

        UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        [hud setLabelText:@"Saving..."];
        
        [[EssentialWebServiceStore sharedStore] createTray:_txtTrayName.text SectionsDict:sections completion:^(TrayDataObject *tray, NSError *error) {
           
            if(!error)
            {
                [hud setLabelText:@"Updated successfully"];
                [hud hide:YES afterDelay:2];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

@end
