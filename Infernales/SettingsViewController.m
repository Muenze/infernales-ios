//
//  SettingsViewController.m
//  Infernales
//
//  Created by Guido Wehner on 12.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        QRootElement *_root = [[QRootElement alloc] init];
        _root.grouped = YES;
        self.root = _root;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self buildNavigationButton];
    [self buildQuickDialog];
    
    // Do any additional setup after loading the view from its nib.
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)saveSettings:(id)sender {
    NSMutableDictionary *fetchValues = [NSMutableDictionary new];
    [self.root fetchValueIntoObject:fetchValues];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[fetchValues objectForKey:@"username"] forKey:@"username"];
    if ([[fetchValues allKeys] containsObject:@"password"] ) {
        [defaults setObject:[fetchValues objectForKey:@"password"] forKey:@"passwort"];
    }
    [defaults synchronize];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)buildNavigationButton {
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithTitle:@"save"
                               style:UIBarButtonItemStylePlain
                               target:self
                               action:@selector(saveSettings:)];
    
    self.navigationItem.rightBarButtonItem = button;
    
}

-(void)buildQuickDialog {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    QSection *sec1 = [[QSection alloc] initWithTitle:@"Benutzerdaten"];
    
    QEntryElement *benutzernameField = [[QEntryElement alloc]
                                        initWithTitle:@"Benutzername"
                                        Value:[userDefaults objectForKey:@"username"]
                                        Placeholder:@"Login eingeben"];
    benutzernameField.key = @"username";
    
    
    QEntryElement *passwordField = [[QEntryElement alloc]
                                    initWithTitle:@"Passwort"
                                    Value:[userDefaults objectForKey:@"passwort"]];
    passwordField.secureTextEntry = YES;
    passwordField.key = @"password";
    passwordField.value = [userDefaults objectForKey:@"passwort"];
    
    
    QTextElement *textField = [[QTextElement alloc] initWithText:@"Für den Betrieb der App muss ein valider Forenbenutzer login von http://www.infernales.de eingegeben werden. Im Fehlerfall kann die App crashen"];
    
    
    [sec1 addElement:benutzernameField];
    [sec1 addElement:passwordField];
    [sec1 addElement:textField];
    [self.root addSection:sec1];
}

@end


