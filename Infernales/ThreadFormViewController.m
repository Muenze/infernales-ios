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

@synthesize forum_id;

-(id)init {
    self = [super init];
    if (self) {
        // Custom initialization
        
        QRootElement *_root = [[QRootElement alloc] init];
        _root.grouped = YES;
        
        self.root = _root;
    }
    return self;
    
}

-(IBAction)pressSend:(id)sender {
    
    NSMutableDictionary *fetched = [NSMutableDictionary new];
    [self.root fetchValueIntoObject:fetched];
    
    NSString *message_string = [fetched objectForKey:@"text"];
    NSString *subject_string = [fetched objectForKey:@"title"];
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
}







- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self buildQuickDialog];
    [self buildNavigation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buildQuickDialog {
    QSection *sec = [[QSection alloc] initWithTitle:@"Neuen Thread anlegen"];
    QEntryElement *title = [[QEntryElement alloc]
                            initWithTitle:@"Titel"
                            Value:@""
                            Placeholder:@"Threadtitel eingeben"];
    title.key = @"title";
    [sec addElement:title];
    
    QMultilineElement *text = [[QMultilineElement alloc]
                               initWithTitle:@"Text"
                               Value:@""
                               Placeholder:@"Hier klicken"];
    text.key = @"text";
    [sec addElement:text];
    
    
    
    [self.root addSection:sec];
}

-(void)buildNavigation {
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithTitle:@"Send"
                               style:UIBarButtonItemStylePlain
                               target:self
                               action:@selector(pressSend:)];
    self.navigationItem.rightBarButtonItem = button;

}

@end
