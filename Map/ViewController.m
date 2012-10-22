//
//  ViewController.m
//  Map
//
//  Created by Martin on 10/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Graph.h"
#import "Dijktra.h"


@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) 
    {
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super  viewWillAppear:animated];
    Graph *graph = [[Graph alloc]init];
    graph.startNode = [graph getNodeWithId:[NSNumber numberWithInt:1]];
    graph.endNode = [graph getNodeWithId:[NSNumber numberWithInt:3]];
    [graph renderNodes:self.view];
    [graph renderEdges:self.view];
    
    NSLog(@"%@",[Dijktra findPathInGraph:graph]);
}


@end
