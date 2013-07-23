//
//  LoseScene.m
//  Maze
//
//  Created by Yi-Lin Jao on 7/22/13.
//  Copyright (c) 2013 Yi-Lin Jao. All rights reserved.
//

#import "LoseScene.h"
#import "MazeScene.h"

@interface LoseScene ()
@property BOOL contentCreated;
@end

@implementation LoseScene

- (void)didMoveToView: (SKView*) view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents
{
    self.backgroundColor = [SKColor redColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    [self addChild: [self loseEndNode]];
    [self addChild:[self restartNode]];
}

- (SKLabelNode*)loseEndNode
{
    SKLabelNode *loseEndNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    loseEndNode.text = @"You Lose!";
    loseEndNode.fontSize = 60;
    loseEndNode.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    loseEndNode.name = @"loseEndNode";
    return loseEndNode;
}

- (SKLabelNode *)restartNode
{
    SKLabelNode *restart = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    restart.text = @"Tap anywhere to restart";
    restart.fontSize = 40;
    restart.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-60);
    return restart;
    
}

- (void)touchesBegan:(NSSet*) touches withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        
        SKScene* mazeScene  = [[MazeScene alloc] initWithSize:self.size];
        SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
        [self.view presentScene:mazeScene transition:doors];
        
        
    }
}
@end
