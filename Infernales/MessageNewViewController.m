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

@synthesize titleArray      = _titleArray;
@synthesize valueArray      = _valueArray;
@synthesize recieverId      = _recieverId;
@synthesize manager         = _manager;
@synthesize userCollection  = _userCollection;
@synthesize users           = _users;
@synthesize hud             = _hud;

-(id)init {
    self = [super init];
    if(self) {
        
        QRootElement *_root = [[QRootElement alloc] init];
//        QRootElement *_root = [[QRootElement alloc] initWithJSONFile:@"section"];
        _root.grouped = YES;
        
        self.root = _root;
        
        self.manager = [AFHTTPRequestOperationManager manager];
    }
    return self;
}

- (void)buildDialog
{
    QSection *sec = [[QSection alloc] init];
    
    QAutoEntryElement *autoReciever = [[QAutoEntryElement alloc] init];
    autoReciever.title = @"Reciever";
    autoReciever.key = @"reciever";
    autoReciever.autoCompleteValues = self.users;

    [sec addElement:autoReciever];
    
    QEntryElement *subject = [[QEntryElement alloc] initWithKey:@"subject"];
    subject.title = @"Subject";
    
    [sec addElement:subject];
    
    QMultilineElement *text = [[QMultilineElement alloc] initWithKey:@"message"];
    text.title = @"Message";
    text.delegate = self;
    [sec addElement:text];
    
    [self.root addSection:sec];
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [self.root fetchValueIntoObject:dic];
    
    NSLog(@"Dic: %@",dic);
    
    [self.quickDialogTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self fetchUsers];
   
    
    
    
    

    
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"send" style:UIBarButtonItemStylePlain target:self action:@selector(sendMessage:)];
    self.navigationItem.rightBarButtonItem = button;
//    [self.view addSubview:_txtMessage];
    
    // Do any additional setup after loading the view from its nib.
}


-(IBAction)sendMessage:(id)sender {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *username = [def objectForKey:@"username"];
    NSString *password = [def objectForKey:@"passwort"];
    
    NSMutableDictionary *values = [NSMutableDictionary new];
    [self.root fetchValueIntoObject:values];
    
    values[@"msg_send"] = (self.userCollection)[values[@"reciever"]];
    values[@"send_message"] = @"Senden";

    [self.manager POST:[NSString stringWithFormat:@"http://www.infernales.de/portal/forum/messages.json.iphone.php?username=%@&password=%@&msg_send=0", username, password] parameters:values success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fehler" message:@"Fehler bei der Speicherun" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark userFunctions

-(void)fetchUsers {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *urlString = @"http://www.infernales.de/portal/forum/collections.json.iphone.php";
    NSDictionary *params = @{
                             @"username": [defaults objectForKey:@"username"],
                             @"password": [defaults objectForKey:@"passwort"],
                             @"collection": @"alluser"
                             };

    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"Lade Empfänger";
    
    
    
    
    [self.manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.userCollection = responseObject[@"data"];
        self.users = responseObject[@"userarray"];
        [self.hud hide:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self buildDialog];
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fehler" message:@"Konnte Benutzerliste nicht abrufen" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [self.hud hide:YES];
        [alert show];
        NSLog(@"Error: %@", error);
    }];
}

- (void)QEntryEditingChangedForElement:(QEntryElement *)element  andCell:(QEntryTableViewCell *)cell {
    cell.textField.text = element.textValue;
    [cell setNeedsLayout];
}

@end
