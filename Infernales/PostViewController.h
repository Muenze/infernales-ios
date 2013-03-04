//
//  PostViewController.h
//  Infernales
//
//  Created by machi on 21.10.12.
//
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "NSString+MD5.h"


@interface PostViewController : UITableViewController {
    NSDictionary *postData;
    NSInteger *threadId;
}

@property (nonatomic, retain) NSDictionary *postData;
@property (nonatomic) NSInteger *threadId;

-(NSDictionary *)loadPostData;
-(id)initWithThreadId:(NSInteger *)fd;
-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath;

@end
