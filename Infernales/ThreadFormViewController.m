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
@synthesize manager = _manager;

-(id)init {
    self = [super init];
    if (self) {
        // Custom initialization
        
        QRootElement *_root = [[QRootElement alloc] init];
        _root.grouped = YES;
        
        self.root = _root;
        self.manager = [AFHTTPRequestOperationManager manager];
        
    }
    return self;
    
}

-(IBAction)pressSend:(id)sender {
    
    NSMutableDictionary *fetched = [NSMutableDictionary new];
    [self.root fetchValueIntoObject:fetched];
    
    NSString *message_string = fetched[@"text"];
    NSString *subject_string = fetched[@"title"];
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwort"];
    
    NSString *url = [NSString
                    stringWithFormat:@"http://www.infernales.de/portal/forum/postnewthread.json.iphone.php?forum_id=%@&username=%@&password=%@",
                    self.forum_id,
                    username,
                    password];
    NSDictionary *postParams = @{
         @"message": message_string,
         @"subject": subject_string,
         @"postnewthread": @"1"
    };

    [self.manager POST:url parameters:postParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:@0]) {
            //        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index] animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fehler");
    }];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self.manager operationQueue] cancelAllOperations];
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
    text.delegate = self;
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

- (void)QEntryEditingChangedForElement:(QEntryElement *)element  andCell:(QEntryTableViewCell *)cell {
    cell.textField.text = element.textValue;
    [cell setNeedsLayout];
}

@end
