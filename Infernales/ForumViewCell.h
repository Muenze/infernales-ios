//
//  ForumViewCell.h
//  Infernales
//
//  Created by Guido Wehner on 04.03.13.
//
//

#import <UIKit/UIKit.h>

@interface ForumViewCell : UITableViewCell {
    IBOutlet UILabel *mainLabel;
    IBOutlet UILabel *lastAutorLabel;
}

@property (nonatomic, strong) IBOutlet UILabel *mainLabel;
@property (nonatomic, strong) IBOutlet UILabel *lastAutorLabel;

@end
