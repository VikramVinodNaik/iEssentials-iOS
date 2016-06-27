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

@property (nonatomic, weak) IBOutlet UITableView *tableView;

// Model
@property (nonatomic, strong) NSMutableArray *localDataModels;

@end



@implementation DashBoardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
     self.tiledBackground = YES;
   
    self.tableView.rowHeight = [DashboardCell desiredHeight];
    float bottom = 65;
    float top = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 26 : 8;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(top, 0, bottom, 0);
    [self populateTrayValues];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden = YES;
    
}

#pragma mark - Table view
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
    if(tray)
    {
    [cell configDashBoardCell:tray];
    }
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
    trayObject.detailLabel = @"Milk Products Tray";
    
    NSMutableArray *sections = [[NSMutableArray alloc]init];
    
    TraySectionObject *section1  =[[TraySectionObject alloc]init];
    section1.sectionDetailLabel = @"Eggs";
    section1.sectionStatus = @"Full";
    section1.sectionImageView.image = [UIImage imageNamed:@"item_egg_full"];
    
    [sections addObject:section1];
    
    TraySectionObject *section2  =[[TraySectionObject alloc]init];
    section2.sectionDetailLabel = @"Bread";
    section2.sectionStatus = @"Low";
    section2.sectionImageView.image = [UIImage imageNamed:@"item_bread_low"];
    
    [sections addObject:section2];
    
    TraySectionObject *section3  =[[TraySectionObject alloc]init];
    section3.sectionDetailLabel = @"Milk";
    section3.sectionStatus = @"Full";
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
@end
