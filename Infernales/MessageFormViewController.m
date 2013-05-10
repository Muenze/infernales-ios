//
//  MessageFormViewController.m
//  Infernales
//
//  Created by Guido Wehner on 10.05.13.
//
//

#import "MessageFormViewController.h"

@interface MessageFormViewController ()

@end

@implementation MessageFormViewController

@synthesize tvMessage = _tvMessage;
@synthesize txtSubject = _txtSubject;
@synthesize messageData = _messageData;
@synthesize svMyScrollView = _svMyScrollView;


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
    
    
    _tvMessage = [[UITextView alloc] initWithFrame:CGRectMake(15.0f, 88.0f, 290.0f, 120.0f)];
    _tvMessage.autocorrectionType = UITextAutocorrectionTypeNo;
    _tvMessage.layer.borderColor = [[UIColor grayColor] CGColor];
    _tvMessage.layer.borderWidth = 2;
    
    [_svMyScrollView addSubview:_tvMessage];
    
    _txtSubject.text = [NSString stringWithFormat:@"RE: %@",[_messageData objectForKey:@"message_subject"]];
    _tvMessage.text = [_messageData objectForKey:@"message_message"];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"antworten" style:UIBarButtonItemStyleBordered target:self action:@selector(sendMessage:)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)sendMessage:(id)sender {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *username = [def objectForKey:@"username"];
    NSString *password = [def objectForKey:@"passwort"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.infernales.de/portal/forum/messages.json.php?username=%@&password=%@&msg_send=0", username, password]]];
    [request setPostValue:_txtSubject.text forKey:@"subject"];
    [request setPostValue:_tvMessage.text forKey:@"message"];
    [request setPostValue:[_messageData objectForKey:@"user_id"] forKey:@"msg_send"];
    [request setPostValue:@"Senden" forKey:@"send_message"];
    
    [request setCompletionBlock:^{

        NSUInteger index = [self.navigationController.viewControllers indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if([obj isKindOfClass:[MessagesViewController class]]) {
                *stop = YES;
                return YES;
            }
            return NO;
        }];
        
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index] animated:YES];
        
        
//        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [request setFailedBlock:^{
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [request startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_lblSubject release];
    [_lblMessage release];
    [_txtSubject release];
    [_messageData release];
    [_svMyScrollView release];
    [super dealloc];
}
@end
