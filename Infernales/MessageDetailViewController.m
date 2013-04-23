//
//  MessageDetailViewController.m
//  Infernales
//
//  Created by Guido Wehner on 13.04.13.
//
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController

@synthesize authorLabel, messageTextView, message, subjectLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    messageTextView.text = [message objectForKey:@"message_message"];
    
    subjectLabel.text = [message objectForKey:@"message_subject"];
    
    NSString *autor = [message objectForKey:@"user_name"];
    
    NSDate *theDate = [NSDate dateWithTimeIntervalSince1970:[[message objectForKey:@"message_datestamp"] doubleValue]];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSString *date = [format stringFromDate:theDate];
    [format release];
    
    autor = [[autor stringByAppendingString:@" am "] stringByAppendingString:date];
    authorLabel.text = autor;
    
    UIBarButtonItem *postButton = [[UIBarButtonItem alloc] initWithTitle:@"antworten" style:UIBarButtonItemStylePlain target:self action:@selector(replyToMessage:)];
    self.navigationItem.rightBarButtonItem = postButton;
    [postButton release];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)replyToMessage:(id)sender {
        
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [authorLabel release];
    [messageTextView release];
    [message release];
    
    [super dealloc];
}

@end
