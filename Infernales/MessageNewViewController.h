//
//  MessageNewViewController.h
//  Infernales
//
//  Created by Guido Wehner on 28.04.13.
//
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <AFNetworking/AFNetworking.h>
#import <QuickDialog/QuickDialog.h>

@interface MessageNewViewController : QuickDialogController

@property (retain, nonatomic) NSString *recieverId;
@property (strong, nonatomic) NSArray *valueArray;
@property (strong, nonatomic) NSArray *titleArray;
@property (nonatomic, retain) AFHTTPRequestOperationManager *manager;
@property (nonatomic, retain) NSDictionary *userCollection;
@property (nonatomic, retain) NSArray *users;
@property (nonatomic, retain) MBProgressHUD *hud;

-(IBAction)sendMessage:(id)sender;


@end
