//
//  CurrentTradeShowViewController.m
//  PayAnywhere
//
//  Created by newuser on 11/26/13.
//  Copyright (c) 2013 NAB. All rights reserved.
//

#import "CurrentTradeShowViewController.h"

@interface CurrentTradeShowViewController ()

@end

@implementation CurrentTradeShowViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *ip = (NSIndexPath *) sender;
    
    if (ip.row == 1)
    {
        //Tradeshow Segue
        SelectionViewController *selectionVC = [segue destinationViewController];
        selectionVC.selectionType = SelectionTypeTradeshow;
        selectionVC.delegate = self;
    }
    else if (ip.row == 2)
    {
        //Agents Segue
        SelectionViewController *selectionVC = [segue destinationViewController];
        selectionVC.selectionType = SelectionTypeAgents;
        selectionVC.delegate = self;
    }
    else if (ip.row == 3)
    {
        SelectionViewController *selectionVC = [segue destinationViewController];
        selectionVC.selectionType = SelectionTypeTradeshowMode;
        selectionVC.delegate = self;
    }
}

/*
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        TradeShow *activeTradeshow = [[Database sharedDB] getActiveTradeshow];
        if (activeTradeshow == nil) {
            cell.textLabel.text = @"Start Active Tradeshow";
            cell.textLabel.textColor = [UIColor greenColor];
        }
        else {
            cell.textLabel.text = @"Stop Active Tradeshow";
            cell.textLabel.textColor = [UIColor redColor];
        }
        return cell;
    }
}*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3 && ([self.agents count] == 0 || self.currentTradeshow == nil))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Selection Made" message:@"Please select a tradeshow and the attending agents" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3)
    {
        [self performSegueWithIdentifier:@"SelectionSegue" sender:indexPath];
    }
}

-(void)didSelectAgents:(NSArray *)selectedAgents
{
    [self.navigationController popViewControllerAnimated:YES];
    
    self.agents = selectedAgents;
    NSString *agentsString = @"Agents: ";
    
    for (int i = 0; i < [self.agents count]; i++) {
        Agent * currentAgent = [self.agents objectAtIndex:i];
        
        //If last agent, don't add a comma
        if (i == ([self.agents count] - 1)) {
            agentsString = [agentsString stringByAppendingString:[NSString stringWithFormat:@"%@ %@", currentAgent.firstName, currentAgent.lastName]];
        }
        else {
            agentsString = [agentsString stringByAppendingString:[NSString stringWithFormat:@"%@ %@, ", currentAgent.firstName, currentAgent.lastName]];
        }
    }
    
    self.agentsLabel.text = agentsString;
}

-(void)didSelectTradeshow:(TradeShow *)tradeshow
{
    [self.navigationController popViewControllerAnimated:YES];
    
    self.currentTradeshow = tradeshow;
    self.tradeshowLabel.text = [NSString stringWithFormat:@"Tradeshow: %@", self.currentTradeshow.name];

}

-(void)didStartCurrentTradeshow{
    [self.navigationController popViewControllerAnimated:YES];
    [[Database sharedDB] activateTradeshow:self.currentTradeshow];
}

-(void)didStopCurrentTradeshow{
    [self.navigationController popViewControllerAnimated:YES];
    [[Database sharedDB] deactivateTradeshow];
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

- (IBAction)startTradeshow:(id)sender {
    //If no selected agent(s)
    if ([self.agents count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Select Attending Agents" message:@"Please select a list of agents attending this tradeshow" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    //If no selected tradeshow
    else if (self.currentTradeshow == Nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Select a Tradeshow" message:@"Please designate an Active Tradeshow. While it remains active, all forms filled will be associated with the Active Tradeshow. " delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else {
        
    }
}
@end
