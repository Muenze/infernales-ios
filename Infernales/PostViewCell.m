//
//  PostViewCell.m
//  Infernales
//
//  Created by Guido Wehner on 08.03.13.
//
//

#import "PostViewCell.h"

@implementation PostViewCell

@synthesize mainLabel, autorLabel;

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
