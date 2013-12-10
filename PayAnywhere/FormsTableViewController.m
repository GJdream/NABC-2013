//
//  FormsTableViewController.m
//  PayAnywhere
//
//  Created by newuser on 11/21/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "FormsTableViewController.h"

@interface FormsTableViewController ()

@end

@implementation FormsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.individualForms = [[NSArray alloc] init];
    self.businessForms = [[NSArray alloc] init];
    
    self.individualForms = [[Database sharedDB] allIndividualForms];
    self.businessForms = [[Database sharedDB] allBusinessForms];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return [self.individualForms count];
    }
    else {
        return [self.businessForms count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FormCell";
    MarketSource *activeTradeshow = [[Database sharedDB] getActiveTradeshow];
    FormCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        IndividualForm *currentForm = [self.individualForms objectAtIndex:indexPath.row];
        cell.applicantName.text = [NSString stringWithFormat:@"%@ %@", currentForm.firstName, currentForm.lastName];
        cell.dateFilled.text = [NSString stringWithFormat:@"Email: %@", currentForm.email];
        
        NSString *agentName = [[Database sharedDB] getFirstAndLastNameForAgentID:currentForm.aid];
        cell.agentName.text = [NSString stringWithFormat:@"Agent: %@", agentName];
        NSString *msName = [[Database sharedDB] getTradeshowNameForMSID:currentForm.msid];
        cell.marketSource.text = [NSString stringWithFormat:@"Market Source: %@",msName];

    }
    else if (indexPath.section == 1) {
        BusinessForm *currentForm = [self.businessForms objectAtIndex:indexPath.row];
        cell.applicantName.text = [NSString stringWithFormat:@"%@ %@", currentForm.firstName, currentForm.lastName];
        cell.dateFilled.text = [NSString stringWithFormat:@"Email: %@", currentForm.email];
        
        NSString *agentName = [[Database sharedDB] getFirstAndLastNameForAgentID:currentForm.aid];
        cell.agentName.text = [NSString stringWithFormat:@"Agent: %@", agentName];
        NSString *msName = [[Database sharedDB] getTradeshowNameForMSID:currentForm.msid];
        cell.marketSource.text = [NSString stringWithFormat:@"Market Source: %@",msName];

//        cell.marketSource.text = [NSString stringWithFormat:@"Market Source: %@",activeTradeshow.name];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 143;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)deleteSentForms:(id)sender {
    [[Database sharedDB] removeSentForms];
    [self.tableView reloadData];
}
@end
