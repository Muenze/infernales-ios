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
#import "NewsViewController.h"
#import "NSString+MD5.h"


@interface ChoiceViewController : UITableViewController {
    NSArray *choices;
}

-(IBAction)clickSettings:(id)sender;

@end
