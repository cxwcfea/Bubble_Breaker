//
//  CXGameModel.h
//  Bubble Breaker
//
//  Created by Xiang Cheng on 5/9/14.
//  Copyright (c) 2014 Xiang Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXGameModel : NSObject

@property (nonatomic, assign) NSInteger numOfSphereRemoved;
@property (nonatomic, assign) NSInteger numOfColors;
@property (nonatomic, assign) NSInteger cols;
@property (nonatomic, assign) NSInteger rows;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) BOOL win;
@property (nonatomic, strong) NSMutableArray *matrix;

- (id)initWithCols:(NSInteger)cols andRows:(NSInteger)rows;
- (void)cellTappedAtRow:(NSInteger)row col:(NSInteger)col;
- (BOOL)isGameOver;
- (void)reset;

@end
