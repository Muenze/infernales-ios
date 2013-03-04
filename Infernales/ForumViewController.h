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

@interface ForumViewController : UITableViewController {
    NSDictionary *forumData;
    NSArray *forumCats;
}

@property (nonatomic, retain) NSDictionary *forumData;
@property (nonatomic, retain) NSArray *forumcats;

-(NSDictionary *)loadForumData;
-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath;


@end
