//
//  PostViewController.h
//  Infernales
//
//  Created by Guido Wehner on 05.03.13.
//
//

#import <UIKit/UIKit.h>
#import "NSString+HtmlEntities.h"
#import "PostViewCell.h"
#import "PostdetailViewController.h"
#import "PostFormViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface PostViewController : UITableViewController {
    NSNumber* threadId;
    NSNumber* forumId;
    NSString* threadName;
    NSArray* postData;
    bool locked;
}
@property (nonatomic, strong) NSNumber* threadId;
@property (nonatomic, strong) NSNumber* forumId;
@property (nonatomic, strong) NSArray *postData;
@property (nonatomic, strong) NSString *threadName;
@property (nonatomic, retain) MBProgressHUD *hud;
@property bool locked;

-(void)loadPostData;
-(void)reloadTableWithData:(NSArray *)data;
-(id)initWithForumId:(NSNumber *)forumid withThreadId:(NSNumber *)threadid andThreadName:(NSString *)threadName;
-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath;
-(CGSize)getSizeForString:(NSString *)thestring;
-(IBAction)postInForum:(id)sender;


@end
