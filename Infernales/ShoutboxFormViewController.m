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

@synthesize manager = _manager;

-(id)init {
    self = [super init];
    if(self) {
        QRootElement *_root = [[QRootElement alloc] init];
        _root.grouped = YES;
        
        self.root = _root;
        
        self.manager = [AFHTTPRequestOperationManager manager];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    QSection *sec = [[QSection alloc] init];
    QMultilineElement *multi = [[QMultilineElement alloc]
                                initWithTitle:@"Shout Text"
                                Value:@""
                                Placeholder:@"Hier klicken"];
    multi.key = @"shout_message";
    multi.delegate = self;
    [sec addElement:multi];
    
    [self.root addSection:sec];
    
    
    
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(pressSend:)];
    self.navigationItem.rightBarButtonItem = button;
}

-(IBAction)pressSend:(id)sender {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Shout wird gespeichert";
    
    
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwort"];

    NSMutableDictionary *fetched = [NSMutableDictionary new];
    [self.root fetchValueIntoObject:fetched];
    fetched[@"post_shout"] = @"1";
    
    NSString *urlString = [NSString stringWithFormat:@"http://www.infernales.de/portal/forum/shoutbox.json.iphone.php?username=%@&password=%@", username, password];
    
    [self.manager POST:urlString parameters:fetched success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        [self redirectWithResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fehler" message:@"Fehler beim speichern" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        NSLog(@"Error: %@", error);
    }];
}

-(void)redirectWithResponse:(NSDictionary *)response {
    if ([response[@"code"] isEqualToNumber:@0]) {
        NSUInteger index = [self.navigationController.viewControllers indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if([obj isKindOfClass:[ShoutboxViewController class]]) {
                *stop = YES;
                return YES;
            }
            return NO;
        }];
        
        [self.navigationController popToViewController:[self.navigationController viewControllers][index] animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)QEntryEditingChangedForElement:(QEntryElement *)element  andCell:(QEntryTableViewCell *)cell {
    cell.textField.text = element.textValue;
    [cell setNeedsLayout];
}

@end
