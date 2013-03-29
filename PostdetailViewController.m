//
//  PostdetailViewController.m
//  Infernales
//
//  Created by Guido Wehner on 13.03.13.
//
//

#import "PostdetailViewController.h"

@interface PostdetailViewController ()

@end

@implementation PostdetailViewController

@synthesize myTextView, postValues;

-(void)setPostValues:(NSDictionary *)paramPostValues {
    postValues = paramPostValues;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStylePlain target:self action:@selector(postInForum:)];
    //    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonSystemItemSave target:self action:@selector(postInForum:)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    
    // Do any additional setup after loading the view from its nib.
    myTextView.text = [[postValues valueForKey:@"post_message"] decodeHtmlEntities];
    NSLog(@"%@",postValues);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [myTextView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyTextView:nil];
    [myTextView release];
    [super viewDidUnload];
}


-(IBAction)postInForum:(id)sender {
    PostFormViewController *pfvc = [[PostFormViewController alloc] initWithNibName:@"PostFormViewController" bundle:nil];
    
    pfvc.threadId = [postValues objectForKey:@"thread_id"];
    pfvc.forumId = [postValues objectForKey:@"forum_id"];
    pfvc.formString = [[postValues objectForKey:@"post_message"] decodeHtmlEntities];
    
    [self.navigationController pushViewController:pfvc animated:YES];
    [pfvc release];
}


@end
