//
//  AccountSettingVC.m
//  iEssentials
//
//  Created by Vikram Naik on 21/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "AccountSettingVC.h"
#import "AccountSettingsCell.h"
#import "EssentialMemberObject.h"
#import "EssentialWebServiceStore.h"
#import <TPKeyboardAvoidingTableView.h>

@interface AccountSettingVC () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;
- (IBAction)btnUploadPicPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)btnLogout:(id)sender;
@end

@implementation AccountSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Account Settings";
    self.tiledBackground = NO;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 260;
    
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2;
    _imageView.clipsToBounds = YES;
    
    if([EssentialWebServiceStore sharedStore].currentMember.profileImage)
        self.imageView.image = [EssentialWebServiceStore sharedStore].currentMember.profileImage;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        AccountSettingsCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        EssentialMemberObject *member = [[EssentialMemberObject alloc] init];
        
        member.username = cell.txtUsername.text;
        member.password = cell.txtPassword.text;
        member.phoneNumber = cell.txtPhone.text;
        member.memberID = [EssentialWebServiceStore sharedStore].currentMember.memberID;
        UIImage *img = self.imageView.image;
        
        img = [self resizeImage:img];
        
        member.profileImage = img;
        
        UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        [hud setLabelText:@"Saving..."];
        
        [[EssentialWebServiceStore sharedStore] updateMember:member completion:^(EssentialMemberObject *member, NSError *error) {
           
            if(!error)
            {
                [hud setLabelText:@"Info Updated"];
                [hud hide:YES afterDelay:2];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
            else
                [hud hide:YES afterDelay:2];
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
#pragma mark - Table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AccountSettingsCell";
    AccountSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    EssentialMemberObject *member = [EssentialWebServiceStore sharedStore].currentMember;
    
    if(!cell.isEditing)
    {
        cell.txtUsername.text = member.username;
        cell.txtPassword.text = member.password;
        cell.txtPhone.text = member.phoneNumber;
    }
    
    cell.changePasswordClicked = ^(AccountSettingsCell *currentCell, BOOL hideConfirmPwdTextBox)
    {
        currentCell.btnPassword.hidden = !hideConfirmPwdTextBox;
        currentCell.txtConfirmPassword.hidden = hideConfirmPwdTextBox;
        [_tableView reloadData];
    };
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Cell Clicked + Cell No: %ld",(long)indexPath.row);
}

-(void)trayButtonClicked:(UIButton*)sender
{
    [self performSegueWithIdentifier:@"showTrayDetail" sender:sender];
    
}
- (IBAction)btnUploadPicPressed:(id)sender {
    
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

- (IBAction)btnLogout:(id)sender {
    
    [super logout];
}
@end
