//
//  ThreadViewCell.m
//  Infernales
//
//  Created by Guido Wehner on 03.03.13.
//
//

#import "ThreadViewCell.h"

@implementation ThreadViewCell

@synthesize myImageView, threadNameLabel, threadShortDescription, stickyIndicator;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
