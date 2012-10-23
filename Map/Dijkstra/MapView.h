//
//  MapView.h
//  Map
//
//  Created by Martin on 10/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Graph.h"

@interface MapView : UIView
{
    Graph *_graph;
}

- (id)initWithGraph:(Graph *)graph;
@end
