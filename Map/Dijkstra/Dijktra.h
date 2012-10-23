//
//  Dijktra.h
//  TPS
//
//  Created by martin magalong on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Graph.h"

@interface Dijktra : NSObject
{
//    NSMutableArray *_listNodes;
//    NSMutableArray *_listEdges;
    NSMutableArray *_listPath;
    Graph *_graph;
    Node *startNode;
    Node *endNode;
}
/* Computes and returns integer value for the travel cost(int). */
- (NSMutableArray *)findPathInGraph:(Graph *)graph;

/* Gets the neibors of a node and update the cost value if necessary. */
- (void)relaxNeighbor:(Node *)node nodeList:(NSMutableArray *)nodeList edgeList:(NSMutableArray *)edgeList;

/* Returns an array of nodes(the path). */
- (void)getPath:(Node *)node;

/* Sorts array of dictionary in ascending according by key*/
- (NSMutableArray *)sortArrayOfDictionary:(NSMutableArray *)array byKey:(NSString *)key;

@end
