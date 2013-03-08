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

@interface PostViewController : UITableViewController {
    NSInteger *threadId;
    NSDictionary *postData;
}

@property (nonatomic) NSInteger *threadId;
@property (nonatomic, strong) NSDictionary *postData;

-(NSDictionary *)loadPostData;
-(id)initWithThreadId:(NSInteger *)threadid;
-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath;


@end
