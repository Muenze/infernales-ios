//
//  PostdetailViewController.m
//  Infernales
//
//  Created by Guido Wehner on 13.03.13.
//
//

#import "PostdetailViewController.h"

@interface PostdetailViewController ()

@end

@implementation PostdetailViewController

@synthesize myTextView, postValues;

-(void)setPostValues:(NSDictionary *)paramPostValues {
    postValues = paramPostValues;
}

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
    myTextView.text = [[postValues valueForKey:@"post_message"] decodeHtmlEntities];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [myTextView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyTextView:nil];
    [myTextView release];
    [super viewDidUnload];
}
@end
