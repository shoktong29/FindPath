//
//  Dijktra.m
//  TPS
//
//  Created by martin magalong on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Dijktra.h"

@implementation Dijktra

- (NSMutableArray *)findPathInGraph:(Graph *)graph
{
    _graph = graph;
    //1. Set the cost of origin/start node to 0
    [_graph.startNode setCost:[NSNumber numberWithInt:0]];
    
    NSMutableArray *_listNodes = [[NSMutableArray alloc]initWithArray:[_graph listNodes]];
    NSMutableArray *_listEdges = [[NSMutableArray alloc]initWithArray:[_graph listEdges]];
    //2. Get the node with the least cost value in the nodeList
    while(_listNodes.count > 0) {
        _listNodes =   [self sortArrayOfDictionary:_listNodes byKey:@"cost"];
        Node *node = [_listNodes objectAtIndex:0];
        
        //3. Get all the neigbor of the current node and update their cost value
        [_listNodes removeObject:node];
        [self relaxNeighbor:node nodeList:_listNodes edgeList:_listEdges];;
    }
    //5. Trace the path starting from the destination to start using nodes' parent.
    _listPath = [[NSMutableArray alloc]init];
    [self performSelector:@selector(getPath:) withObject:[_graph endNode]];
    return _listPath;
}

- (void)relaxNeighbor:(Node *)node nodeList:(NSMutableArray *)nodeList edgeList:(NSMutableArray *)edgeList
{
    for (int x=0; x<edgeList.count; x++) {
        Edge *edge = [edgeList objectAtIndex:x];
        if(edge.start.nodeId == node.nodeId){
            //3.1 Get the neighbor of the current node
            CGPoint coorStart = CGPointFromString(edge.start.coor);
            CGPoint coorEnd = CGPointFromString(edge.end.coor);
            float currentCost = [edge.end.cost floatValue];
            float newCost = ABS(sqrtf((coorEnd.x-coorStart.x)*(coorEnd.x-coorStart.x) + 
                                  (coorEnd.y-coorStart.y)*(coorEnd.y-coorStart.y)));
           
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

- (void)getPath:(Node *)node
{
    [_listPath insertObject:node atIndex:0];
    if(node.parentNode != nil){
        [self getPath:node.parentNode];
    }
    else {
        if ([_listPath objectAtIndex:0] != [_graph startNode]) {
            _listPath = nil;
        }
    }
}

- (NSMutableArray *)sortArrayOfDictionary:(NSMutableArray *)array byKey:(NSString *)key
{
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc]initWithKey:key ascending:YES];
    [array sortUsingDescriptors:[NSArray arrayWithObject:descriptor]];  
    return array;
}

@end