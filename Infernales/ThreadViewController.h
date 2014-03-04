//
//  ThreadViewController.h
//  Infernales
//
//  Created by Guido Wehner on 15.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "NSString+MD5.h"
#import "ThreadViewCell.h"
#import "PostViewController.h"
#import "NSString+HtmlEntities.h"
#import "ThreadFormViewController.h"

@interface ThreadViewController : UITableViewController {
    NSArray *threadData;
    NSNumber *forumId;
    NSString *threadName;
}

@property (nonatomic, retain) NSArray *threadData;
@property (nonatomic, retain) NSNumber* forumId;
@property (nonatomic, strong) NSString* threadName;

-(void)loadThreadData;
-(id)initWithForumId:(NSNumber *)fd;
-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath;
-(void)setNameForThread:(NSString *)thread_name;
-(IBAction)postNewThread:(id)sender;
-(void)reloadTableWithData:(NSArray *)data;

@end
