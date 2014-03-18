//
//  PostViewController.m
//  Infernales
//
//  Created by Guido Wehner on 05.03.13.
//
//

#import "PostViewController.h"

@interface PostViewController ()

@end

@implementation PostViewController

@synthesize forumId, threadId, postData, threadName, locked;

-(void)loadPostData {
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwort"];
    
    NSDictionary *params = @{
                             @"thread_id": threadId
                             };
    if([username length] > 0 && [password length] > 0) {
        params = @{
                   @"username": username,
                   @"password": password,
                   @"thread_id": threadId                   
                   };
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager
     GET:@"http://www.infernales.de/portal/forum/viewthread.json.iphone.php"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         [self reloadTableWithData:responseObject];
         [self reloadTableWithData:responseObject];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
     }
     ];
}

-(void)reloadTableWithData:(NSArray *)data {
    self.postData = data;
    UITableView *tableView = (UITableView *)self.view;
    [tableView reloadData];
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithForumId:(NSNumber *)forumid withThreadId:(NSNumber *)threadid andThreadName:(NSString *)threadNameParam {
    self = [super init];
    if(self) {
        self.threadId = threadid;
        self.threadName = threadNameParam;
        self.forumId = forumid;
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.postData = [self loadPostData];
    self.title = threadName;
    
    if(locked == NO) {
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStylePlain target:self action:@selector(postInForum:)];
        self.navigationItem.rightBarButtonItem = button;
        [button release];
    }


//    NSLog(@"%@",self.postData);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
//    NSLog(@"fired");
    [self loadPostData];
}


-(IBAction)postInForum:(id)sender {
    PostFormViewController *pfvc = [[PostFormViewController alloc] init];
    pfvc.threadId = self.threadId;
    pfvc.forumId = self.forumId;

    [self.navigationController pushViewController:pfvc animated:YES];
    [pfvc release];
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    [postData release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    // Return the number of sections.
    if([self.postData count] > 0) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.postData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PostViewCell";
    PostViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    PostViewCell *cell = nil;
    
    // Configure the cell...
    if(!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PostViewCell" owner:nil options:nil];
        for(id currentObject in topLevelObjects) {
            if([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (PostViewCell *) currentObject;
                break;
            }
        }
        
        //        cell = [[ThreadViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    
    NSDictionary *dic = [self getDictionaryAtIndexPath:indexPath];
//    NSString *autor = [dic objectForKey:@"user_name"];
//    autor = [autor decodeHtmlEntities];
    
    NSDate *theDate = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"post_datestamp"] doubleValue]];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSString *date = [format stringFromDate:theDate];
    [format release];
    
//    autor = [autor stringByAppendingFormat:@" am "];
//    autor = [autor stringByAppendingFormat:date];
    
    NSString *autor = [NSString stringWithFormat:@"%@ am %@", [[dic objectForKey:@"user_name"] decodeHtmlEntities], date];
    
    
    
    
    cell.autorLabel.text = autor;
    
//    cell.mainLabel.editable = NO;
//    cell.mainLabel.dataDetectorTypes = UIDataDetectorTypeAll;
    
    NSString *post_message = [dic objectForKey:@"post_message"];
    post_message = [post_message decodeHtmlEntities];
    
//    NSLog(@"Message: %@",post_message);
//    [cell.mainLabel sizeToFit];
    
    CGSize aSize = [self getSizeForString:post_message];
   
    if([cell.mainLabel isKindOfClass:[UITextView class]]) {
        [cell.mainLabel removeFromSuperview];
        cell.mainLabel = nil;
    }
    
//    NSLog(@"Höhe des Rec: %f",aSize.height);
    
    CGRect uiTextViewRect = CGRectMake(20.0f, 20.0f, 280.0f, aSize.height);
    UITextView* textView = [[UITextView alloc] initWithFrame:uiTextViewRect];
//    UITextView* textView = [[UITextView alloc] init];
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    textView.scrollEnabled = NO;
    textView.editable = NO;
    textView.userInteractionEnabled = NO;
    textView.text = post_message;
//    textView.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:0.5f];
//    [textView sizeToFit];
    textView.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    [cell.contentView addSubview:textView];
    cell.mainLabel = textView;
    [textView release];
    
    
    
    CGRect cellrect = cell.frame;
    cellrect.size.height = aSize.height+40;
    [cell setFrame:cellrect];
//    NSLog(@"Die Höhe der Zelle für %@: %f",autor,  cell.frame.size.height);
    
//    cell 
    
    return cell;
}


-(CGSize)getSizeForString:(NSString *)thestring {
    CGSize aSize;
    aSize = [thestring sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] constrainedToSize:CGSizeMake(260.0, 9999.9) lineBreakMode:NSLineBreakByWordWrapping];
//    aSize.height = (aSize.height * 1.15f)+10;
    aSize.height += 16;
    return aSize;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize aSize;
    
    CGFloat initialSize = 40.0f;
    NSDictionary *dic = [self getDictionaryAtIndexPath:indexPath];
    NSString *text = [[dic objectForKey:@"post_message"] decodeHtmlEntities];
    aSize = [self getSizeForString:text];
    CGFloat myheight;
    myheight = aSize.height + initialSize;
//    NSLog(@"Höhe des Frame1: %f",aSize.height);
    if(myheight < 80.0f) {
        myheight = 80.0f;
    }
//    NSLog(@"Höhe des Frame2: %f",myheight);
    return myheight;
}



-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath {
    return [self.postData objectAtIndex:indexPath.row];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    NSDictionary *dic = [self getDictionaryAtIndexPath:indexPath];

    
     PostdetailViewController *pdvc = [[PostdetailViewController alloc] initWithNibName:@"PostdetailViewController" bundle:nil];
    [pdvc setPostValues:dic];
    
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:pdvc animated:YES];
     [pdvc release];
    
}

@end
