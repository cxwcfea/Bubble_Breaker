//
//  CXGameModel.m
//  Bubble Breaker
//
//  Created by Xiang Cheng on 5/9/14.
//  Copyright (c) 2014 Xiang Cheng. All rights reserved.
//

#import "CXGameModel.h"

@implementation CXGameModel

- (id)init {
    self = [super init];
    if (self) {
        self.cols = 12;
        self.rows = 11;
        self.matrix = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id)initWithCols:(NSInteger)cols andRows:(NSInteger)rows {
    self = [self init];
    if (self) {
        self.cols = cols;
        self.rows = rows;
        self.numOfColors = 5;
    }
    return self;
}

- (void)reset {
    self.score = 0;
    [self generateMatrix];
}

- (void)generateMatrix {
    [self.matrix removeAllObjects];
    for (int i = 0; i < self.rows; ++i) {
        NSMutableArray *col = [[NSMutableArray alloc] initWithCapacity:self.cols];
        for (int j = 0; j < self.cols; ++j) {
            NSInteger v = arc4random() % self.numOfColors + 1;
            [col addObject:[NSNumber numberWithInteger:v]];
        }
        [self.matrix addObject:col];
    }
}

- (BOOL)isValidMoveAtRow:(NSInteger)row col:(NSInteger)col {
    NSInteger colorType = [[[self.matrix objectAtIndex:row] objectAtIndex:col] integerValue];
    if (!colorType) {
        return NO;
    }
    if (col-1 >= 0 && [[[self.matrix objectAtIndex:row] objectAtIndex:col-1] integerValue] == colorType) {
        return YES;
    }
    if (row-1 >= 0 && [[[self.matrix objectAtIndex:row-1] objectAtIndex:col] integerValue] == colorType) {
        return YES;
    }
    if (col+1 < self.cols && [[[self.matrix objectAtIndex:row] objectAtIndex:col+1] integerValue] == colorType) {
        return YES;
    }
    if (row+1 < self.rows && [[[self.matrix objectAtIndex:row+1] objectAtIndex:col] integerValue] == colorType) {
        return YES;
    }
    return NO;
}

- (void)markMovableAreaFromRow:(NSInteger)row col:(NSInteger)col forColor:(NSInteger)colorType {
    if (row < 0 || col < 0 || row >= self.rows || col >= self.cols) {
        return;
    }
    NSInteger color = [[[self.matrix objectAtIndex:row] objectAtIndex:col] integerValue];
    if (color == 0 || color != colorType) {
        return;
    }
    [[self.matrix objectAtIndex:row] replaceObjectAtIndex:col withObject:[NSNumber numberWithInteger:0]];
    ++self.numOfSphereRemoved;
    
    [self markMovableAreaFromRow:row col:col-1 forColor:colorType];
    [self markMovableAreaFromRow:row-1 col:col forColor:colorType];
    [self markMovableAreaFromRow:row col:col+1 forColor:colorType];
    [self markMovableAreaFromRow:row+1 col:col forColor:colorType];
}

- (void)rightMoveMatrixToCol:(NSInteger)col {
    for (int i = col-1; i >= 0; --i) {
        for (int j = 0; j < self.rows; ++j) {
            NSInteger v = [[[self.matrix objectAtIndex:j] objectAtIndex:i] integerValue];
            [[self.matrix objectAtIndex:j] replaceObjectAtIndex:col withObject:[NSNumber numberWithInteger:v]];
        }
        --col;
    }
    for (int j = 0; j < self.rows; ++j) {
        [[self.matrix objectAtIndex:j] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:0]];
    }
}

- (void)adjuestMatrix {
    for (int j = 0; j < self.cols; ++j) {
        for (int i = self.rows - 1; i >= 0; --i) {
            NSInteger value_i_j = [[[[self matrix] objectAtIndex:i] objectAtIndex:j] integerValue];
            if (value_i_j == 0) {
                for (int k = i - 1; k >= 0; --k) {
                    NSInteger value_k_j = [[[[self matrix] objectAtIndex:k] objectAtIndex:j] integerValue];
                    if (value_k_j) {
                        [[[self matrix] objectAtIndex:k] replaceObjectAtIndex:j withObject:[NSNumber numberWithInteger:value_i_j]];
                        [[[self matrix] objectAtIndex:i] replaceObjectAtIndex:j withObject:[NSNumber numberWithInteger:value_k_j]];
                        break;
                    }
                }
            }
        }
        if ([[[[self matrix] objectAtIndex:self.rows-1] objectAtIndex:j] integerValue] == 0) {
            NSLog(@"the col:%d all empty", j);
            [self rightMoveMatrixToCol:j];
        }
    }
}

- (void)cellTappedAtRow:(NSInteger)row col:(NSInteger)col {
    if (![self isValidMoveAtRow:row col:col]) {
        NSLog(@"invalid move");
        return;
    }
    
    self.numOfSphereRemoved = 0;
    [self markMovableAreaFromRow:row col:col forColor:[[[self.matrix objectAtIndex:row] objectAtIndex:col] integerValue]];
    [self adjuestMatrix];
    NSInteger scoreInThisTime = self.numOfSphereRemoved * (self.numOfSphereRemoved - 1);
    self.score += scoreInThisTime;
    //[self setNeedsDisplay];
    /*
    if ([self isGameOver]) {
        [self gameOver];
    }
     */
}

- (BOOL)isGameOver {
    for (int i = 0; i < self.rows; ++i) {
        for (int j = 0; j < self.cols; ++j) {
            if ([self isValidMoveAtRow:i col:j]) {
                return NO;
            }
        }
    }
    return YES;
}

@end
