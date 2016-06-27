//
//  TrayDetailVC.m
//  iEssentials
//
//  Created by Vikram Naik on 24/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "TrayDetailVC.h"
#import "TrayDataObject.h"
#import "TrayDetailCell.h"
#import "TraySectionObject.h"

@interface TrayDetailVC ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *trayImageView;
@property NSInteger selectedSectionIndex;
@property NSArray *trayImages;

@end

@implementation TrayDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    if(self.trayObject)
    self.title = self.trayObject.detailLabel;
    
    
    //Configure Table View Cell
    self.tableView.rowHeight = [TrayDetailCell desiredHeight];
    
    _selectedSectionIndex =-1;
    _trayImages =[NSArray arrayWithObjects: @"traysection1selected",@"traysection2selected",@"traysection3selected",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_selectedSectionIndex!=-1)
    {
        if(_selectedSectionIndex == indexPath.row)
        {
            cell.backgroundColor = [UIColor colorWithHexString:@"D4D4D5"];
//            cell.backgroundColor = [UIColor colorWithRed:212 green:212 blue:213 alpha:1];
        }else
        {
            cell.backgroundColor = [UIColor clearColor];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TrayDetailCell";
    TrayDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(_selectedSectionIndex!=-1)
    {
        if(_selectedSectionIndex == indexPath.row)
        {
            [cell hideEditButtonForIndex:NO];
        }else{
            [cell hideEditButtonForIndex:YES];
        }
        
    }
    TraySectionObject *traySection = [self.trayObject.sections objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        cell = [[TrayDetailCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    cell.sectionEditButton.tag = indexPath.row;
    [cell.sectionEditButton addTarget:self action:@selector(traySectionEditBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    
    if(self.trayObject)
    {
        [cell configTrayDetailCell:traySection];
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedSectionIndex = indexPath.row;
    self.trayImageView.image = [UIImage imageNamed:[_trayImages objectAtIndex:indexPath.row]];
    [tableView reloadData];
}


-(void)traySectionEditBtnClicked:(UIButton*)sender
{
//    [self performSegueWithIdentifier:@"showTrayDetail" sender:sender];
    NSLog(@"EditButton Clicked for Section %ld",(long)sender.tag);
    
}

#pragma mark - Navigation

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    
//    if ([[segue identifier] isEqualToString:@"showTrayDetail"]) {
//        UIButton *senderClkdButton = sender;
//        TrayDataObject *tray = [self.localDataModels objectAtIndex:senderClkdButton.tag];
//        if(tray)
//        {
//            TrayDetailVC *dest = [segue destinationViewController];
//            dest.trayObject = tray;
//        }
//        
//    }
//    
//}

@end
