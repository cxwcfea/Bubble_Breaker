//
//  CXViewController.h
//  Bubble Breaker
//
//  Created by Xiang Cheng on 5/8/14.
//  Copyright (c) 2014 Xiang Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXGameBoard.h"
#import "CXGameModel.h"
#import "CXScoreView.h"

@interface CXViewController : UIViewController

@property (nonatomic, assign) BOOL firstTap;
@property (nonatomic, strong) CXScoreView *scoreView;
@property (nonatomic, strong) CXGameBoard *gameBoard;
@property (nonatomic, strong) CXGameModel *gameModal;

- (IBAction)start:(UIButton *)sender;

@end
