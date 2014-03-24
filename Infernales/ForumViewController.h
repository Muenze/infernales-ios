//
//  ForumViewController.h
//  Infernales
//
//  Created by machi on 23.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+HtmlEntities.h"
#import "ForumViewCell.h"
#import "AppDelegate.h"
#import <AFNetworking/AFNetworking.h>
#import "MBProgressHUD.h"

@interface ForumViewController : UITableViewController {
    NSArray *forumData;
}

@property (nonatomic, retain) NSArray *forumData;
@property (nonatomic, retain) AFHTTPRequestOperationManager *manager;

-(void)loadForumData;
-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath;
-(void)reloadTableWithData:(NSArray *)data;


@end
