//
//  Path.h
//  TPS2
//
//  Created by martin magalong on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Node;
@interface Edge : NSObject
{
    
}
@property(nonatomic,retain) __strong Node *start;
@property(nonatomic,retain) __strong Node *end;
@property(nonatomic,assign) NSNumber *cost;

- (id)initWithData:(NSDictionary *)data;
@end
