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

@interface PostFormViewController : UIViewController {
    IBOutlet UITextView *formText;
    NSInteger* threadId;
    NSInteger* forumId;
}

@property (strong, nonatomic) ACPlaceholderTextView *textView;
@property (nonatomic) NSInteger* threadId;
@property (nonatomic) NSInteger* forumId;
@property (retain, nonatomic) IBOutlet UITextView *formText;
@property (strong, nonatomic) UIButton *sendButton;

-(IBAction)pressConfirmButton:(id)sender;
@end
