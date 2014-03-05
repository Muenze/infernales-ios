//
//  PostViewController.h
//  Infernales
//
//  Created by Guido Wehner on 05.03.13.
//
//

#import <UIKit/UIKit.h>
#import "NSString+SBJSON.h"
#import "NSString+HtmlEntities.h"
#import "PostViewCell.h"
#import "PostdetailViewController.h"
#import "PostFormViewController.h"

@interface PostViewController : UITableViewController {
    NSNumber* threadId;
    NSNumber* forumId;
    NSString* threadName;
    NSDictionary* postData;
    bool locked;
}
@property (nonatomic, strong) NSNumber* threadId;
@property (nonatomic, strong) NSNumber* forumId;
@property (nonatomic, strong) NSDictionary *postData;
@property (nonatomic, strong) NSString *threadName;
@property bool locked;

-(NSDictionary *)loadPostData;
-(id)initWithForumId:(NSNumber *)forumid withThreadId:(NSNumber *)threadid andThreadName:(NSString *)threadName;
-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath;
-(CGSize)getSizeForString:(NSString *)thestring;
-(IBAction)postInForum:(id)sender;


@end
