//
//  Dijktra.m
//  TPS
//
//  Created by martin magalong on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Dijktra.h"

@implementation Dijktra

+ (NSNumber *)findPathInGraph:(Graph *)graph
{
    //1. Set the cost of origin/start node to 0
    [graph.startNode setCost:[NSNumber numberWithInt:0]];
    
    NSMutableArray *_nodeList = [[NSMutableArray alloc]initWithArray:[graph listNodes]];
    
    //2. Get the node with the least cost value in the nodeList
    while (_nodeList.count > 0) {
        _nodeList = [self sortArrayOfDictionary:_nodeList byKey:@"cost"];
        Node *node = [_nodeList objectAtIndex:0];
        
        for (Node *node in _nodeList) {
            Node *temp = [graph getNodeWithId:node.nodeId];
            temp = node;
        }
    //3. Get all the neigbor of the current node and update their cost value
        [_nodeList removeObject:node];
        [self relaxNeighbor:node nodeList:_nodeList edgeList:[graph listEdges]];
    }
    //5. Trace the path starting from the destination to start using nodes' parent.
    NSMutableArray *listPath = [[NSMutableArray alloc]init];
    listPath = [Dijktra performSelector:@selector(getPath:container:) withObject:[graph endNode] withObject:listPath];
    return [graph endNode].cost;
}

+ (void)relaxNeighbor:(Node *)node nodeList:(NSMutableArray *)nodeList edgeList:(NSMutableArray *)edgeList
{
    for (int x=0; x<edgeList.count; x++) {
        Edge *edge = [edgeList objectAtIndex:x];
        if(edge.start.nodeId == node.nodeId){
            //3.1 Get the neighbor of the current node
            CGPoint coorStart = CGPointFromString(edge.start.coor);
            CGPoint coorEnd = CGPointFromString(edge.end.coor);
            float currentCost = [edge.end.cost floatValue];
            float newCost = sqrtf(coorStart.x*coorEnd.x + coorStart.y*coorEnd.y);
           
            if(newCost < currentCost)
            {
                //3.2 Update the cost of neighbor node if newCost is less than the currentCost
                for(int y=0; y<nodeList.count; y++)
                {
                    Node *end = [nodeList objectAtIndex:y];
                    if (end.nodeId == edge.end.nodeId) {
                        end.cost = [NSNumber numberWithFloat:newCost];
                        //4. Set the parent of the node for tracing path later
                        [end setParentNode:edge.start];
                        break;
                    }
                }
            }
        }
    }
}

+ (NSArray *)getPath:(Node *)node container:(NSMutableArray *)container
{
    //NOTE: THIS METHOD IS REFUSES TO BE CANCELLED.. FIND A WAY TO CANCEL THIS.
    NSMutableArray *temp = [[NSMutableArray alloc]initWithArray:container];
    [temp insertObject:node atIndex:0];
    if(node.parentNode != nil){
        [self getPath:node.parentNode container:temp];
    }
    else {
        for (int x=0; x<temp.count; x++) {
            NSLog(@" -> %@",[[temp objectAtIndex:x] name]);
        }
    }
    NSLog(@"KILL");
    return (NSArray *)[temp copy];
}

+ (NSMutableArray *)sortArrayOfDictionary:(NSMutableArray *)array byKey:(NSString *)key
{
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc]initWithKey:key ascending:YES];
    [array sortUsingDescriptors:[NSArray arrayWithObject:descriptor]];
    return array;
}

@end