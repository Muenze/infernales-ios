//
//  ThreadFormViewController.m
//  Infernales
//
//  Created by Guido Wehner on 31.03.13.
//
//

#import "ThreadFormViewController.h"

@interface ThreadFormViewController ()

@end

@implementation ThreadFormViewController

@synthesize subject, forum_id;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
        ACPlaceholderTextView *tv = [[ACPlaceholderTextView alloc] initWithFrame:CGRectMake(20.0f, 85.0f, 275.0f, 115.0f)];
        tv.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        tv.delegate = self;
        tv.backgroundColor = [UIColor colorWithWhite:245/255.0f alpha:1];
        tv.scrollIndicatorInsets = UIEdgeInsetsMake(13, 0, 8, 6);
        tv.scrollsToTop = NO;
        tv.font = [UIFont systemFontOfSize:14];
        tv.autocorrectionType = UITextAutocorrectionTypeNo;
        tv.layer.borderColor = [[UIColor grayColor] CGColor];
        tv.layer.borderWidth = 2;
        [self.view addSubview:tv];
        message = tv;
        
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(pressSend:)];
        self.navigationItem.rightBarButtonItem = button;
        [button release];
    }
    return self;
}

-(IBAction)pressSend:(id)sender {
    NSString *message_string = message.text;
    NSString *subject_string = subject.text;
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwort"];
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.infernales.de/portal/forum/postnewthread.json?forum_id=%@&username=%@&password=%@",self.forum_id, username, password]];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:message_string forKey:@"message"];
    [request setPostValue:subject_string forKey:@"subject"];
    [request setPostValue:@"1" forKey:@"postnewthread"];
    
    request.delegate = self;
    [request startAsynchronous];
    
}



- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    
    NSLog(@"response: %@",responseString);
    
    NSDictionary *response = [responseString JSONValue];
    if ([[response objectForKey:@"code"] compare:[NSNumber numberWithInt:0]] == NSOrderedSame) {
//        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index] animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    // Use when fetching binary data
    //    NSData *responseData = [request responseData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    
}







- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
