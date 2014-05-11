//
//  CXGameBoard.h
//  Bubble Breaker
//
//  Created by Xiang Cheng on 5/8/14.
//  Copyright (c) 2014 Xiang Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXGameModel.h"

@interface CXGameBoard : UIView

@property (nonatomic, strong) CXGameModel *gameModal;
@property (nonatomic, assign) NSInteger cellSize;

@end
