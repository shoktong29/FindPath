//
//  Graph.m
//  Map
//
//  Created by Martin on 10/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Graph.h"
#import "PlistHelper.h"
#import <QuartzCore/QuartzCore.h>

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

- (void)renderNodes:(UIView *)renderLayer
{
    for(Node *node in _listNodes)
    {
        CGPoint coor = CGPointFromString(node.coor);
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor redColor];
        view.frame = CGRectMake(coor.x, coor.y, 20, 20);
        [renderLayer addSubview:view];
        
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.frame = CGRectMake(0, 0, 20, 20);
        label.center = coor;
        label.text = node.name;
        [renderLayer addSubview:label];
    }
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

- (void)renderEdges:(UIView *)renderLayer
{     
    CAShapeLayer *lineShape = [CAShapeLayer layer];;
    CGMutablePathRef linePath = CGPathCreateMutable();
    
    for(Edge *edge in _listEdges)
    {
        CGPoint coorStart = CGPointFromString(edge.start.coor);
        CGPoint coorEnd = CGPointFromString(edge.end.coor);
        
        lineShape.lineWidth = 4.0f;
        lineShape.lineCap = kCALineCapRound;;
        lineShape.strokeColor = [[UIColor blackColor] CGColor];
                                
        CGPathMoveToPoint(linePath, NULL, coorStart.x, coorStart.y);
        CGPathAddLineToPoint(linePath, NULL, coorEnd.x, coorEnd.y);
        
        lineShape.path = linePath;
    }
    CGPathRelease(linePath);
    [renderLayer.layer addSublayer:lineShape];;
}



@end
