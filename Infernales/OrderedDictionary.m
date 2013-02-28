//
//  OrderedDictionary.m
//  Infernales
//
//  Created by Guido Wehner on 04.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderedDictionary.h"


@implementation OrderedDictionary 

@synthesize array, dictionary;

-(id)initWithCapacity:(NSUInteger)numItems {
    self = [super init];
    if(self != nil) {
        dictionary = [[NSMutableDictionary alloc] initWithCapacity:numItems];
        array = [[NSMutableArray alloc] initWithCapacity:numItems];
    }
    return self;
}

-(void)dealloc {
    [dictionary release];
    [array release];
    [super dealloc];
}

- (void)setObject:(id)anObject forKey:(id)aKey
{
    if (![dictionary objectForKey:aKey])
    {
        [array addObject:aKey];
    }
    [dictionary setObject:anObject forKey:aKey];
}

- (void)removeObjectForKey:(id)aKey
{
    [dictionary removeObjectForKey:aKey];
    [array removeObject:aKey];
}

- (NSUInteger)count
{
    return [dictionary count];
}

- (id)objectForKey:(id)aKey
{
    return [dictionary objectForKey:aKey];
}

- (NSEnumerator *)keyEnumerator
{
    return [array objectEnumerator];
}

@end
