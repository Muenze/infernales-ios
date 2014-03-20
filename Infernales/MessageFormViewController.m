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

@synthesize manager = _manager;

-(id)init {
    if(self = [super init]) {
        QRootElement *_root = [[QRootElement alloc] init];
        _root.grouped = YES;
        
        self.root = _root;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    QSection *sec = [[QSection alloc] initWithTitle:@"Message beantworten"];
    
    QEntryElement *subject = [[QEntryElement alloc] initWithKey:@"subject"];
    subject.title = @"Subject";
    subject.textValue = [NSString stringWithFormat:@"RE: %@", [self.messageData objectForKey:@"message_subject"]];
    
    [sec addElement:subject];
    
    
    QMultilineElement *message = [[QMultilineElement alloc] initWithKey:@"message"];
    message.title = @"Message";
    message.delegate = self;
    message.textValue = [self.messageData objectForKey:@"message_message"];
    
    
    [sec addElement:message];
    
    [self.root addSection:sec];
    
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"antworten" style:UIBarButtonItemStyleBordered target:self action:@selector(sendMessage:)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
}

- (void)QEntryEditingChangedForElement:(QEntryElement *)element  andCell:(QEntryTableViewCell *)cell {
    cell.textField.text = element.textValue;
    [cell setNeedsLayout];
}


-(IBAction)sendMessage:(id)sender {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *username = [def objectForKey:@"username"];
    NSString *password = [def objectForKey:@"passwort"];
    
    QSection *sec = [self.root getSectionForIndex:0];
    
    QMultilineElement *multi = [sec getVisibleElementForIndex:1];
//    [multi
    NSLog(@"Done");
//    NSLog(@"%@", [sec getVisibleElementForIndex:1]);
    
//    NSMutableDictionary *params = [NSMutableDictionary new];
//    [self.root fetchValueIntoObject:params];
//    
//    [params setObject:[self.messageData objectForKey:@"user_id"] forKey:@"msg_send"];
//    [params setObject:@"Senden" forKey:@"send_message"];
//    
//    NSString *urlString = [NSString stringWithFormat:@"http://www.infernales.de/portal/forum/messages.json.iphone.php?username=%@&password=%@&msg_send=0", username, password];
//
//    [self.manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSUInteger index = [self.navigationController.viewControllers indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
//                if([obj isKindOfClass:[MessagesViewController class]]) {
//                    *stop = YES;
//                    return YES;
//                }
//                return NO;
//            }];
//            
//            [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index] animated:YES];
//        });
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fehler" message:@"Fehler beim speichern" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_messageData release];
    [super dealloc];
}
@end
