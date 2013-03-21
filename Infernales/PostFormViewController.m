//
//  PostFormViewController.m
//  Infernales
//
//  Created by Guido Wehner on 21.03.13.
//
//

#import "PostFormViewController.h"

@interface PostFormViewController ()

@end

@implementation PostFormViewController

@synthesize forumId, threadId, formText;

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
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(pressConfirmButton:)];
    //    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonSystemItemSave target:self action:@selector(postInForum:)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];

    
    // Do any additional setup after loading the view from its nib.
}


//-(void)setThreadId:(NSInteger *)thread_id {
//    threadId = thread_id;
//}
//
//
//-(void)setForumId:(NSInteger *)forum_id {
//    forumId = forum_id;
//}





-(IBAction)pressConfirmButton:(id)sender {
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"www.infernales.de/portal/forum/viewthread.php?thread_id=%@",self.threadId]];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
