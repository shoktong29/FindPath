//
//  Egde.m
//  TPS2
//
//  Created by martin magalong on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Edge.h"
#import "Node.h"

@implementation Edge
@synthesize start = _start;
@synthesize end = _end;
@synthesize cost = _cost;

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) 
    {
        
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ : StartId=%@ EndId=%@ cost=%@",[super description],_start.nodeId,_end.nodeId,_cost];
}

@end
