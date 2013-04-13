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

@interface InboxMessagesViewController : UITableViewController {
    NSMutableArray *dict;
}

@property (nonatomic, strong)  NSMutableArray *dict;
@end
