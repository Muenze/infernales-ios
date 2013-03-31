//
//  ShoutboxFormViewController.m
//  Infernales
//
//  Created by Guido Wehner on 31.03.13.
//
//

#import "ShoutboxFormViewController.h"

@interface ShoutboxFormViewController ()

@end

@implementation ShoutboxFormViewController

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
    
    ACPlaceholderTextView *tv = [[ACPlaceholderTextView alloc] initWithFrame:CGRectMake(20.0f, 20.0f, 275.0f, 160.0f)];
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
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)pressSend:(id)sender {
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwort"];

    NSString *message_string = message.text;

    
    NSString *urlString = [NSString stringWithFormat:@"http://www.infernales.de/portal/forum/shoutbox.json.php?username=%@&password=%@", username, password];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:message_string forKey:@"shout_message"];
    [request setPostValue:@"1" forKey:@"post_shout"];
    
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
        NSUInteger index = [self.navigationController.viewControllers indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if([obj isKindOfClass:[ShoutboxViewController class]]) {
                *stop = YES;
                return YES;
            }
            return NO;
        }];
        
        
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index] animated:YES];
//        [self.navigationController popViewControllerAnimated:YES];
    }
    
    // Use when fetching binary data
    //    NSData *responseData = [request responseData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
