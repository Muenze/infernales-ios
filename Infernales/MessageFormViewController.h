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


@interface MessageFormViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *lblSubject;
@property (retain, nonatomic) IBOutlet UILabel *lblMessage;
@property (retain, nonatomic) IBOutlet UITextField *txtSubject;
@property (retain, nonatomic) IBOutlet UITextView *tvMessage;
@property (retain, nonatomic) NSDictionary *messageData;
@property (retain, nonatomic) IBOutlet UIScrollView *svMyScrollView;

-(IBAction)sendMessage:(id)sender;

@end
