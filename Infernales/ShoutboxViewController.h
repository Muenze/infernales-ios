//
//  ShoutboxViewController.h
//  Infernales
//
//  Created by Guido Wehner on 26.03.13.
//
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "OrderedDictionary.h"
#import "NSString+HtmlEntities.h"
#import "ShoutboxViewCell.h"

@interface ShoutboxViewController : UITableViewController {
    OrderedDictionary *shouts;
}

@property (nonatomic, retain) OrderedDictionary* shouts;
@end
