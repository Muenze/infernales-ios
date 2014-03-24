//
//  ChoiceViewController.h
//  Infernales
//
//  Created by Guido Wehner on 12.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"
#import "ForumViewController.h"
#import "ShoutboxViewController.h"
#import "MessagesViewController.h"



@interface ChoiceViewController : UITableViewController {
    NSArray *choices;
    NSArray *subtext;
}

@property (nonatomic, strong) SettingsViewController *svc;

-(IBAction)clickSettings:(id)sender;

@end
