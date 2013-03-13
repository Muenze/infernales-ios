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
#import "MSTextView.h"
#import "PostdetailViewController.h"

@interface PostViewController : UITableViewController {
    NSInteger* threadId;
    NSString* threadName;
    NSDictionary* postData;
}
@property (nonatomic) NSInteger* threadId;
@property (nonatomic, strong) NSDictionary *postData;
@property (nonatomic, strong) NSString *threadName;

-(NSDictionary *)loadPostData;
-(id)initWithThreadId:(NSInteger *)threadid andThreadName:(NSString *)threadName;
-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath;


@end
