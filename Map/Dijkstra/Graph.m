//
//  Graph.m
//  Map
//
//  Created by Martin on 10/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Graph.h"
#import "PlistHelper.h"

@implementation Graph
@synthesize listNodes = _listNodes;
@synthesize listEdges = _listEdges;
@synthesize startNode = _startNode;
@synthesize endNode = _endNode;

- (id)init
{
    self = [super init];
    if (self) 
    {
        _listNodes = [[NSMutableArray alloc]init];
        _listEdges = [[NSMutableArray alloc]init];
        [self parseNodeData];
        [self parseEdgeData];
    }
    return self;
}

#pragma mark Node Methods
- (void)parseNodeData
{
    NSArray *temp = [PlistHelper getArray:@"NodeData"];
    for(NSDictionary *data in temp)
    {
        Node *node = [[Node alloc]initWithData:data];
        [_listNodes addObject:node];
    }
}

- (Node *)getNodeWithId:(NSNumber *)nodeId
{
    for(Node *node in _listNodes)
    {
        if ([node.nodeId isEqualToNumber:nodeId]) 
        {
            return  node;
        }
    }
    return nil;
}

#pragma mark Edge Methods
- (void)parseEdgeData
{
    NSArray *temp = [PlistHelper getArray:@"EdgeData"];
    for(NSDictionary *data in temp)
    {
        NSNumber *startId = [data objectForKey:@"startId"];
        NSNumber *endId = [data objectForKey:@"endId"];
        Edge *edge = [[Edge alloc]init];
        edge.start = [self getNodeWithId:startId];
        edge.end = [self getNodeWithId:endId];
        [_listEdges addObject:edge];
    }
}
@end
