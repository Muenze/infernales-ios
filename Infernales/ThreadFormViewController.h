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
#import "ACPlaceholderTextView.h"

@interface ThreadFormViewController : UIViewController {
    IBOutlet UITextField *subject;
    IBOutlet ACPlaceholderTextView *message;
    NSInteger *forum_id;
}

@property (nonatomic, retain) IBOutlet UITextField *subject;
@property (nonatomic, retain) IBOutlet ACPlaceholderTextView *message;
@property (nonatomic) NSInteger *forum_id;

-(IBAction)pressSend:(id)sender;

@end
