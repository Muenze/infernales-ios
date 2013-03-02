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

@interface ThreadViewController : UITableViewController {
    NSDictionary *threadData;
    NSInteger *forumId;
}

@property (nonatomic, retain) NSDictionary *threadData;
@property (nonatomic) NSInteger *forumId;

-(NSDictionary *)loadThreadData;
-(id)initWithForumId:(NSInteger *)fd;
-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath;

@end