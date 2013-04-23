//
//  MessageDetailViewController.h
//  Infernales
//
//  Created by Guido Wehner on 13.04.13.
//
//

#import <UIKit/UIKit.h>

@interface MessageDetailViewController : UIViewController {
    IBOutlet UILabel *authorLabel;
    IBOutlet UITextView *messageTextView;
    IBOutlet UILabel *subjectLabel;
    NSDictionary *message;
}

@property (nonatomic, strong) IBOutlet UILabel *authorLabel;
@property (nonatomic, strong) IBOutlet UITextView *messageTextView;
@property (nonatomic, strong) IBOutlet UILabel *subjectLabel;
@property (nonatomic, strong) NSDictionary *message;

-(IBAction)replyToMessage:(id)sender;

@end
