//
//  OrderedDictionary.h
//  Infernales
//
//  Created by Guido Wehner on 04.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderedDictionary : NSMutableDictionary {
    NSMutableDictionary *dictionary;
    NSMutableArray *array;
}

@property (nonatomic, retain) NSMutableDictionary *dictionary;
@property (nonatomic, retain) NSMutableArray *array;

@end
