//
//  MapView.m
//  Map
//
//  Created by Martin on 10/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapView.h"
#import <QuartzCore/QuartzCore.h>
#import "Graph.h"

@implementation MapView

- (id)initWithGraph:(Graph *)graph
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 480)];
    if (self) {
        _graph = graph;
    }
    return self;
}

- (void)renderNodes:(CGContextRef)context
{
    for(Node *node in [_graph listNodes])
    {
        CGPoint coor = CGPointFromString(node.coor);
        UIButton *view = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        view.tag = node.nodeId.integerValue;
        view.backgroundColor = [UIColor redColor];
        view.frame = CGRectMake(coor.x-10, coor.y-10, 20, 20);
        [view addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:view];
        
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.frame = CGRectMake(0, 0, 20, 20);
        label.center = coor;
        label.text = node.name;
        [self addSubview:label];
    }
}

- (void)go
{

}

- (void)renderEdges:(CGContextRef)context
{     
    CGContextSetLineWidth(context, 2.0);
    CGContextSetLineCap(context, 5.0);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {0.0, 0.0, 1.0, 1.0};
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetStrokeColorWithColor(context, color);
    
    for(Edge *edge in [_graph listEdges])
    {
        CGPoint coorStart = CGPointFromString(edge.start.coor);
        CGPoint coorEnd = CGPointFromString(edge.end.coor);
        CGContextMoveToPoint(context, coorStart.x,coorStart.y);
        CGContextAddLineToPoint(context, coorEnd.x, coorEnd.y);
    }
        CGContextStrokePath(context);
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Add gradient background
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 0.5,1.0 }; // positions of colors in gradient
    
    //define colors to be used in gradient
    CGColorRef whiteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor; 
    CGColorRef redColor = [UIColor colorWithRed:230.0/255.0 green:1.0/255.0 blue:1.0/255.0 alpha:1.0].CGColor;
    CGColorRef greenColor = [UIColor colorWithRed:1.0/255.0 green:255.0/255.0 blue:1.0/255.0 alpha:1.0].CGColor;
    NSArray *colors = [NSArray arrayWithObjects:(__bridge id)whiteColor, (__bridge id)redColor,(__bridge id)greenColor, nil];
    //create gradient from colorspace and colors and locations
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(100, 0);//CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(100, 350);//CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    //CGContextSaveGState(context);
    //restrict the drawing to specified rect
    CGContextAddRect(context, CGRectMake(0, 0, 320, 350));
    CGContextClip(context);
    //draw gradient
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    //CGContextRestoreGState(context);

    [self renderEdges:context];
    [self renderNodes:context];
}

//-(void)cloudScroll
//{
//    UIImage *cloudsImage = [UIImage imageNamed:@"seemless.jpeg"];
//    UIColor *cloudPattern = [UIColor colorWithPatternImage:cloudsImage];
//    CALayer *cloud = [CALayer layer];
//    cloud.backgroundColor = cloudPattern.CGColor;
//    cloud.transform = CATransform3DMakeScale(1, -1, 1);
//    cloud.anchorPoint = CGPointMake(0, 1);
//    CGSize viewSize = self.bounds.size;
//    cloud.frame = CGRectMake(0, 0, cloudsImage.size.width + viewSize.width, viewSize.height);
//    [self.layer addSublayer:cloud];
//    
//    CGPoint startPoint = CGPointZero;
//    CGPoint endPoint = CGPointMake(-cloudsImage.size.width, 0);
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    animation.fromValue = [NSValue valueWithCGPoint:startPoint];
//    animation.toValue = [NSValue valueWithCGPoint:endPoint];
//    animation.repeatCount = HUGE_VALF;
//    animation.duration = 1.0;
//    [cloud addAnimation:animation forKey:@"position"];
//    
//}
//
//-(void)pauseLayer:(CALayer*)layer
//{
//    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
//    layer.speed = 0.0;
//    layer.timeOffset = pausedTime;
//}
//
//-(void)resumeLayer:(CALayer*)layer
//{
//    CFTimeInterval pausedTime = [layer timeOffset];
//    layer.speed = 1.0;
//    layer.timeOffset = 0.0;
//    layer.beginTime = 0.0;
//    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
//    layer.beginTime = timeSincePause;
//}


@end
