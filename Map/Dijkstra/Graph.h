//
//  Graph.h
//  Map
//
//  Created by Martin on 10/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"
#import "Edge.h"

@interface Graph : NSObject

@property (nonatomic, retain) NSMutableArray *listNodes;
@property (nonatomic, retain) NSMutableArray *listEdges;
@property (nonatomic, retain) Node *startNode;
@property (nonatomic, retain) Node *endNode;
- (Node *)getNodeWithId:(NSNumber *)nodeId;

//For Display only
- (void)renderNodes:(UIView *)renderLayer;
- (void)renderEdges:(UIView *)renderLayer;
@end
