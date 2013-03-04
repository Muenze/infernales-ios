//
//  ThreadViewCell.h
//  Infernales
//
//  Created by Guido Wehner on 03.03.13.
//
//

#import <UIKit/UIKit.h>

@interface ThreadViewCell : UITableViewCell {
    IBOutlet UIImageView *newImageView;
    IBOutlet UILabel *threadNameLabel;
    IBOutlet UILabel *threadShortDescription;
    IBOutlet UIImageView *stickyIndicator;
    
}

@property (nonatomic, strong) IBOutlet UIImageView *newImageView;
@property (nonatomic, strong) IBOutlet UILabel *threadNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *threadShortDescription;
@property (nonatomic, strong) IBOutlet UIImageView *stickyIndicator;

@end
