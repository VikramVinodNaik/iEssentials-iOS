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
#import "EditTraySectionVC.h"

@interface TrayDetailVC ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *trayImageView;
@property NSInteger selectedSectionIndex;
@property NSArray *trayImages;

@end

@implementation TrayDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Configure Table View Cell
    self.tableView.rowHeight = [TrayDetailCell desiredHeight];
    
    _selectedSectionIndex =-1;
    _trayImages =[NSArray arrayWithObjects: @"traysection2selected",@"traysection3selected",@"traysection1selected",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI:nil];
    self.navigationController.toolbarHidden = YES;
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
    
    [cell configTrayDetailCell:traySection];
    
    cell.sectionEditButton.tag = indexPath.row;
    [cell.sectionEditButton addTarget:self action:@selector(traySectionEditBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
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
    NSLog(@"EditButton Clicked for row %ld",(long)sender.tag);
    
    [self performSegueWithIdentifier:@"EditSectionSegue" sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([[segue identifier] isEqualToString:@"EditSectionSegue"]) {
        
        TraySectionObject *traySection = [self.trayObject.sections objectAtIndex:_selectedSectionIndex];
        
        EditTraySectionVC *dest = [segue destinationViewController];
        dest.section = traySection;
    }
    
}

#pragma mark - AUto UI Updates
- (void)updateUI:(NSNotification *)note
{
    NSLog(@"Base Class updateUI");
    
    [[EssentialWebServiceStore sharedStore] getTrayListWithCompletionHandler:^(NSMutableArray *trayObjects, NSError *error) {
        
        for (TrayDataObject *t in trayObjects) {
            
            if(t.trayId == self.trayObject.trayId)
            {
                self.trayObject = t;
                break;
            }
        }

        if(self.trayObject)
            self.title = self.trayObject.name;
        
        [self.tableView reloadData];
    }];
}

@end
