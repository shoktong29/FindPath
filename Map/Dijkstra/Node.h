//
//  Node.h
//  TPS2
//
//  Created by martin magalong on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject
{

}
@property (nonatomic,readonly) NSNumber *nodeId;
@property (nonatomic,readonly) NSNumber *cost;
@property (nonatomic,readonly) __strong NSString *name;
@property (nonatomic,readonly) __strong NSString *coor;
@property (nonatomic,readonly) Node *parentNode;


- (id)initWithData:(NSDictionary *)data;
- (void)setCost:(NSNumber *)cost;
- (void)setParentNode:(Node *)parentNode;
@end
