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
    [final replaceOccurrencesOfString:@"&amp;" withString:@"&" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&amp;" withString:@"&" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&reg;" withString:@"®" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&quot;" withString:@"\"" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&aacute;" withString:@"á" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&gt;" withString:@">" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&lt;" withString:@"<" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&uuml;" withString:@"ü" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&Uuml;" withString:@"Ü" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&auml;" withString:@"ä" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&Auml;" withString:@"Ä" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&ouml;" withString:@"ö" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&Ouml;" withString:@"Ö" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&amp;amp;" withString:@"&" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&amp;#39;" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&szlig;" withString:@"ß" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    [final replaceOccurrencesOfString:@"&ETH;" withString:@"Ð" options:NSLiteralSearch range:NSMakeRange(0, [final length])];
    
    return (NSString *)final;
}

@end
