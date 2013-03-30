//
//  PostViewController.h
//  Infernales
//
//  Created by Guido Wehner on 05.03.13.
//
//

#import <UIKit/UIKit.h>
#import "NSString+SBJSON.h"
#import "NSString+MD5.h"
#import "NSString+HtmlEntities.h"
#import "PostViewCell.h"
#import "PostdetailViewController.h"
#import "PostFormViewController.h"

@interface PostViewController : UITableViewController {
    NSInteger* threadId;
    NSInteger* forumId;
    NSString* threadName;
    NSDictionary* postData;
    bool locked;
}
@property (nonatomic) NSInteger* threadId;
@property (nonatomic) NSInteger* forumId;
@property (nonatomic, strong) NSDictionary *postData;
@property (nonatomic, strong) NSString *threadName;
@property bool locked;

-(NSDictionary *)loadPostData;
-(id)initWithForumId:(NSInteger *)forumid withThreadId:(NSInteger *)threadid andThreadName:(NSString *)threadName;
-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath;
-(CGSize)getSizeForString:(NSString *)thestring;
-(IBAction)postInForum:(id)sender;


@end
