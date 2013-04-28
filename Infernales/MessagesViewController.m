//
//  InboxMessagesViewController.m
//  Infernales
//
//  Created by Guido Wehner on 12.04.13.
//
//

#import "MessagesViewController.h"

@interface MessagesViewController ()

@end

@implementation MessagesViewController

@synthesize dict;
@synthesize tableView = _tableView;
@synthesize folder = _folder;
@synthesize btnInbox = _btnInbox;
@synthesize btnOutbox = _btnOutbox;
@synthesize btnTrash = _btnTrash;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)fetchMessages {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [defaults objectForKey:@"username"];
    NSString *password = [defaults objectForKey:@"passwort"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://www.infernales.de/portal/forum/messages.json.php?username=%@&password=%@&folder=%@", username, password, _folder];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setCompletionBlock:^{
        self.dict = [[request responseString] JSONValue];
        [self.tableView reloadData];
    }];
    [request setFailedBlock:^{
        NSLog(@"Failed for reason: %@", [[request error] localizedDescription]);
    }];
    [request startSynchronous];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchMessages];
    [_btnInbox setEnabled:NO];
    self.title = @"Posteingang";
    self.navigationItem.rightBarButtonItem = [self getNewButton];
    
    
//    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.editButtonItem, nil];

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.dict.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MessageViewCell";
    MessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    PostViewCell *cell = nil;
    
    // Configure the cell...
    if(!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MessageViewCell" owner:nil options:nil];
        for(id currentObject in topLevelObjects) {
            if([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (MessageViewCell *) currentObject;
                break;
            }
        }
    }
    

    
    
    
    


    NSDictionary *dict = [self.dict objectAtIndex:indexPath.row];
//    cell.textLabel.text = [dict objectForKey:@"message_subject"];
    
    cell.subjectLabel.text = [dict objectForKey:@"message_subject"];
    
    
    NSString *autor = [dict objectForKey:@"user_name"];
    
    NSDate *theDate = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"message_datestamp"] doubleValue]];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSString *date = [format stringFromDate:theDate];
    [format release];
    
    autor = [[autor stringByAppendingString:@" am "] stringByAppendingString:date];
    cell.authorLabel.text = autor;
    
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *username = [defaults objectForKey:@"username"];
        NSString *password = [defaults objectForKey:@"passwort"];
        
        
        NSDictionary *messageRow = [self.dict objectAtIndex:indexPath.row];
        NSString *msgId = [messageRow objectForKey:@"message_id"];
    
        
        NSString *urlString = [NSString stringWithFormat:@"http://www.infernales.de/portal/forum/messages.json.php?username=%@&password=%@", username, password];
        NSURL *url = [NSURL URLWithString:urlString];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:msgId forKey:@"check_mark[]"];
        [request setPostValue:@"loeschen" forKey:@"delete_msg"];
        [request setCompletionBlock:^{
            [self.dict removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        [request setFailedBlock:^{
            NSLog(@"Error: %@", [[request error] localizedDescription]);
        }];
        
        [request startAsynchronous];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.

     MessageDetailViewController *dvc = [[MessageDetailViewController alloc] initWithNibName:@"MessageDetailViewController" bundle:nil];
     [dvc setMessage:[self.dict objectAtIndex:indexPath.row]];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:dvc animated:YES];
     [dvc release];
}


- (void)dealloc {
    [_btnInbox release];
    [_btnOutbox release];
    [_btnTrash release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBtnInbox:nil];
    [self setBtnOutbox:nil];
    [self setBtnTrash:nil];
    [super viewDidUnload];
}

-(UIBarButtonItem *)getNewButton {
    UIBarButtonItem *button = [[[UIBarButtonItem alloc] initWithTitle:@"Neu" style:UIBarButtonSystemItemAdd target:self action:@selector(clickNewButton:)] autorelease];
    return button;
}

-(IBAction)clickNewButton:(id)sender {
    MessageNewViewController *mnvc = [[MessageNewViewController alloc] initWithNibName:@"MessageNewViewController" bundle:nil];
    [self.navigationController pushViewController:mnvc animated:YES];
    [mnvc release];
}


#pragma mark - Button Action Code
- (IBAction)pressInbox:(id)sender {
    [_btnInbox setEnabled:NO];
    [_btnOutbox setEnabled:YES];
    [_btnTrash setEnabled:YES];
    self.title = @"Posteingang";
    self.navigationItem.rightBarButtonItem = [self getNewButton];
    
    _folder = @"inbox";
    [self fetchMessages];
}

- (IBAction)pressOutbox:(id)sender {
    [_btnInbox setEnabled:YES];
    [_btnOutbox setEnabled:NO];
    [_btnTrash setEnabled:YES];
    self.title = @"Postausgang";
    self.navigationItem.rightBarButtonItem = nil;
    
    _folder = @"outbox";
    [self fetchMessages];
}

- (IBAction)pressTrash:(id)sender {
    [_btnInbox setEnabled:YES];
    [_btnOutbox setEnabled:YES];
    [_btnTrash setEnabled:NO];
    self.title = @"Papierkorb";
    self.navigationItem.rightBarButtonItem = nil;
    
    _folder = @"trash";
    [self fetchMessages];
}

@end
