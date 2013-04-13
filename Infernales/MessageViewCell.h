//
//  MessageViewCell.h
//  Infernales
//
//  Created by Guido Wehner on 13.04.13.
//
//

#import <UIKit/UIKit.h>

@interface MessageViewCell : UITableViewCell {
    IBOutlet UILabel *authorLabel;
    IBOutlet UILabel *subjectLabel;
}

@property (nonatomic, strong) IBOutlet UILabel *authorLabel;
@property (nonatomic, strong) IBOutlet UILabel *subjectLabel;

@end
