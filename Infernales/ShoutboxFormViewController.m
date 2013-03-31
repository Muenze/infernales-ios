//
//  ShoutboxFormViewController.m
//  Infernales
//
//  Created by Guido Wehner on 31.03.13.
//
//

#import "ShoutboxFormViewController.h"

@interface ShoutboxFormViewController ()

@end

@implementation ShoutboxFormViewController

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
    
    ACPlaceholderTextView *tv = [[ACPlaceholderTextView alloc] initWithFrame:CGRectMake(20.0f, 85.0f, 275.0f, 115.0f)];
    tv.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //        tv.delegate = self;
    tv.backgroundColor = [UIColor colorWithWhite:245/255.0f alpha:1];
    tv.scrollIndicatorInsets = UIEdgeInsetsMake(13, 0, 8, 6);
    tv.scrollsToTop = NO;
    tv.font = [UIFont systemFontOfSize:14];
    tv.autocorrectionType = UITextAutocorrectionTypeNo;
    tv.layer.borderColor = [[UIColor grayColor] CGColor];
    tv.layer.borderWidth = 2;
    [self.view addSubview:tv];
    message = tv;
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(pressSend:)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
