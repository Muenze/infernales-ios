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
    NSRegularExpression *youtubeExpr = [NSRegularExpression
                                        regularExpressionWithPattern:@"\\[youtube\\](.*?)\\[/youtube\\]"
                                        options:NSRegularExpressionCaseInsensitive
                                        error:&error];
    
    temp = [youtubeExpr stringByReplacingMatchesInString:temp
                                                 options:0
                                                   range:NSMakeRange(0,[temp length])
                                            withTemplate:@"http://youtube.de/$1"];
    
    NSRegularExpression *urlExpr = [NSRegularExpression
                                        regularExpressionWithPattern:@"\\[url\\](.*?)\\[/url\\]"
                                        options:NSRegularExpressionCaseInsensitive
                                        error:&error];
    
    temp = [urlExpr stringByReplacingMatchesInString:temp
                                                 options:0
                                                   range:NSMakeRange(0,[temp length])
                                            withTemplate:@"$1"];
    
    
    
    
    
    
    
    return (NSString *)temp;
}

@end
