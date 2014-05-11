//
//  CXScoreView.m
//  Bubble Breaker
//
//  Created by Xiang Cheng on 5/10/14.
//  Copyright (c) 2014 Xiang Cheng. All rights reserved.
//

#import "CXScoreView.h"

@implementation CXScoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 6.0;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0;
        self.scroeLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 2, 60, 40)];
        self.scroeLabel.textColor = [UIColor blackColor];
        self.scroeLabel.text = @"0";
        [self addSubview:self.scroeLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)reset {
    self.scroeLabel.text = @"0";
}

- (void)showScore:(NSInteger)score {
    self.scroeLabel.text = [NSString stringWithFormat:@"%d", score];
}

@end
