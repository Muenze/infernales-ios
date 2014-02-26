//
//  SettingsViewController.h
//  Infernales
//
//  Created by Guido Wehner on 12.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickDialog/QuickDialog.h>

// @interface SettingsViewController : UIViewController {
@interface SettingsViewController : QuickDialogController {
}


-(IBAction)saveSettings:(id)sender;
-(void)buildNavigationButton;
-(void)buildQuickDialog;

@end
