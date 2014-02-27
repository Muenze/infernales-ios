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
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSMutableArray *theButtons = [NSMutableArray arrayWithCapacity:2];
//    if([[postValues objectForKey:@"thread_locked"] compare:[NSNumber numberWithInt:0]] == NSOrderedSame) {
//        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStylePlain target:self action:@selector(postInForum:)];
//        [theButtons addObject:button];
//        //        self.navigationItem.rightBarButtonItem = button;
//        [button release];
//    }

    
    if([[postValues objectForKey:@"user_name"] isEqualToString:[def objectForKey:@"username"]]) {
        UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editInForum:)];
        [theButtons addObject:editButton];
        [editButton release];
        
    }

    
    self.navigationItem.rightBarButtonItems = [theButtons copy];
    // Do any additional setup after loading the view from its nib.
    myTextView.text = [[postValues valueForKey:@"post_message"] decodeHtmlEntities];
//    NSLog(@"%@",postValues);
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
    PostFormViewController *pfvc = [[PostFormViewController alloc] init];
    
    pfvc.threadId = (NSInteger *)[postValues objectForKey:@"thread_id"];
    pfvc.forumId = (NSInteger *)[postValues objectForKey:@"forum_id"];
//    pfvc.formString = [[postValues objectForKey:@"post_message"] decodeHtmlEntities];
    
    [self.navigationController pushViewController:pfvc animated:YES];
    [pfvc release];
}

-(IBAction)editInForum:(id)sender {
    PostFormViewController *pfvc = [[PostFormViewController alloc] init];
    
    pfvc.threadId = (NSInteger *)[postValues objectForKey:@"thread_id"];
    pfvc.forumId = (NSInteger *)[postValues objectForKey:@"forum_id"];
    pfvc.formString = [[postValues objectForKey:@"post_message"] decodeHtmlEntities];
    pfvc.editMode = TRUE;
    pfvc.postValues = postValues;
    
    [self.navigationController pushViewController:pfvc animated:YES];
    [pfvc release];
}



@end
