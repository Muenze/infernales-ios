//
//  ForumViewCell.m
//  Infernales
//
//  Created by Guido Wehner on 04.03.13.
//
//

#import "ForumViewCell.h"

@implementation ForumViewCell

@synthesize lastAutorLabel, mainLabel, neuIndicator;

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

-(void)dealloc {
    
    [lastAutorLabel release];
    [mainLabel release];
    [neuIndicator release];
    
    [super dealloc];
}

@end
