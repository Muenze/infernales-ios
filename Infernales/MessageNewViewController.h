//
//  MessageNewViewController.h
//  Infernales
//
//  Created by Guido Wehner on 28.04.13.
//
//

#import <UIKit/UIKit.h>
#import "UIDropDownMenu.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"

@interface MessageNewViewController : UIViewController <UIScrollViewDelegate, UIDropDownMenuDelegate> {
    UIDropDownMenu *recieverMenu;
}
@property (retain, nonatomic) IBOutlet UIScrollView *svMyScrollView;
@property (retain, nonatomic) IBOutlet UITextField *txtSubject;
@property (retain, nonatomic) IBOutlet UITextView *txtMessage;
@property (retain, nonatomic) IBOutlet UITextField *txtReciever;
@property (retain, nonatomic) NSString *recieverId;
@property (strong, nonatomic) UIDropDownMenu *recieverMenu;
@property (strong, nonatomic) NSArray *valueArray;
@property (strong, nonatomic) NSArray *titleArray;

-(IBAction)sendMessage:(id)sender;


@end
