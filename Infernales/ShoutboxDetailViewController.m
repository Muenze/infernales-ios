//
//  ShoutboxDetailViewController.m
//  Infernales
//
//  Created by Guido Wehner on 31.03.13.
//
//

#import "ShoutboxDetailViewController.h"

@interface ShoutboxDetailViewController ()

@end

@implementation ShoutboxDetailViewController

@synthesize shoutView, shoutMessage, shout, label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"shout!" style:UIBarButtonItemStylePlain target:self action:@selector(pressShout:)];
    self.navigationItem.rightBarButtonItem = button;
    
    
    NSDate *theDate = [NSDate dateWithTimeIntervalSince1970:[shout[@"datestamp"] doubleValue]];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSString *date = [format stringFromDate:theDate];
    
    NSString *autor = [NSString stringWithFormat:@"%@ am %@", shout[@"user"], date];
    
    
    label.text = autor;
    
    NSString *text = [shout[@"message"] decodePhpFusionTags];
    shoutView.text = text;
    
    
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)pressShout:(id)sender {
    ShoutboxFormViewController *sfc = [[ShoutboxFormViewController alloc] init];
    [self.navigationController pushViewController:sfc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
