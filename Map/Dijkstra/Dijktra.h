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
/* Computes and returns integer value for the travel cost(int). */
+ (NSNumber *)findPathInGraph:(Graph *)graph;

/* Gets the neibors of a node and update the cost value if necessary. */
+ (void)relaxNeighbor:(Node *)node nodeList:(NSMutableArray *)nodeList edgeList:(NSMutableArray *)edgeList;

/* Returns an array of nodes(the path). */
+ (NSArray *)getPath:(Node *)node container:(NSMutableArray *)container;

/* Sorts array of dictionary in ascending according by key*/
+ (NSMutableArray *)sortArrayOfDictionary:(NSMutableArray *)array byKey:(NSString *)key;

@end
