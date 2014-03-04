//
//  ForumViewController.h
//  Infernales
//
//  Created by machi on 23.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "NSString+MD5.h"
#import "NSString+HtmlEntities.h"
#import "ForumViewCell.h"
#import "AppDelegate.h"
#import <AFNetworking/AFNetworking.h>
#import "MBProgressHUD.h"

@interface ForumViewController : UITableViewController {
    NSArray *forumData;
}

@property (nonatomic, retain) NSArray *forumData;

-(void)loadForumData;
-(NSDictionary *)requestForumData;
-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath;
-(void)reloadTableWithData:(NSArray *)data;


@end
