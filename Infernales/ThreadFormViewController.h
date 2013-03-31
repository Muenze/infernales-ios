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
    IBOutlet UITextView *message;
}

@property (nonatomic, retain) IBOutlet UITextField *subject;
@property (nonatomic, retain) IBOutlet UITextView *message;

@end
