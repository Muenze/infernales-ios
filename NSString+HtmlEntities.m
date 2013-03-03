//
//  NSString+HtmlEntities.m
//  Infernales
//
//  Created by Guido Wehner on 03.03.13.
//
//

#import "NSString+HtmlEntities.h"

@implementation NSString (HtmlEntities)

-(NSString *)decodeHtmlEntities {
    NSMutableString *final = [NSMutableString stringWithString:self];
    [final replaceOccurrencesOfString:@"&uuml;" withString:@"ü" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&amp;#39;" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&amp;" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    return (NSString *)final;
}

@end
