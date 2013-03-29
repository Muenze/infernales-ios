//
//  PostdetailViewController.h
//  Infernales
//
//  Created by Guido Wehner on 13.03.13.
//
//

#import <UIKit/UIKit.h>
#import "NSString+HtmlEntities.h"
#import "PostFormViewController.h"

@interface PostdetailViewController : UIViewController {
    
    IBOutlet UITextView *myTextView;
    NSDictionary* postValues;

}
@property (retain, nonatomic) IBOutlet UITextView *myTextView;
@property (nonatomic, strong) NSDictionary* postValues;

-(void)setPostValues:(NSDictionary *)paramPostValues;
-(IBAction)postInForum:(id)sender;


@end
