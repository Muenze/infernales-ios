//
//  PostViewCell.h
//  Infernales
//
//  Created by Guido Wehner on 08.03.13.
//
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"

@interface PostViewCell : UITableViewCell {
    IBOutlet UILabel *autorLabel;
    IBOutlet UITextView *mainLabel;
    IBOutlet TTStyledTextLabel *styledLabel;

}

@property (nonatomic, strong) IBOutlet UILabel *autorLabel;
@property (nonatomic, strong) IBOutlet UITextView *mainLabel;
@property (nonatomic, strong) IBOutlet TTStyledTextLabel *styledLabel;

@end
