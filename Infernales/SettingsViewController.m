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

@synthesize username, usernameLabel, passwort, passwortLabel;

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
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonSystemItemSave target:self action:@selector(saveSettings:)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *passwort_text = [defaults objectForKey:@"passwort"];
    NSString *username_text = [defaults objectForKey:@"username"];
    NSLog(@"%@", defaults);
    if (passwort_text) {
        self.passwort.text = passwort_text;
    }
    if(username_text) {
        self.username.text = username_text;
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [usernameLabel release];
    [username release];
    [passwort release];
    [passwortLabel release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)saveSettings:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.username.text forKey:@"username"];
    [defaults setObject:self.passwort.text forKey:@"passwort"];
    [defaults synchronize];
    
}

@end
