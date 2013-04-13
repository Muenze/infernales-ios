//
//  MessageViewCell.m
//  Infernales
//
//  Created by Guido Wehner on 13.04.13.
//
//

#import "MessageViewCell.h"

@implementation MessageViewCell

@synthesize authorLabel, subjectLabel;

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

-(void) dealloc {
    [authorLabel release];
    [subjectLabel release];
    [super dealloc];
}

@end
