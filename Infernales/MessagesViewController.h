//
//  InboxMessagesViewController.h
//  Infernales
//
//  Created by Guido Wehner on 12.04.13.
//
//

#import <UIKit/UIKit.h>
#import "OrderedDictionary.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "MessageViewCell.h"
#import "MessageDetailViewController.h"
#import "MessageNewViewController.h"

@interface MessagesViewController : UIViewController {
    NSMutableArray *dict;
}

@property (nonatomic, strong)  NSMutableArray *dict;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString *folder;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnInbox;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnOutbox;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnTrash;


- (IBAction)pressInbox:(id)sender;
- (IBAction)pressOutbox:(id)sender;
- (IBAction)pressTrash:(id)sender;
@end
