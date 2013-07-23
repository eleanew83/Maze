//
//  WinScene.m
//  Maze
//
//  Created by Yi-Lin Jao on 7/22/13.
//  Copyright (c) 2013 Yi-Lin Jao. All rights reserved.
//

#import "WinScene.h"
#import "MazeScene.h"

@interface WinScene ()
@property BOOL contentCreated;
@end

@implementation WinScene

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
    self.backgroundColor = [SKColor blueColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    [self addChild: [self winEndNode]];
}

- (SKLabelNode*)winEndNode
{
    SKLabelNode *winEndNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    winEndNode.text = @"You Win!";
    winEndNode.fontSize = 60;
    winEndNode.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    winEndNode.name = @"winEndNode";
    return winEndNode;
}


@end
