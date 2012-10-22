//
//  Node.m
//  TPS2
//
//  Created by martin magalong on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Node.h"

@implementation Node
@synthesize cost = _cost;
@synthesize name = _name;
@synthesize nodeId = _nodeId;
@synthesize coor = _coor;
@synthesize parentNode = _parentNode;

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if(self)
    {
        _nodeId = [NSNumber numberWithFloat:[[data objectForKey:@"id"]floatValue]];;
        _name = [data objectForKey:@"name"];
        _cost = [NSNumber numberWithFloat:MAXFLOAT];
        _coor = [data objectForKey:@"coor"];;
        _parentNode = nil;
    }
    return self;
}

- (void)setCost:(NSNumber *)cost
{
    _cost = cost;
}

- (void)setParentNode:(Node *)parentNode
{
    _parentNode = parentNode;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ : nodeId=%@ name=%@ cost=%@",[super description],_nodeId,_name,_cost];
}
@end
