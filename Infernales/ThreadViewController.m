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

@synthesize threadData, forumId, threadName;
@synthesize hud = _hud;

-(void)loadThreadData {
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwort"];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    self.hud.labelText = @"Lade Threaddaten";
    
    
    NSDictionary *params = @{
        @"forum_id": forumId
    };
    if([username length] > 0 && [password length] > 0) {
        params = @{
                   @"username": username,
                   @"password": password,
                   @"forum_id": forumId
        };
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager
        GET:@"http://www.infernales.de/portal/forum/viewforum.json.iphone.php"
        parameters:params
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self reloadTableWithData:responseObject];
            [self.hud hide:YES];
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            [self.hud hide:YES];
        }
    ];
}

-(void)reloadTableWithData:(NSArray *)data {
    self.threadData = data;
    UITableView *tableView = (UITableView *)self.view;
    [tableView reloadData];
}

-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath {
    return [self.threadData objectAtIndex:indexPath.row];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithForumId:(NSNumber *)fid {
    self = [super init];
    if(self) {
        self.forumId = fid;
    }
    return self;
}

-(void)setNameForThread:(NSString *)thread_name {
    threadName = thread_name;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSLog(@"%@",threadName);
    self.title = threadName;
    self.title = [self.title decodeHtmlEntities];
    
//    self.threadData = [self loadThreadData];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"New Thread" style:UIBarButtonItemStylePlain target:self action:@selector(postNewThread:)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    

}

-(void)viewWillAppear:(BOOL)animated {
    [self loadThreadData];
}

-(IBAction)postNewThread:(id)sender {
    ThreadFormViewController *tfvc = [[ThreadFormViewController alloc] init];
    tfvc.forum_id = self.forumId;
    [self.navigationController pushViewController:tfvc animated:YES];
    [tfvc release];
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
            if([currentObject isKindOfClass:[ThreadViewCell class]]) {
                cell = (ThreadViewCell *) currentObject;
                break;
            }
        }
        
//        cell = [[ThreadViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dic = [self getDictionaryAtIndexPath:indexPath];
    
    NSNumber *isNew = [dic objectForKey:@"isnew"];
    if([isNew isEqualToNumber:@0]) {
    } else {
        UIImage *im = [UIImage imageNamed:@"foldernew.gif"];
        cell.imageView.image = im;
    }
    
    NSNumber *isSticky = [dic objectForKey:@"sticky"];
    if([isSticky isEqualToNumber:@1]) {
        UIImage *stick = [UIImage imageNamed:@"pin.png"];
        cell.stickyIndicator.image = stick;
    } else {
        cell.stickyIndicator.image = nil;
    }
    
    
    
    
    NSString *author = [dic objectForKey:@"lastuser"];
    
    NSDate *theDate = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"thread_lastpost"] doubleValue]];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd.MM.yyyy"];
    NSString *date = [format stringFromDate:theDate];
    [format release];
    
    
    NSString *erstelltText = [NSString stringWithFormat:@"Author: %@, letzter Beitrag am: %@", author, date];

    
    cell.threadShortDescription.text = erstelltText;
    NSString *name = [dic objectForKey:@"name"];
    if(name) {
        name = [name decodeHtmlEntities];
        cell.threadNameLabel.text = name;
    } else {
    }
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self getDictionaryAtIndexPath:indexPath];

    NSNumber *thread_id = [dic objectForKey:@"thread_id"];
    NSString *thread_name = [dic objectForKey:@"name"];
    thread_name = [thread_name decodeHtmlEntities];
    NSDecimalNumber *locked = [dic objectForKey:@"locked"];
    bool lock = NO;
    if([locked compare:[NSNumber numberWithInt:1]] == NSOrderedSame) {
        lock = YES;
    }
    
    
    PostViewController *pvc = [[PostViewController alloc] initWithForumId:forumId withThreadId:thread_id andThreadName:thread_name];
    pvc.locked = lock;
    [self.navigationController pushViewController:pvc animated:YES];
    [pvc release];
}

@end
