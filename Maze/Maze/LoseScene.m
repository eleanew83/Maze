//
//  LoseScene.m
//  Maze
//
//  Created by Yi-Lin Jao on 7/22/13.
//  Copyright (c) 2013 Yi-Lin Jao. All rights reserved.
//

#import "LoseScene.h"

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

@end
