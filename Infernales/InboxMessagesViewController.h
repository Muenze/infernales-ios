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

@interface InboxMessagesViewController : UITableViewController {
    NSArray *dict;
}

@property (nonatomic, strong)  NSArray *dict;
@end
