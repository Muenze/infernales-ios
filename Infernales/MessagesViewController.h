//
//  InboxMessagesViewController.h
//  Infernales
//
//  Created by Guido Wehner on 12.04.13.
//
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "MessageViewCell.h"
#import "MessageDetailViewController.h"
#import "MessageNewViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface MessagesViewController : UIViewController {
}

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong)  NSMutableArray *dict;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString *folder;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *btnInbox;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *btnOutbox;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *btnTrash;
@property (nonatomic, retain) MBProgressHUD *hud;


- (IBAction)pressInbox:(id)sender;
- (IBAction)pressOutbox:(id)sender;
- (IBAction)pressTrash:(id)sender;
- (void)reloadTableWithData:(NSArray *)data;
@end
