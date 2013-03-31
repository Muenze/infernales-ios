//
//  ShoutboxFormViewController.h
//  Infernales
//
//  Created by Guido Wehner on 31.03.13.
//
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import <QuartzCore/QuartzCore.h>
#import "ACPlaceholderTextView.h"

@interface ShoutboxFormViewController : UIViewController {
    IBOutlet ACPlaceholderTextView *message;
}

@property (nonatomic, retain) IBOutlet ACPlaceholderTextView *message;

-(IBAction)pressSend:(id)sender;

@end
