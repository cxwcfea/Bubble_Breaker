//
//  CXScoreView.h
//  Bubble Breaker
//
//  Created by Xiang Cheng on 5/10/14.
//  Copyright (c) 2014 Xiang Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXScoreView : UIView

@property (nonatomic, strong) UILabel *scroeLabel;

- (void)showScore:(NSInteger)score;
- (void)reset;

@end
