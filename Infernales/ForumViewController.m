//
//  ForumViewController.m
//  Infernales
//
//  Created by machi on 23.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ForumViewController.h"
#import "ThreadViewController.h"

@interface ForumViewController ()

@end

@implementation ForumViewController
@synthesize forumData, forumcats;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSDictionary *)loadForumData {
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwort"];
   
    if([username length] > 0 && [password length] > 0) {
        NSString *urlString = [NSString stringWithFormat:@"http://www.infernales.de/portal/forum/index.json.php?username=%@&password=%@", username, password];
        NSString *responseString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil];
        NSDictionary *responseObject = [responseString JSONValue];
        NSArray *keys = [responseObject allKeys];
        if([keys containsObject:@"error_code"] == YES) {
            AppDelegate *del = [[UIApplication sharedApplication] delegate];
            del.unregistered = true;

            NSString *urlString = @"http://www.infernales.de/portal/forum/index.json.php";
            return [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] JSONValue];
        }
        return [responseString JSONValue];
    } else {
        NSString *urlString = @"http://www.infernales.de/portal/forum/index.json.php";
        return [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] JSONValue];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Forum";
    self.forumData = self.loadForumData;
    if([self.forumData count] > 0) {
        
        
    }
    
//    NSLog(@"%@",self.forumData);
    
    
    //    NSLog(@"%@",[self.forumData objectForKey:[[self.forumData allKeys] objectAtIndex:1]]);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self.forumcats release];
    [self.forumData release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.forumData count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[self.forumData objectForKey:[[self.forumData allKeys] objectAtIndex:section]] objectForKey:@"name"] decodeHtmlEntities];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.forumData objectForKey:[[self.forumData allKeys] objectAtIndex:section]] objectForKey:@"forum"] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ForumViewCell";
    ForumViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if(!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ForumViewCell" owner:nil options:nil];
        for(id currentObject in topLevelObjects) {
            if([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (ForumViewCell *) currentObject;
                break;
            }
        }
        
        //        cell = [[ThreadViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    NSDictionary *tempdict = [[[self.forumData objectForKey:[[self.forumData allKeys] objectAtIndex:indexPath.section]] objectForKey:@"forum"] retain];
    
    NSDictionary *dic = [tempdict objectForKey:[[tempdict allKeys] objectAtIndex:indexPath.row]];
    cell.mainLabel.text = [[dic objectForKey:@"name"] decodeHtmlEntities];
    
//    NSLog(@"%@",dic);
    NSDecimalNumber *dec = [dic objectForKey:@"hasnew"];
    
    if([dec compare:[NSNumber numberWithInt:1]] == NSOrderedSame) {
        cell.newIndicator.image = [UIImage imageNamed:@"foldernew.gif"];
    }
//    [dec release];
    
    NSString *autor = @"Letzter Post: ";
    autor = [autor stringByAppendingString:[dic objectForKey:@"user"]];
    NSDate *theDate = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"lastpost"] doubleValue]];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSString *date = [format stringFromDate:theDate];
    [format release];
    
    
    autor = [autor stringByAppendingFormat:@" am "];
    autor = [autor stringByAppendingFormat:date];

//    NSLog(@"%@",date);
    cell.lastAutorLabel.text = autor;
    
    [tempdict release];
    // Configure the cell...
    
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

- (NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *tempdict = [[self.forumData objectForKey:[[self.forumData allKeys] objectAtIndex:indexPath.section]] objectForKey:@"forum"];
    return [[tempdict objectForKey:[[tempdict allKeys] objectAtIndex:indexPath.row]] retain];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self getDictionaryAtIndexPath:indexPath];
    NSInteger *forumid = [dic objectForKey:@"forumid"];
//    NSString *cat = [[[self.forumData objectForKey:[[self.forumData allKeys] objectAtIndex:section]] objectForKey:@"name"] decodeHtmlEntities];
    
    
    ThreadViewController *tvc = [[ThreadViewController alloc] initWithForumId:forumid];
    //     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    
    [tvc setThreadName:[dic objectForKey:@"name"]];
    [self.navigationController pushViewController:tvc animated:YES];
    //     [self.navigationController pushViewController:detailViewController animated:YES];
    [tvc release];
}

@end
