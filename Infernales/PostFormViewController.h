//
//  PostFormViewController.h
//  Infernales
//
//  Created by Guido Wehner on 21.03.13.
//
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "AppDelegate.h"
#import "PostViewController.h"
#import <QuickDialog/QuickDialog.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface PostFormViewController : QuickDialogController <QuickDialogEntryElementDelegate> {
    NSNumber *threadId;
    NSNumber *forumId;
    NSString *formString;
    bool editMode;
    NSDictionary *postValues;
}

@property (strong, nonatomic) NSString *formString;
@property (nonatomic, strong) NSNumber* threadId;
@property (nonatomic, strong) NSNumber* forumId;
@property (strong, nonatomic) UIButton *sendButton;
@property (nonatomic) bool editMode;
@property (nonatomic, strong) NSDictionary *postValues;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) MBProgressHUD *hud;


-(void)pressConfirmButton;
-(void)buildNavigation;
-(void)buildDialog;
-(void)requestFinished:(NSDictionary *)response;
-(void)requestHasError;
@end
