//
//  MessageFormViewController.h
//  Infernales
//
//  Created by Guido Wehner on 23.04.13.
//
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "ACPlaceholderTextView.h"
#import "JSON.h"
#import "AppDelegate.h"
#import "InboxMessagesViewController.h"

@interface MessageFormViewController : UIViewController {
    IBOutlet UITextView *formText;
    ACPlaceholderTextView* textView;
    bool editMode;
    NSDictionary *messageData;
}

@property (nonatomic, strong) IBOutlet UITextView *formText;
@property (nonatomic, strong) ACPlaceholderTextView *textView;
@property (nonatomic, strong) NSDictionary *messageData;
@property (strong, nonatomic) UIButton *sendButton;


@end
