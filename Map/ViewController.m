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
#import "MapView.h"

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
    NSNumber *start = [NSNumber numberWithInt:1];
    NSNumber *end = [NSNumber numberWithInt:11];
    
    Graph *graph = [[Graph alloc]init];
    graph.startNode = [graph getNodeWithId:start];
    graph.endNode = [graph getNodeWithId:end];
    
    MapView *view = [[MapView alloc]initWithGraph:graph];
    [self.view addSubview:view];
    Dijktra *tps = [[Dijktra alloc]init];
    listPath = [tps findPathInGraph:graph];
    
    
    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow.jpeg"]];
    imageView.frame = CGRectMake(0, 0, 30, 30);
    imageView.center = CGPointFromString([graph startNode].coor);
    [self.view addSubview:imageView];
    [self performSelector:@selector(move)];
    NSLog(@"%@",listPath);
}

- (void)move
{
    static int ctr = 1;
    if(ctr  < listPath.count)
    {
        Node *node = [listPath objectAtIndex:ctr];
        Node *temp = [listPath objectAtIndex:ctr-1];
        CGPoint coor = CGPointFromString(node.coor);
        float time = [node.cost floatValue]/100;
        imageView.transform = CGAffineTransformMakeRotation([node.parentNode getAngleTo:node]);
        [UIView animateWithDuration:time animations:^{
            if (node.parentNode) {
                imageView.center = coor;
            }
        } completion:^(BOOL finished){
            ctr ++;
            [self performSelector:@selector(move)];
        }];
    }
}


@end
