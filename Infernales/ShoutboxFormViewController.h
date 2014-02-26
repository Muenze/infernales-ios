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
#import "ShoutboxViewController.h"
#import <QuickDialog/QuickDialog.h>

@interface ShoutboxFormViewController : QuickDialogController {
}

-(IBAction)pressSend:(id)sender;

@end
