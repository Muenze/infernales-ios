//
//  ChoiceViewController.m
//  Infernales
//
//  Created by Guido Wehner on 12.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChoiceViewController.h"

@interface ChoiceViewController ()
@property (nonatomic, retain) NSArray *choices;
@property (nonatomic, retain) NSArray *subtext;

@end

@implementation ChoiceViewController
@synthesize choices, subtext;

-(IBAction)clickSettings:(id)sender {
    SettingsViewController *svc = [[SettingsViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
    [svc release];

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSArray *)choices {
    if(!choices) {
        choices = [NSArray arrayWithObjects:@"Forum", @"Shoutbox", @"Private Nachrichten", nil];
        
    }
    return choices;
}

-(NSArray *)subtext {
    if(!subtext) {
        subtext = [NSArray arrayWithObjects:@"", @"", @"", nil];
    }
    return subtext;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    UIBarButtonItem *button = [[UIBarButtonItem alloc] init];
    button.style = UITableViewCellStyleValue1;
    button.title = @"Settings";
    button.target = self;
    button.action = @selector(clickSettings:);
    
    self.title = @"Auswahl";
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = button;
    [button release];
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [choices release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//-(void)viewWillAppear:(BOOL)animated {
//    [self.view reloadData];
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.choices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = [self.choices objectAtIndex:[indexPath row]];
    cell.detailTextLabel.text = [self.subtext objectAtIndex:[indexPath row]];
    
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0 && indexPath.section == 0) {
        ForumViewController *fvc = [[ForumViewController alloc] init];
        [self.navigationController pushViewController:fvc animated:YES];
        [fvc release];
    }
//    else if (indexPath.row == 1 && indexPath.section == 0) {
//        NewsViewController *nvc = [[NewsViewController alloc] init];
//        [self.navigationController pushViewController:nvc animated:YES];
//        [nvc release];
//    }
    else if (indexPath.row == 1 && indexPath.section == 0) {
        ShoutboxViewController *sbvc = [[ShoutboxViewController alloc] init];
        [self.navigationController pushViewController:sbvc animated:YES];
        [sbvc release];
    }
    else if (indexPath.row == 2 && indexPath.section == 0) {
        MessagesViewController *ibc = [[MessagesViewController alloc] init];
        ibc.folder = @"inbox";
        [self.navigationController pushViewController:ibc animated:YES];
        [ibc release];
    }
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
