//
//  PostFormViewController.h
//  Infernales
//
//  Created by Guido Wehner on 21.03.13.
//
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "ACPlaceholderTextView.h"
#import "JSON.h"
#import "AppDelegate.h"
#import "PostViewController.h"

@interface PostFormViewController : UIViewController {
    IBOutlet UITextView *formText;
    NSInteger* threadId;
    NSInteger* forumId;
    ACPlaceholderTextView* textView;
    NSString *formString;
    bool editMode;
    NSDictionary *postValues;
}

@property (strong, nonatomic) ACPlaceholderTextView *textView;
@property (strong, nonatomic) NSString *formString;
@property (nonatomic) NSInteger* threadId;
@property (nonatomic) NSInteger* forumId;
@property (retain, nonatomic) IBOutlet UITextView *formText;
@property (strong, nonatomic) UIButton *sendButton;
@property (nonatomic) bool editMode;
@property (nonatomic, strong) NSDictionary *postValues;


-(void)pressConfirmButton;
@end
