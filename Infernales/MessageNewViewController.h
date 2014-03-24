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

@interface MessageNewViewController : QuickDialogController <QuickDialogEntryElementDelegate>

@property (strong, nonatomic) NSString *recieverId;
@property (strong, nonatomic) NSArray *valueArray;
@property (strong, nonatomic) NSArray *titleArray;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSDictionary *userCollection;
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) MBProgressHUD *hud;

-(IBAction)sendMessage:(id)sender;


@end
