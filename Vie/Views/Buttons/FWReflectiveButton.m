//
// Created by Fabien Warniez on 14-11-27.
// Copyright (c) 2014 Fabien Warniez. All rights reserved.
//

#import "FWReflectiveButton.h"

@implementation FWReflectiveButton

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextAddRect(context, self.bounds);

    CGContextSetFillColorWithColor(context, self.mainColor.CGColor);
    CGContextFillPath(context);

    CGContextBeginPath(context);
    CGContextMoveToPoint(context, (CGFloat) (self.bounds.size.width * 0.9), 0);
    CGContextAddLineToPoint(context, self.bounds.size.width, 0);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    CGContextAddLineToPoint(context, (CGFloat) (self.bounds.size.width * 0.3), self.bounds.size.height);
    CGContextAddLineToPoint(context, (CGFloat) (self.bounds.size.width * 0.9), 0);

    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05].CGColor);
    CGContextFillPath(context);

    if (self.isHighlighted)
    {
        CGContextAddRect(context, self.bounds);

        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.18].CGColor);
        CGContextFillPath(context);
    }
}

@end