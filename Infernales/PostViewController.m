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

@synthesize threadId, postData, threadName;

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

- (id)initWithThreadId:(NSInteger *)threadid andThreadName:(NSString *)threadName {
    self = [super init];
    if(self) {
        self.threadId = threadid;
        self.threadName = threadName;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.postData = [self loadPostData];
    self.title = threadName;
    
   
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStylePlain target:self action:@selector(postInForum:)];
//    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonSystemItemSave target:self action:@selector(postInForum:)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];


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
    NSString *autor = [dic objectForKey:@"user_name"];
    autor = [autor decodeHtmlEntities];
    
    NSDate *theDate = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"post_datestamp"] doubleValue]];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSString *date = [format stringFromDate:theDate];
    
    autor = [autor stringByAppendingFormat:@" am "];
    autor = [autor stringByAppendingFormat:date];
    
    
    
    
    cell.autorLabel.text = autor;
    
    cell.mainLabel.editable = NO;
//    cell.mainLabel.dataDetectorTypes = UIDataDetectorTypeAll;
    
    NSString *post_message = [dic objectForKey:@"post_message"];
    post_message = [post_message decodeHtmlEntities];
    
    cell.mainLabel.text = post_message;
//    [cell.mainLabel sizeToFit];
    
    CGSize aSize;
    aSize = [post_message sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300.0, 9999.9) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect rec = cell.mainLabel.frame;
    rec.size.height = aSize.height;
    [cell.mainLabel setFrame:rec];
    
//    CGRect MSLabelRect = CGRectMake(20.0f, 20.0, 280.0f, aSize.height);
//    MSTextView* mstv = [[MSTextView alloc] initWithFrame:MSLabelRect];
//    mstv.text = post_message;
//    [cell.contentView addSubview:mstv];
    
    
    
//    if([cell.styledLabel isKindOfClass:[TTStyledTextLabel class]]) {
//        [cell.styledLabel removeFromSuperview];
//        cell.styledLabel = nil;
//    }
    
//    CGRect styledLabelRect = CGRectMake(20.0f, 20.0, 280.0f, aSize.height);
//    NSLog(@"Ich setze die Höhe als %f",aSize.height);
//    TTStyledTextLabel* label = [[[TTStyledTextLabel alloc] initWithFrame:styledLabelRect] autorelease];
//    TTStyledTextLabel* label = [[TTStyledTextLabel alloc] initWithFrame:styledLabelRect];
//    TTStyledText* styleText = [TTStyledText textFromXHTML:post_message lineBreaks:YES URLs:YES];
    
//    NSLog(@"Style Text: %@", styleText);
//    label.text = styleText;
//    cell.styledLabel = label;
//    [cell.contentView addSubview:label];
    
    
    
//    [label release];
    

    
    
//    NSLog(@"Die Höhe der Berechnung für %@: %f",autor, aSize.height);
//    NSLog(@"Die Höhe der Zelle für %@: %f",autor,  cell.frame.size.height);
    CGRect myframe = [cell.mainLabel frame];
    myframe.size.height = aSize.height;
    [cell.mainLabel setFrame:myframe];
//    NSLog(@"Die Höhe des Label für %@: %f", autor, cell.mainLabel.frame.size.height);
    
    CGRect cellrect = cell.frame;
    cellrect.size.height = aSize.height+25;
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
    NSDictionary *dic = [self getDictionaryAtIndexPath:indexPath];

    
     PostdetailViewController *pdvc = [[PostdetailViewController alloc] initWithNibName:@"PostdetailViewController" bundle:nil];
    [pdvc setPostValues:dic];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:pdvc animated:YES];
     [pdvc release];
    
}

@end
