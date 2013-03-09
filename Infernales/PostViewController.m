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

@synthesize threadId, postData;

-(NSDictionary *)loadPostData {
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwort"];
    
    if([username length] > 0 && [password length] > 0) {
        NSString *urlString = [NSString stringWithFormat:@"http://www.infernales.de/portal/forum/viewthread.json.php?username=%@&password=%@&thread_id=%@", username, password, threadId];
        return [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] JSONValue];
    } else {
        NSString *urlString = @"http://www.infernales.de/portal/forum/viewforum.json.php";
        return [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] JSONValue];
    }
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithThreadId:(NSInteger *)threadid {
    self = [super init];
    if(self) {
        self.threadId = threadid;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.postData = [self loadPostData];

//    NSLog(@"%@",self.postData);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    NSString *autor = [dic objectForKey:@"user_name"];
    autor = [autor decodeHtmlEntities];
    
    cell.autorLabel.text = autor;
    
    NSString *post_message = [dic objectForKey:@"post_message"];
    post_message = [post_message decodeHtmlEntities];
    
    cell.mainLabel.text = post_message;
//    [cell.mainLabel sizeToFit];
    
    CGSize aSize;
    aSize = [post_message sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300.0, 9999.9) lineBreakMode:cell.mainLabel.lineBreakMode];
//    NSLog(@"Die Höhe der Berechnung für %@: %f",autor, aSize.height);
//    NSLog(@"Die Höhe der Zelle für %@: %f",autor,  cell.frame.size.height);
    CGRect myframe = [cell.mainLabel frame];
    myframe.size.height = aSize.height;
    [cell.mainLabel setFrame:myframe];
//    NSLog(@"Die Höhe des Label für %@: %f", autor, cell.mainLabel.frame.size.height);
    
    CGRect cellrect = cell.frame;
    cellrect.size.height = aSize.height+20;
    [cell setFrame:cellrect];
//    NSLog(@"Die Höhe der Zelle für %@: %f",autor,  cell.frame.size.height);
    
//    cell 
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize aSize;
    
    CGFloat initialSize = 40.0f;
    NSDictionary *dic = [self getDictionaryAtIndexPath:indexPath];
    NSString *text = [dic objectForKey:@"post_message"];
    aSize = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(280.0, 9999.9) lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat myheight;
    myheight = aSize.height + initialSize;
//    NSLog(@"Höhe des Frame1: %f",aSize.height);
    if(myheight < 100.0f) {
        myheight = 100.0f;
    }
//    NSLog(@"Höhe des Frame2: %f",myheight);
    return myheight;
}



-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath {
    return [self.postData objectForKey:[[self.postData allKeys] objectAtIndex:indexPath.row]];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
