//
//  ShoutboxViewController.m
//  Infernales
//
//  Created by Guido Wehner on 26.03.13.
//
//

#import "ShoutboxViewController.h"

@interface ShoutboxViewController ()

@end

@implementation ShoutboxViewController

@synthesize shouts = _shouts;
@synthesize manager = _manager;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadShoutboxData {

    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwort"];
    
    NSDictionary *params = @{@"username": username, @"password": password};
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Lade Shoutbox Daten";
    
    [self.manager GET:@"http://www.infernales.de/portal/forum/shoutbox.json.iphone.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        [self reloadTableViewsWithData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", error);
        [hud hide:YES];
    }];
}

-(void)reloadTableViewsWithData:(NSArray *)array {
    self.shouts = array;
    UITableView *table = (UITableView *)self.view;
    [table reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.manager = [AFHTTPRequestOperationManager manager];

    self.title = @"Shoutbox";
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"shout!" style:UIBarButtonItemStylePlain target:self action:@selector(pressShout:)];
    self.navigationItem.rightBarButtonItem = button;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self loadShoutboxData];
}

-(IBAction)pressShout:(id)sender {
    ShoutboxFormViewController *sfc = [[ShoutboxFormViewController alloc] init];
    [self.navigationController pushViewController:sfc animated:YES];
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
    return [self.shouts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self getDictionaryAtIndexPath:indexPath];
    static NSString *CellIdentifier = @"ShoutboxViewCell";
    ShoutboxViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if(!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ShoutboxViewCell" owner:nil options:nil];
        for(id currentObject in topLevelObjects) {
            if([currentObject isKindOfClass:[ShoutboxViewCell class]]) {
                cell = (ShoutboxViewCell *) currentObject;
                break;
            }
        }
    }

    NSDate *theDate = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"datestamp"] doubleValue]];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSString *date = [format stringFromDate:theDate];
    
    NSString *autor = [NSString stringWithFormat:@"%@ am %@", [[dic objectForKey:@"user"] decodeHtmlEntities], date];

    cell.authorLabel.text = autor;



    // Configure the cell...
    cell.mainLabel.text = [[dic objectForKey:@"message"] decodePhpFusionTags];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}



-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath {
    return [self.shouts objectAtIndex:indexPath.row];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    NSDictionary *dic = [self getDictionaryAtIndexPath:indexPath];
    
    ShoutboxDetailViewController *sbdvc = [[ShoutboxDetailViewController alloc] initWithNibName:@"ShoutboxDetailViewController" bundle:nil];
    sbdvc.shout = dic;
    [self.navigationController pushViewController:sbdvc animated:YES];
}

@end
