//
//  CXGameBoard.m
//  Bubble Breaker
//
//  Created by Xiang Cheng on 5/8/14.
//  Copyright (c) 2014 Xiang Cheng. All rights reserved.
//

#import "CXGameBoard.h"

CGFloat g_colors[5][8] = {
    {
        1, 0.3, 0, 1,
        .5, .15, 0, 1,
    },
    {
        1., 1., .5, 1,
        .5, .5, .25, 1,
    },
    {
        .5, 1., 1., 1,
        .25, .5, .5, 1,
    },
    {
        1., .5, 1., 1,
        .5, .25, .5, 1,
    },
    {
        .4, .4, 1., 1,
        .1, .1, .5, 1,
    }
};

@implementation CXGameBoard

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 6.0;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //[self drawGrid];
    [self drawTokens];
}

- (void)drawGrid
{
    NSLog(@"cellSize:%d cols:%d rows:%d", self.cellSize, self.gameModal.cols, self.gameModal.rows);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1.);
    CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
    for (int i = 0; i <= self.gameModal.cols; ++i) {
        CGContextMoveToPoint(ctx, i * self.cellSize, 0);
        CGContextAddLineToPoint(ctx, i * self.cellSize, self.frame.size.height);
    }
    for (int j = 0; j <= self.gameModal.rows; ++j) {
        CGContextMoveToPoint(ctx, 0, j * self.cellSize);
        CGContextAddLineToPoint(ctx, self.frame.size.width, j*self.cellSize);
    }
    CGContextStrokePath(ctx);
}

- (void)drawTokens {
    NSArray *matrix = self.gameModal.matrix;
    for (int i = 0; i < matrix.count; ++i) {
        NSArray *col = [matrix objectAtIndex:i];
        for (int j = 0; j < [col count]; ++j) {
            NSInteger colorType = [[col objectAtIndex:j] intValue];
            if (colorType > 0) {
                [self drawTokenAtCellX:j CellY:i withColorType:colorType-1];
            }
        }
    }
}

- (void)drawTokenAtCellX:(NSInteger)cellX CellY:(NSInteger)cellY withColorType:(NSInteger)colorType {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGFloat x = (cellX + .4) * self.cellSize;
    CGFloat y = (cellY + .6) * self.cellSize;
    CGContextTranslateCTM(ctx, x, y);
    
    CGFloat gradientX = self.cellSize * .1;
    CGFloat gradientY = -self.cellSize * .1;
    CGPoint start = {gradientX,gradientY}, end = {gradientX,gradientY};
    
    CGFloat startRadius = 0;
    CGFloat endRadius = self.cellSize * .4 * 1.2;
    
    CGFloat *colors = g_colors[colorType];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0,1.0};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace,colors,locations,
                                                                 sizeof(locations)/sizeof(CGFloat));
    
    CGContextDrawRadialGradient(ctx,gradient,start,startRadius,end,endRadius,0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(ctx);
}

@end
