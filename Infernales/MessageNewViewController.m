//
//  MessageNewViewController.m
//  Infernales
//
//  Created by Guido Wehner on 28.04.13.
//
//

#import "MessageNewViewController.h"

@interface MessageNewViewController ()

@end

@implementation MessageNewViewController

@synthesize svMyScrollView = _svMyScrollView;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_svMyScrollView release];
    [_txtSubject release];
    [_txtMessage release];
    [_pickerReciever release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setSvMyScrollView:nil];
    [self setTxtSubject:nil];
    [self setTxtMessage:nil];
    [self setPickerReciever:nil];
    [super viewDidUnload];
}

@end
