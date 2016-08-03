//
//  DashBoardVC.m
//  iEssentials
//
//  Created by Vikram Naik on 20/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "DashBoardVC.h"
#import "DashboardCell.h"
#import "TrayDataObject.h"
#import "TrayDetailVC.h"
#import "TraySectionObject.h"

@interface DashBoardVC ()
{
    MBProgressHUD *hud;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;

// Model
@property (nonatomic, strong) NSMutableArray *localDataModels;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end



@implementation DashBoardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
     self.tiledBackground = YES;
   
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 250;
    //[DashboardCell desiredHeight];
    float bottom = 65;
    float top = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 26 : 8;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    if ((NSClassFromString(@"UIAlertController")) &&
        ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]))
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert];
    }
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:@"Loading..."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden = YES;
    
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2;
    self.imageView.clipsToBounds = YES;
    
    if([EssentialWebServiceStore sharedStore].currentMember.profileImage)
        self.imageView.image = [EssentialWebServiceStore sharedStore].currentMember.profileImage;
    
    [self updateUI:nil];
    
    self.navigationController.toolbarHidden = NO;
    
}

#pragma mark - Table view
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _localDataModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DashboardCell";
    DashboardCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[DashboardCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
           }

    // Configure the cell...
    
    TrayDataObject *tray = [self.localDataModels objectAtIndex:indexPath.row];
    cell.trayDetailsButton.tag = indexPath.row;
    [cell.trayDetailsButton addTarget:self action:@selector(trayButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell configDashBoardCell:tray];
    
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

//Hardcoded Data For TRAY

-(void)populateTrayValues
{
    self.localDataModels = [[NSMutableArray alloc] init];
    
    TrayDataObject *trayObject = [[TrayDataObject alloc]init];
    trayObject.name = @"Milk Products Tray";
    
    NSMutableArray *sections = [[NSMutableArray alloc]init];
    
    TraySectionObject *section1  =[[TraySectionObject alloc]init];
    section1.itemName = @"Eggs";
    section1.status = @"Full";
    section1.sectionImageView.image = [UIImage imageNamed:@"item_egg_full"];
    
    [sections addObject:section1];
    
    TraySectionObject *section2  =[[TraySectionObject alloc]init];
    section2.itemName = @"Bread";
    section2.status = @"Low";
    section2.sectionImageView.image = [UIImage imageNamed:@"item_bread_low"];
    
    [sections addObject:section2];
    
    TraySectionObject *section3  =[[TraySectionObject alloc]init];
    section3.itemName = @"Milk";
    section3.status = @"Full";
    section3.sectionImageView.image = [UIImage imageNamed:@"item_milk_full"];
    
    [sections addObject:section3];

    trayObject.sections = sections;
    
    [self.localDataModels addObject:trayObject];
    
}

 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     

     if ([[segue identifier] isEqualToString:@"showTrayDetail"]) {
         UIButton *senderClkdButton = sender;
         TrayDataObject *tray = [self.localDataModels objectAtIndex:senderClkdButton.tag];
         if(tray)
         {
         TrayDetailVC *dest = [segue destinationViewController];
         dest.trayObject = tray;
         }
         
     }
     
 }


- (void)updateUI:(NSNotification *)note
{
    [[EssentialWebServiceStore sharedStore] getTrayListWithCompletionHandler:^(NSMutableArray *trayObjects, NSError *error) {
        
        self.localDataModels = trayObjects;
        [self.tableView reloadData];
        
        [hud hide:YES afterDelay:1];
        hud = nil;
    }];
}


#pragma mark Create Tray
- (void)toolBarButtonClicked:(id)sender
{
    UIButton *clickedButton = sender;
    if(clickedButton.tag == ADD_TRAY_BUTTON_TAG)
    {
        NSLog(@"Add tray Btn Clicked ");
        [self performSegueWithIdentifier:@"CreateTraySegue" sender:sender];
    }
}
@end
