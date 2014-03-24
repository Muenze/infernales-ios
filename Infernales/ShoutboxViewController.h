//
//  ShoutboxViewController.h
//  Infernales
//
//  Created by Guido Wehner on 26.03.13.
//
//

#import <UIKit/UIKit.h>
#import "NSString+HtmlEntities.h"
#import "ShoutboxViewCell.h"
#import "ShoutboxDetailViewController.h"
#import "ShoutboxFormViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "NSString+phpfusiontags.h"

@interface ShoutboxViewController : UITableViewController {
}

@property (nonatomic, strong) NSArray *shouts;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) MBProgressHUD *hud;

-(void)loadShoutboxData;
-(void)reloadTableViewsWithData:(NSArray *)array;

-(IBAction)pressShout:(id)sender;
@end
