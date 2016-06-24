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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


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
    cell.trayDetailLabel.text = tray.detailLabel;
    cell.item1DetailLabel.text = tray.item1Label;
    cell.item2DetailLabel.text = tray.item2Label;
    cell.item3DetailLabel.text = tray.item3Label;
    cell.item1QuantityLabel.text = tray.item1qnty;
    cell.item2QuantityLabel.text = tray.item2qnty;
    cell.item3QuantityLabel.text = tray.item3qnty;
    cell.item1ImageView.image = [UIImage imageNamed:@"item_egg_full"];
    cell.item2ImageView.image = [UIImage imageNamed:@"item_bread_low"];
    cell.item3ImageView.image = [UIImage imageNamed:@"item_milk_full"];
    }
    return cell;
}

-(void)trayButtonClicked:(UIButton*)sender
{
    if (sender.tag == 0)
    {
       NSLog(@"Dairy Btn Clicked ");
    }else if ( sender.tag == 1)
    {
      NSLog(@"Veggie Btn Clicked ");
    }
}


//Hardcoded Data For TRAY

-(void)populateTrayValues
{
    self.localDataModels = [[NSMutableArray alloc] init];
    
    TrayDataObject *tray1 = [[TrayDataObject alloc]init];
    tray1.detailLabel = @"Milk Products Tray";
    tray1.item1Label = @"Eggs";
    tray1.item2Label = @"Bread";
    tray1.item3Label = @"Milk";
    tray1.item1qnty = @"Full";
    tray1.item2qnty = @"Low";
    tray1.item3qnty = @"Full";
    
    //    TrayDataObject *tray2 = [[TrayDataObject alloc]init];
    //    tray2.detailLabel = @"Vege Tray";
    //    tray2.item1Label = @"Eggs";
    //    tray2.item2Label = @"Bread";
    //    tray2.item3Label = @"Milk";
    //    tray2.item1qnty = @"Low";
    //    tray2.item2qnty = @"Full";
    //    tray2.item3qnty = @"Full";
    
    [self.localDataModels addObject:tray1];
    
}
@end
