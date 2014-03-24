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

@synthesize dict = _dict;
@synthesize tableView = _tableView;
@synthesize folder = _folder;
@synthesize btnInbox = _btnInbox;
@synthesize btnOutbox = _btnOutbox;
@synthesize btnTrash = _btnTrash;
@synthesize manager = _manager;

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

-(id)init {
    if(self = [super init]) {
        self.manager = [AFHTTPRequestOperationManager manager];
    }
    return self;
}

-(void)fetchMessages {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [defaults objectForKey:@"username"];
    NSString *password = [defaults objectForKey:@"passwort"];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"Lade Messages";
    
    NSDictionary *params = @{@"username": username, @"password": password, @"folder": self.folder};
    
    [self.manager
     GET:@"http://www.infernales.de/portal/forum/messages.json.iphone.php"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         [self reloadTableWithData:responseObject];
         [self.hud hide:YES];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@", error);
         [self.hud hide:YES];
     }];
}

- (void)reloadTableWithData:(NSArray *)data {
    self.dict = [data mutableCopy];
    [_tableView reloadData];
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
    

    
    
    
    


    NSDictionary *dictionary = (self.dict)[indexPath.row];
//    cell.textLabel.text = [dict objectForKey:@"message_subject"];
    
    cell.subjectLabel.text = dictionary[@"message_subject"];
    
    
    NSString *autor = dictionary[@"user_name"];
    
    NSDate *theDate = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"message_datestamp"] doubleValue]];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSString *date = [format stringFromDate:theDate];
    
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
        
        
        NSDictionary *messageRow = (self.dict)[indexPath.row];
        NSString *msgId = messageRow[@"message_id"];
    
        
        NSString *urlString = [NSString stringWithFormat:@"http://www.infernales.de/portal/forum/messages.json.php?username=%@&password=%@", username, password];
        NSURL *url = [NSURL URLWithString:urlString];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        __weak ASIFormDataRequest *req = request;
        [request setPostValue:msgId forKey:@"check_mark[]"];
        [request setPostValue:@"loeschen" forKey:@"delete_msg"];
        [request setCompletionBlock:^{
            [self.dict removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        [request setFailedBlock:^{
            NSLog(@"Error: %@", [[req error] localizedDescription]);
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
     [dvc setMessage:(self.dict)[indexPath.row]];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:dvc animated:YES];
}


- (void)viewDidUnload {
    [self setBtnInbox:nil];
    [self setBtnOutbox:nil];
    [self setBtnTrash:nil];
    [super viewDidUnload];
}

-(UIBarButtonItem *)getNewButton {
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Neu" style:UIBarButtonItemStylePlain target:self action:@selector(clickNewButton:)];
    return button;
}

-(IBAction)clickNewButton:(id)sender {
    MessageNewViewController *mnvc = [[MessageNewViewController alloc] init];
    [self.navigationController pushViewController:mnvc animated:YES];
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

-(void)viewWillDisappear:(BOOL)animated {
    [[self.manager operationQueue] cancelAllOperations];
    [super viewWillDisappear:animated];
}

@end
