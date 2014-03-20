//
//  MessageFormViewController.h
//  Infernales
//
//  Created by Guido Wehner on 10.05.13.
//
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import <QuartzCore/QuartzCore.h>
#import "MessagesViewController.h"
#import <QuickDialog/QuickDialog.h>
#import <AFNetworking/AFNetworking.h>

@interface MessageFormViewController : QuickDialogController <QuickDialogEntryElementDelegate>

@property (retain, nonatomic) NSDictionary *messageData;
@property (nonatomic, retain) AFHTTPRequestOperationManager *manager;

-(IBAction)sendMessage:(id)sender;

@end
