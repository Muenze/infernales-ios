//
//  ThreadViewController.m
//  Infernales
//
//  Created by Guido Wehner on 15.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ThreadViewController.h"
#import "NSString+HtmlEntities.h"

@interface ThreadViewController ()

@end

@implementation ThreadViewController

@synthesize threadData, forumId;

-(NSDictionary *)loadThreadData {
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwort"];
    
    if([username length] > 0 && [password length] > 0) {
        NSString *urlString = [NSString stringWithFormat:@"http://www.infernales.de/portal/forum/viewforum.json.php?username=%@&password=%@&forum_id=%@", username, password, forumId];
        return [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] JSONValue];
    } else {
        NSString *urlString = @"http://www.infernales.de/portal/forum/viewforum.json.php";
        return [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] JSONValue];
    }    
}


-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath {
    return [self.threadData objectForKey:[[self.threadData allKeys] objectAtIndex:indexPath.row]];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithForumId:(NSInteger *)fid {
    self = [super init];
    if(self) {
        self.forumId = fid;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.threadData = [self loadThreadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [threadData release];
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
    if([self.threadData count] > 0) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.threadData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ThreadViewCell";
    ThreadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if(!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ThreadViewCell" owner:nil options:nil];
        for(id currentObject in topLevelObjects) {
            if([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (ThreadViewCell *) currentObject;
                break;
            }
        }
        
//        cell = [[ThreadViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dic = [self getDictionaryAtIndexPath:indexPath];
    
    NSDecimalNumber *isNew = [dic objectForKey:@"isnew"];
    if([isNew isEqualToNumber:[NSNumber numberWithInt:0]]) {
    } else {
        UIImage *im = [UIImage imageNamed:@"foldernew.gif"];
        cell.imageView.image = im;
    }
    
    NSString *isSticky = [dic objectForKey:@"sticky"];
    if([isSticky isEqualToString:@"1"]) {
        UIImage *stick = [UIImage imageNamed:@"pin.png"];
        cell.stickyIndicator.image = stick;
    } else {
        cell.stickyIndicator.image = nil;
    }
    
    NSString *author = [dic objectForKey:@"user_author"];
    NSString *erstelltText = [NSString stringWithFormat:@"Author: "];
    erstelltText = [erstelltText stringByAppendingFormat:author];
    
    NSDate *theDate = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"thread_lastpost"] doubleValue]];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd.MM.yyyy"];
    NSString *date = [format stringFromDate:theDate];
    erstelltText = [erstelltText stringByAppendingFormat:@", letzter Beitrag am: "];
    erstelltText = [erstelltText stringByAppendingFormat:date];
    
    cell.threadShortDescription.text = erstelltText;
    NSString *name = [dic objectForKey:@"name"];
    if(name) {
        name = [name decodeHtmlEntities];
        cell.threadNameLabel.text = name;
//        cell.textLabel.text = name;
    } else {
//        cell.textLabel.text = @"bla";
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

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self getDictionaryAtIndexPath:indexPath];
    NSInteger *forum_id = [dic objectForKey:@"forum_id"];
    NSInteger *thread_id = [dic objectForKey:@"thread_id"];
    NSString *thread_name = [dic objectForKey:@"name"];
    thread_name = [thread_name decodeHtmlEntities];
    
    
    PostViewController *pvc = [[PostViewController alloc] initWithForumId:forum_id withThreadId:thread_id andThreadName:thread_name];
    [self.navigationController pushViewController:pvc animated:YES];
    [pvc release];
}

@end
