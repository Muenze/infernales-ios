//
//  NSString+phpfusiontags.m
//  Infernales
//
//  Created by Guido Wehner on 05.03.14.
//
//

#import "NSString+phpfusiontags.h"

@implementation NSString (phpfusiontags)

-(NSString *)decodePhpFusionTags {
    NSString *temp = [self copy];
    
    NSError *error;
    NSRegularExpression *expr = [NSRegularExpression
                                 regularExpressionWithPattern:@"\\[youtube\\](.*?)\\[/youtube\\]"
                                 options:NSRegularExpressionCaseInsensitive
                                 error:&error];
    
    temp = [expr stringByReplacingMatchesInString:temp
                                                         options:0
                                                           range:NSMakeRange(0,[temp length])
                                                    withTemplate:@"http://youtube.de/$1"];
    
    
    
    return (NSString *)temp;
}

@end
