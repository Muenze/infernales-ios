//
//  PostFormViewController.m
//  Infernales
//
//  Created by Guido Wehner on 21.03.13.
//
//

#import "PostFormViewController.h"


@implementation PostFormViewController

@synthesize forumId, threadId, formString, editMode, postValues;

-(id)init {
    self = [super init];
    if(self) {
        QRootElement *_root = [[QRootElement alloc] init];
        _root.grouped = YES;
        
        self.root = _root;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self buildNavigation];
    [self buildDialog];

    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


-(void)pressConfirmButton {
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwort"];
    
    NSMutableDictionary *fetched = [NSMutableDictionary new];
    [self.root fetchValueIntoObject:fetched];
    
    
    
    if(editMode != TRUE) {
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.infernales.de/portal/forum/postreply.json.php?forum_id=%@&thread_id=%@&username=%@&password=%@",forumId, threadId, username, password]];
        ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
        NSString *message = [fetched objectForKey:@"message"];
        [request setPostValue:message forKey:@"message"];
        [request setPostValue:@"1" forKey:@"postreply"];
        
        request.delegate = self;
        [request startAsynchronous];
        
    } else {
        NSString *urlString = [NSString stringWithFormat:@"http://www.infernales.de/portal/forum/postedit.json.php?username=%@&password=%@&post_id=%@", username, password, [postValues objectForKey:@"post_id"]];
        NSURL* url = [NSURL URLWithString:urlString];
        ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
        NSString *message = [fetched objectForKey:@"message"];
        [request setPostValue:message forKey:@"message"];
        [request setPostValue:@"1" forKey:@"savechanges"];
        [request setDelegate:self];
        [request startAsynchronous];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
//    NSLog(@"Response: %@", request);
    
    NSDictionary *response = [responseString JSONValue];
    if ([[response objectForKey:@"code"] compare:[NSNumber numberWithInt:0]] == NSOrderedSame) {
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        del.needsUpdatePost = true;
        NSUInteger *index = [self.navigationController.viewControllers indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if([obj isKindOfClass:[PostViewController class]]) {
                *stop = YES;
                return YES;
            }
            return NO;
        }];
        
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index] animated:YES];
    }
    
    // Use when fetching binary data
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

- (void)dealloc {
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}


-(void)buildNavigation {
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(pressConfirmButton)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
}

-(void)buildDialog {
    QSection *sec = [[QSection alloc] init];
    QMultilineElement *multi = [QMultilineElement alloc];
    
    if(self.editMode == TRUE) {
        [multi initWithTitle:@"Posttext"
               Value:self.formString
               Placeholder:@"Hier klicken"];
    } else {
        [multi initWithTitle:@"Posttext"
                       Value:@""
                 Placeholder:@"Hier klicken"];
    }
    
    multi.key = @"message";
    [sec addElement:multi];
    
    
    
    [self.root addSection:sec];
}


@end
