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
    
    // Do any additional setup after loading the view from its nib.
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
    
    NSString *urlString = [NSString stringWithFormat:@"http://www.infernales.de/portal/forum/collections.json.php?username=%@&password=%@&collection=alluser", [defaults objectForKey:@"username"], [defaults objectForKey:@"passwort"]];
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
    
    if ([identifier compare:@"recieverMenu"] == NSOrderedSame){
        _txtReciever.text = ReturnValue;
    }
}

@end
