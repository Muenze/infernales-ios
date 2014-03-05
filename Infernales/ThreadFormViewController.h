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
#import <QuickDialog/QuickDialog.h>
#import "NSString+SBJSON.h"

@interface ThreadFormViewController : QuickDialogController {
    NSNumber *forum_id;
}

@property (nonatomic, strong) NSNumber *forum_id;

-(IBAction)pressSend:(id)sender;
-(void)buildQuickDialog;
-(void)buildNavigation;

@end
