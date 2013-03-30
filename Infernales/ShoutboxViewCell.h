//
//  ShoutboxViewCell.h
//  Infernales
//
//  Created by Guido Wehner on 30.03.13.
//
//

#import <UIKit/UIKit.h>

@interface ShoutboxViewCell : UITableViewCell {
    IBOutlet UILabel *authorLabel;
    IBOutlet UILabel *mainLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *authorLabel;
@property (nonatomic, retain) IBOutlet UILabel *mainLabel;

@end
