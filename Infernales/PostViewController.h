//
//  PostViewController.h
//  Infernales
//
//  Created by Guido Wehner on 05.03.13.
//
//

#import <UIKit/UIKit.h>

@interface PostViewController : UITableViewController {
    NSInteger *threadId;
    NSDictionary *postData;
}

@property (nonatomic) NSInteger *threadId;
@property (nonatomic, strong) NSDictionary *postData;

-(NSDictionary *)loadPostData;
-(id)initWithForumId:(NSInteger *)fd;
-(NSDictionary *)getDictionaryAtIndexPath:(NSIndexPath *)indexPath;


@end
