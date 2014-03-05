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
@synthesize forumData;
@synthesize manager = _manager;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadForumData {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Lade Forendaten";
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwort"];
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

        NSDictionary *params = @{};
        if(username.length > 0 && password.length > 0) {
            params = @{
                @"username": username,
                @"password": password
            };
        }

        
        [manager GET:@"http://www.infernales.de/portal/forum/index.json.iphone.php"
            parameters:params
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self reloadTableWithData:responseObject];
//                 dispatch_async(dispatch_get_main_queue(), ^{
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
//                 });
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"%@", error);
             }
         ];
//    });
}

- (void)viewDidLoad
{
    self.manager = [AFHTTPRequestOperationManager manager];
    [super viewDidLoad];
    self.title = @"Forum";
    
    [self loadForumData];
}

-(void)reloadTableWithData:(NSArray *)data {
    self.forumData = data;
    UITableView *tableView = (UITableView *)self.view;
    [tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self.forumData release];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self.manager operationQueue] cancelAllOperations];
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
    return [[self.forumData objectAtIndex:section] objectForKey:@"name"];
    
//    return [[[self.forumData objectForKey:[[self.forumData allKeys] objectAtIndex:section]] objectForKey:@"name"] decodeHtmlEntities];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.forumData objectAtIndex:section] objectForKey:@"forums"] count];
    
    
//    return [[[self.forumData objectForKey:[[self.forumData allKeys] objectAtIndex:section]] objectForKey:@"forum"] count];
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
            if([currentObject isKindOfClass:[ForumViewCell class]]) {
                cell = (ForumViewCell *) currentObject;
                break;
            }
        }
    }
    NSDictionary *dic = [[[[self.forumData objectAtIndex:indexPath.section] objectForKey:@"forums"] objectAtIndex:indexPath.row] retain];
    
    cell.mainLabel.text = [[dic objectForKey:@"name"] decodeHtmlEntities];
    NSDecimalNumber *dec = [dic objectForKey:@"hasnew"];
    
    if([dec compare:[NSNumber numberWithInt:1]] == NSOrderedSame) {
        cell.neuIndicator.image = [UIImage imageNamed:@"foldernew.gif"];
    }

    
    //
//    NSString *autor = @"Letzter Post: ";
    
    
//    autor = [autor stringByAppendingString:[dic objectForKey:@"user"]];
    
    NSDate *theDate = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"lastpost"] doubleValue]];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSString *date = [format stringFromDate:theDate];
    [format release];
    

    NSString *autor = [NSString stringWithFormat:@"Letzter Post: %@ am %@", [dic objectForKey:@"user"], date];

    cell.lastAutorLabel.text = autor;
    
    [dic release];
    // Configure the cell...
    return cell;
}

- (NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath {
    return [[[self.forumData objectAtIndex:indexPath.section] objectForKey:@"forums"] objectAtIndex:indexPath.row];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self getDictionaryAtIndexPath:indexPath];
    NSNumber *forumid = [dic objectForKey:@"forumid"];
    ThreadViewController *tvc = [[ThreadViewController alloc] initWithForumId:forumid];
    [tvc setThreadName:[dic objectForKey:@"name"]];
    [self.navigationController pushViewController:tvc animated:YES];
    [tvc release];
}

@end
