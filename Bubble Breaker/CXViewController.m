//
//  CXViewController.m
//  Bubble Breaker
//
//  Created by Xiang Cheng on 5/8/14.
//  Copyright (c) 2014 Xiang Cheng. All rights reserved.
//

#import "CXViewController.h"
#import <math.h>
#import <AudioToolbox/AudioToolbox.h>

#define NUM_OF_COLS 12

@interface CXViewController ()

@end

@implementation CXViewController

SystemSoundID gu;
SystemSoundID dis;

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"h:%f, w:%f", [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    self.scoreView = [[CXScoreView alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
    [self.view addSubview:self.scoreView];
    [self resizeGameBoard];
    [self.view addSubview:self.gameBoard];
    [self prepareGame];
    [self prepareSound];
    
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.gameBoard addGestureRecognizer:g];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareSound {
    NSURL *disUrl = [[NSBundle mainBundle] URLForResource:@"dis" withExtension:@"wav"];
    NSURL *guUrl = [[NSBundle mainBundle] URLForResource:@"gu" withExtension:@"mp3"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)disUrl, &dis);
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)guUrl, &gu);
}

- (void)resizeGameBoard {
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height - 60 - 60;
    NSInteger cellSize = floor(w / NUM_OF_COLS);
    NSInteger rows = floor(h / cellSize);
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - cellSize * NUM_OF_COLS) / 2;
    CGFloat y = 65;
    w = NUM_OF_COLS * cellSize;
    h = rows * cellSize;
    
    self.gameModal = [[CXGameModel alloc] initWithCols:NUM_OF_COLS andRows:rows];
    self.gameBoard = [[CXGameBoard alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.gameBoard.gameModal = self.gameModal;
    self.gameBoard.cellSize = cellSize;
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    CGPoint l = [sender locationInView:self.gameBoard];
    NSInteger x = floor(l.x / self.gameBoard.cellSize);
    NSInteger y = floor(l.y / self.gameBoard.cellSize);
    NSLog(@"user tapped the [%d, %d] cell", y, x);
    AudioServicesPlaySystemSound(gu);
    [self.gameModal cellTappedAtRow:y col:x];
    [self.gameBoard setNeedsDisplay];
    [self.scoreView showScore:self.gameModal.score];
    if ([self.gameModal isGameOver]) {
        [self gameOver];
    }
    //self.scoreLabel.text = [NSString stringWithFormat:@"%d", self.gameBoard.score];
}

- (void)gameOver {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Game Over!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)prepareGame {
    self.firstTap = NO;
    [self.scoreView reset];
    [self.gameModal reset];
    [self.gameBoard setNeedsDisplay];
}

- (IBAction)start:(UIButton *)sender {
    [self prepareGame];
}
@end
