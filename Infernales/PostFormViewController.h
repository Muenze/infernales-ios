//
//  PostFormViewController.h
//  Infernales
//
//  Created by Guido Wehner on 21.03.13.
//
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "AppDelegate.h"
#import "PostViewController.h"
#import <QuickDialog/QuickDialog.h>

@interface PostFormViewController : QuickDialogController {
    NSInteger* threadId;
    NSInteger* forumId;
    NSString *formString;
    bool editMode;
    NSDictionary *postValues;
}

@property (strong, nonatomic) NSString *formString;
@property (nonatomic) NSInteger* threadId;
@property (nonatomic) NSInteger* forumId;
@property (strong, nonatomic) UIButton *sendButton;
@property (nonatomic) bool editMode;
@property (nonatomic, strong) NSDictionary *postValues;


-(void)pressConfirmButton;
-(void)buildNavigation;
-(void)buildDialog;
@end
