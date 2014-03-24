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
#import "NSString+phpfusiontags.h"

@interface ShoutboxDetailViewController : UIViewController {
    IBOutlet UITextView *shoutView;
    NSString *shoutMessage;
    NSDictionary *shout;
    IBOutlet UILabel *label;
    
}

@property (nonatomic, strong) IBOutlet UITextView *shoutView;
@property (nonatomic, strong) NSString *shoutMessage;
@property (nonatomic, strong) NSDictionary *shout;
@property (nonatomic, strong) UILabel *label;

-(IBAction)pressShout:(id)sender;

@end
