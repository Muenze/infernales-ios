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

@synthesize shouts;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(OrderedDictionary *)loadShoutboxData {

    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwort"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://www.infernales.de/portal/forum/shoutbox.json.php?username=%@&password=%@", username, password];
    return [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] JSONValue];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Shoutbox";
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"shout!" style:UIBarButtonItemStylePlain target:self action:@selector(pressShout:)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated {
    self.shouts = [self loadShoutboxData];
    [self.view reloadData];
}

-(IBAction)pressShout:(id)sender {
    ShoutboxFormViewController *sfc = [[ShoutboxFormViewController alloc] initWithNibName:@"ShoutboxFormViewController" bundle:nil];
    [self.navigationController pushViewController:sfc animated:YES];
    [sfc release];
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
    //    PostViewCell *cell = nil;
    
    // Configure the cell...
    if(!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ShoutboxViewCell" owner:nil options:nil];
        for(id currentObject in topLevelObjects) {
            if([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (ShoutboxViewCell *) currentObject;
                break;
            }
        }
    }

    NSString *autor = [dic objectForKey:@"user"];
    autor = [autor decodeHtmlEntities];

    NSDate *theDate = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"datestamp"] doubleValue]];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSString *date = [format stringFromDate:theDate];
    [format release];

    autor = [autor stringByAppendingFormat:@" am "];
    autor = [autor stringByAppendingFormat:date];

    cell.authorLabel.text = autor;



    // Configure the cell...
    cell.mainLabel.text = [[dic objectForKey:@"message"] decodeHtmlEntities];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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


-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath {
    return [self.shouts objectForKey:[[self.shouts allKeys] objectAtIndex:indexPath.row]];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    NSDictionary *dic = [self getDictionaryAtIndexPath:indexPath];
    
    ShoutboxDetailViewController *sbdvc = [[ShoutboxDetailViewController alloc] initWithNibName:@"ShoutboxDetailViewController" bundle:nil];
    sbdvc.shout = dic;
    [self.navigationController pushViewController:sbdvc animated:YES];
    [sbdvc release];
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
