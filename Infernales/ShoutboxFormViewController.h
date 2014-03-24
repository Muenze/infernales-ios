//
//  ShoutboxFormViewController.h
//  Infernales
//
//  Created by Guido Wehner on 31.03.13.
//
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import <QuartzCore/QuartzCore.h>
#import "ShoutboxViewController.h"
#import <QuickDialog/QuickDialog.h>
#import <AFNetworking/AFNetworking.h>

@interface ShoutboxFormViewController : QuickDialogController <QuickDialogEntryElementDelegate> {
    
}

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

-(IBAction)pressSend:(id)sender;
-(void)redirectWithResponse:(NSDictionary *)response;

@end
