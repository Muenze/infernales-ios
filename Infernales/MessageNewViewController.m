//
//  MessageNewViewController.m
//  Infernales
//
//  Created by Guido Wehner on 28.04.13.
//
//

#import "MessageNewViewController.h"

@interface MessageNewViewController ()

@end

@implementation MessageNewViewController

@synthesize svMyScrollView  = _svMyScrollView;
@synthesize recieverMenu;
@synthesize titleArray      = _titleArray;
@synthesize valueArray      = _valueArray;
@synthesize txtMessage      = _txtMessage;
@synthesize txtReciever     = _txtReciever;
@synthesize txtSubject      = _txtSubject;
@synthesize recieverId      = _recieverId;

-(id)init {
    self = [super init];
    if(self) {
        
    }
    return self;
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
    
    [self fetchUsers];
    
    recieverMenu = [[UIDropDownMenu alloc] initWithIdentifier:@"recieverMenu"];
    recieverMenu.ScaleToFitParent = TRUE;
    recieverMenu.titleArray = _titleArray;
    recieverMenu.valueArray = _valueArray;
    [recieverMenu makeMenu:_txtReciever targetView:self.view];
    recieverMenu.delegate = self;
    
    
    _txtMessage = [[UITextView alloc] initWithFrame:CGRectMake(20.0f, 148.0f, 280.0f, 120.0f)];
    _txtMessage.autocorrectionType = UITextAutocorrectionTypeNo;
    _txtMessage.layer.borderColor = [[UIColor grayColor] CGColor];
    _txtMessage.layer.borderWidth = 2;
    
    [_svMyScrollView addSubview:_txtMessage];
    
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"send" style:UIBarButtonItemStylePlain target:self action:@selector(sendMessage:)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
//    [self.view addSubview:_txtMessage];
    
    // Do any additional setup after loading the view from its nib.
}


-(IBAction)sendMessage:(id)sender {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *username = [def objectForKey:@"username"];
    NSString *password = [def objectForKey:@"passwort"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.infernales.de/portal/forum/messages.json.php?username=%@&password=%@&msg_send=0", username, password]]];
    [request setPostValue:_txtSubject.text forKey:@"subject"];
    [request setPostValue:_txtMessage.text forKey:@"message"];
    [request setPostValue:_recieverId forKey:@"msg_send"];
    [request setPostValue:@"Senden" forKey:@"send_message"];
    
    [request setCompletionBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
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
    [_svMyScrollView release];
    [_txtSubject release];
    [_txtMessage release];
    [_txtReciever release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setSvMyScrollView:nil];
    [self setTxtSubject:nil];
    [self setTxtMessage:nil];
    [self setTxtReciever:nil];
    [super viewDidUnload];
}

#pragma mark userFunctions

-(void)fetchUsers {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *urlString = [NSString stringWithFormat:@"http://www.infernales.de/portal/forum/collections.json.iphone.php?username=%@&password=%@&collection=alluser", [defaults objectForKey:@"username"], [defaults objectForKey:@"passwort"]];
    NSDictionary *dic = [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] JSONValue];
    _titleArray = [dic objectForKey:@"title"];
    _valueArray = [dic objectForKey:@"value"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


#pragma mark UIDropDownMenuDelegate functions

- (void) DropDownMenuDidChange:(NSString *)identifier :(NSString *)ReturnValue{
    
    _recieverId = ReturnValue;
    if ([identifier compare:@"recieverMenu"] == NSOrderedSame){
        NSUInteger index = [_valueArray indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if([obj isEqualToString:ReturnValue]) {
                *stop = YES;
                return YES;
            }
            return NO;
        }];

        
        NSString *recieverString = [_titleArray objectAtIndex:index];
        _txtReciever.text = recieverString;
        
    }
}

@end
