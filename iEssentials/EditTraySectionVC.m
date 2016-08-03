//
//  EditTraySectionVC.m
//  iEssentials
//
//  Created by Krishna on 6/29/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "EditTraySectionVC.h"

#define SAVE_TRAY_BUTTON_TAG 103

@interface EditTraySectionVC ()

@property (weak, nonatomic) IBOutlet UITextField *txtItemName;
- (IBAction)btnQuantityMinus:(id)sender;
- (IBAction)btnQuantityPlus:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblQuantity;
@property (weak, nonatomic) IBOutlet UITextField *lblFoodItemName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation EditTraySectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tiledBackground = NO;
    self.title = _section.itemName;

    _lblQuantity.text = [NSString stringWithFormat:@"%.0f", _section.userItemQty];
    _lblQuantity.tag = _section.userItemQty;
    _lblFoodItemName.text = _section.itemName;
    _txtItemName.text = _section.sectionName;
    _imageView.image = [UIImage imageNamed:_section.status];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)setUpDefaultToolBar
{
    [super setUpSaveBtnToolBar];
}

- (void)toolBarButtonClicked:(id)sender
{
    UIButton *clickedButton = sender;
    if(clickedButton.tag == SAVE_TRAY_BUTTON_TAG)
    {
        UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        [hud setLabelText:@"Saving..."];
        
        TraySectionObject *updatedSection = [[TraySectionObject alloc] init];
        updatedSection = [_section copy];
        updatedSection.userItemQty = _lblQuantity.tag;
        updatedSection.sectionName = _txtItemName.text;
        updatedSection.itemName = _lblFoodItemName.text;
        
        [[EssentialWebServiceStore sharedStore] updateSection:updatedSection completion:^(TraySectionObject *section, NSError *error) {
            
            if(!error)
            {
                [hud setLabelText:@"Updated successfully"];
                [hud hide:YES afterDelay:2];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
            else
            {
                [hud setLabelText:@"Updated failed. Please try again later"];
                [hud hide:YES afterDelay:1];
            }
        }];
    }
}


- (IBAction)btnQuantityMinus:(id)sender {
    
    if(_lblQuantity.tag > 1)
    {
        _lblQuantity.tag = _lblQuantity.tag - 1;
    }
    
    [self updateUI];
}

- (IBAction)btnQuantityPlus:(id)sender {
    
    if(_lblQuantity.tag < 10)
    {
        _lblQuantity.tag = _lblQuantity.tag + 1;
    }
    
    [self updateUI];
}

-(void)updateUI
{
    _lblQuantity.text = [NSString stringWithFormat:@"%ld", (long)_lblQuantity.tag];
    
}
- (void)updateUI:(NSNotification *)note
{
    self.title = _section.itemName;
    
    _lblQuantity.text = [NSString stringWithFormat:@"%.0f", _section.userItemQty];
    _lblQuantity.tag = _section.userItemQty;
    _lblFoodItemName.text = _section.itemName;
    _txtItemName.text = _section.sectionName;
    _imageView.image = [UIImage imageNamed:_section.status];
}
@end
