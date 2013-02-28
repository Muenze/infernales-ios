//
//  SettingsViewController.h
//  Infernales
//
//  Created by Guido Wehner on 12.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController {
    UILabel *usernameLabel;
    UITextField *username;
    UILabel *passwortLabel;
    UITextField *passwort;
}

@property (nonatomic, retain) IBOutlet UILabel *usernameLabel;
@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UILabel *passwortLabel;
@property (nonatomic, retain) IBOutlet UITextField *passwort;


-(IBAction)saveSettings:(id)sender;

@end
