//
//  ThreadFormViewController.h
//  Infernales
//
//  Created by Guido Wehner on 31.03.13.
//
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import <QuartzCore/QuartzCore.h>
#import <QuickDialog/QuickDialog.h>
#import "NSString+SBJSON.h"
#import <AFNetworking/AFNetworking.h>

@interface ThreadFormViewController : QuickDialogController <QuickDialogEntryElementDelegate> {
    NSNumber *forum_id;
}

@property (nonatomic, strong) NSNumber *forum_id;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;


-(IBAction)pressSend:(id)sender;
-(void)buildQuickDialog;
-(void)buildNavigation;

@end
