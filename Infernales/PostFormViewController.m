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
@synthesize manager = _manager;
@synthesize hud = _hud;

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
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    if(editMode != TRUE) {
        
        NSString *urlString = [NSString stringWithFormat:@"http://www.infernales.de/portal/forum/postreply.json.iphone.php?forum_id=%@&thread_id=%@&username=%@&password=%@",forumId, threadId, username, password];
        fetched[@"postreply"] = @"1";
        
        [self.manager POST:urlString parameters:fetched success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self requestFinished:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self requestHasError];
            NSLog(@"%@", error);
        }];
        
    } else {
        NSString *urlString = [NSString stringWithFormat:@"http://www.infernales.de/portal/forum/postedit.json.iphone.php?username=%@&password=%@&post_id=%@", username, password, postValues[@"post_id"]];

        fetched[@"savechanges"] = @"1";
        
        [self.manager POST:urlString parameters:fetched success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self requestFinished:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self requestHasError];
            NSLog(@"%@", error);
        }];
    }
}

-(void)requestHasError {
    [self.hud hide:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fehler" message:@"Fehler bei der Speicherung" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (void)requestFinished:(NSDictionary *)response
{
    [self.hud hide:YES];
    if ([response[@"code"] compare:@0] == NSOrderedSame) {
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        del.needsUpdatePost = true;
        NSUInteger index = [self.navigationController.viewControllers indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if([obj isKindOfClass:[PostViewController class]]) {
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

- (void)viewDidUnload {
    [super viewDidUnload];
}


-(void)buildNavigation {
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(pressConfirmButton)];
    self.navigationItem.rightBarButtonItem = button;
}

-(void)buildDialog {
    QSection *sec = [[QSection alloc] init];
    QMultilineElement *multi = [QMultilineElement alloc];
    if(self.editMode == TRUE) {
        multi = [multi initWithTitle:@"Posttext"
               Value:self.formString
               Placeholder:@"Hier klicken"];
    } else {
        multi = [multi initWithTitle:@"Posttext"
                       Value:@""
                 Placeholder:@"Hier klicken"];
    }
    
    multi.delegate = self;
    multi.key = @"message";
    [sec addElement:multi];
    
    
    
    [self.root addSection:sec];
}

- (void)QEntryEditingChangedForElement:(QEntryElement *)element  andCell:(QEntryTableViewCell *)cell {
    cell.textField.text = element.textValue;
    [cell setNeedsLayout];
}

@end
