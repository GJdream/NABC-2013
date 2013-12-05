//
//  SelectionViewController.m
//  PayAnywhere
//
//  Created by newuser on 11/26/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "SelectionViewController.h"

@interface SelectionViewController ()

@end

@implementation SelectionViewController

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
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.selectionType == SelectionTypeAgents) {
        self. agentsArray = [[Database sharedDB] allAgents];
        self.selectedAgents = [[NSMutableArray alloc] init];
    }
    else if(self.selectionType == SelectionTypeTradeshow){
        self.tradeshowsArray = [[Database sharedDB] allMarketSources];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.selectionType == SelectionTypeAgents) {
        
        if (cell.accessoryType == UITableViewCellAccessoryNone) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self.selectedAgents addObject:[self.agentsArray objectAtIndex:indexPath.row]];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self.selectedAgents removeObject:[self.agentsArray objectAtIndex:indexPath.row]];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
    if (self.selectionType == SelectionTypeTradeshowMode && indexPath.row == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.selectionType == SelectionTypeAgents) {
        return [self.agentsArray count];
    }
    else if(self.selectionType == SelectionTypeTradeshow){
        return [self.tradeshowsArray count];
    }
    else if(self.selectionType == SelectionTypeTradeshowMode) {
        return 2;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (self.selectionType == SelectionTypeAgents) {
        Agent *currentAgent = [self.agentsArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", currentAgent.firstName, currentAgent.lastName];
    }
    else if(self.selectionType == SelectionTypeTradeshow) {
        MarketSource *currentTradeshow = [self.tradeshowsArray objectAtIndex:indexPath.row];
    
        cell.textLabel.text = currentTradeshow.name;
    }
    else if(self.selectionType == SelectionTypeTradeshowMode) {
        MarketSource *activeTradeshow = [[Database sharedDB] getActiveTradeshow];
        if (activeTradeshow == nil) {
            if (indexPath.row == 0) {
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.textLabel.text = @"Do you wish to activate this tradeshow? All forms filled will correspond to this tradeshow while it is active.";
            }
            else if (indexPath.row == 1) {
                cell.textLabel.text = @"Activate Tradeshow";
            }
        }
        else {
            if (indexPath.row == 0) {
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.textLabel.text = @"Do you wish to deactivate this tradeshow? Forms will no longer correspond to this tradeshow. You can always reactivate it later.";
            }
            else if (indexPath.row == 1) {
                cell.textLabel.text = @"Deactive Tradeshow";
            }
        }
    }
    
    return cell;
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

- (IBAction)doneButton:(id)sender {
    if (self.selectionType == SelectionTypeAgents && [self.selectedAgents count] != 0) {
        if ([self.delegate respondsToSelector:@selector(didSelectAgents:)]) {
            [self.delegate performSelector:@selector(didSelectAgents:) withObject:self.selectedAgents];
        }
    }
    else if (self.selectionType == SelectionTypeTradeshow && [self.tableView indexPathForSelectedRow]) {
        if ([self.delegate respondsToSelector:@selector(didSelectTradeshow:)]) {
            self.selectedTradeshow = [self.tradeshowsArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
            [self.delegate performSelector:@selector(didSelectTradeshow:) withObject:self.selectedTradeshow];
        }
    }
    else if (self.selectionType == SelectionTypeTradeshowMode && [self.tableView indexPathForSelectedRow])
    {
        MarketSource *activeTradeshow = [[Database sharedDB] getActiveTradeshow];
        if (activeTradeshow == nil && [self.delegate respondsToSelector:@selector(didStartCurrentTradeshow)]) {
            [self.delegate performSelector:@selector(didStartCurrentTradeshow)];
        }
        else if (activeTradeshow && [self.delegate respondsToSelector:@selector(didStopCurrentTradeshow)]) {
            [self.delegate performSelector:@selector(didStopCurrentTradeshow)];
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Selection Made" message:@"Please make a selection or press the Cancel button" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
        
}

- (IBAction)cancelButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
