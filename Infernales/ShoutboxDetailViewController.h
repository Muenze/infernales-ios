//
//  ShoutboxDetailViewController.h
//  Infernales
//
//  Created by Guido Wehner on 31.03.13.
//
//

#import <UIKit/UIKit.h>
#import "NSString+HtmlEntities.h"
#import "ShoutboxFormViewController.h"

@interface ShoutboxDetailViewController : UIViewController {
    IBOutlet UITextView *shoutView;
    NSString *shoutMessage;
    NSDictionary *shout;
    IBOutlet UILabel *label;
    
}

@property (nonatomic, retain) IBOutlet UITextView *shoutView;
@property (nonatomic, retain) NSString *shoutMessage;
@property (nonatomic, retain) NSDictionary *shout;
@property (nonatomic, retain) UILabel *label;

-(IBAction)pressShout:(id)sender;

@end
