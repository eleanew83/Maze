//
//  MazeScene.m
//  Maze
//
//  Created by Yi-Lin Jao on 7/22/13.
//  Copyright (c) 2013 Yi-Lin Jao. All rights reserved.
//

#import "MazeScene.h"
#import "WinScene.h"
#import "LoseScene.h"

@interface MazeScene ()
@property BOOL contentCreated;
@property NSMutableArray *listOfBlock;
@property SKSpriteNode *user;
@end

@implementation MazeScene


- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents
{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    [self createMaze];//??
    
    _user = [self newUser];
    _user.position = CGPointMake(CGRectGetMinX(self.frame),CGRectGetMidY(self.frame)+16);
    [self addChild:_user];
}

- (void)createMaze
{
    for (int i = 0; i <= CGRectGetMaxX(self.frame); i = i + 32) {
        SKSpriteNode *block = [self newBlock];
        block.position = CGPointMake(CGRectGetMinX(self.frame) + i, CGRectGetMaxY(self.frame));
        [self addChild:block];
        [_listOfBlock addObject:block];
    }
    for (int i = 0; i <= CGRectGetMaxY(self.frame); i = i + 32) {
        if (i < CGRectGetMidY(self.frame)-32 || i > CGRectGetMidY(self.frame)) {
            SKSpriteNode *block = [self newBlock];
            block.position = CGPointMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame) - i);
            [self addChild:block];
            [_listOfBlock addObject:block];
        }
    }
    for (int i = 0; i <= CGRectGetMaxX(self.frame); i = i + 32) {
        SKSpriteNode *block = [self newBlock];
        block.position = CGPointMake(CGRectGetMinX(self.frame) + i, CGRectGetMinY(self.frame));
        [self addChild:block];
        [_listOfBlock addObject:block];
    }
    for (int i = 0; i <= CGRectGetMaxY(self.frame); i = i + 32) {
        if (i < CGRectGetMidY(self.frame)-32 || i > CGRectGetMidY(self.frame)) {
            SKSpriteNode *block = [self newBlock];
            block.position = CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame) - i);
            [self addChild:block];
            [_listOfBlock addObject:block];
        }
    }
    for (int i = 0; i <= CGRectGetMaxY(self.frame) / 2; i = i + 32) {
        if (i < CGRectGetMidY(self.frame)) {
            SKSpriteNode *block = [self newBlock];
            block.position = CGPointMake(CGRectGetMaxX(self.frame)/4, CGRectGetMaxY(self.frame) - i);
            [self addChild:block];
            [_listOfBlock addObject:block];
        }
    }
    for (int i = 0; i <= CGRectGetMaxY(self.frame) / 2; i = i + 32) {
        if (i < CGRectGetMidY(self.frame)) {
            SKSpriteNode *block = [self newBlock];
            block.position = CGPointMake(CGRectGetMaxX(self.frame)*3/4, CGRectGetMaxY(self.frame) - i);
            [self addChild:block];
            [_listOfBlock addObject:block];
        }
    }
    for (int i = 0; i <= CGRectGetMaxX(self.frame); i = i + 32) {
        if (i < CGRectGetMidX(self.frame) || i > CGRectGetMidX(self.frame) + 200) {
            SKSpriteNode *block = [self newBlock];
            block.position = CGPointMake(CGRectGetMinX(self.frame) + i, CGRectGetMaxY(self.frame)/4);
            [self addChild:block];
            [_listOfBlock addObject:block];
        }
    }
    for (int i = 0; i <= CGRectGetMaxY(self.frame); i = i + 32) {
        if (i >= CGRectGetMaxY(self.frame)/4 && i <= CGRectGetMaxY(self.frame)*3/4) {
            SKSpriteNode *block = [self newBlock];
            block.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) + i);
            [self addChild:block];
            [_listOfBlock addObject:block];
        }
    }
}

- (SKSpriteNode *)newBlock
{
    SKSpriteNode *block = [[SKSpriteNode alloc] initWithColor:[SKColor grayColor] size:CGSizeMake(32,32)];

    return block;
}

- (SKSpriteNode *)newUser
{
    SKSpriteNode *user = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(32,32)];
    return user;
}

- (void)touchesBegan:(NSSet*) touches withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        CGPoint location = [t locationInNode:self];
        SKAction *moveToClick = [SKAction moveTo:location duration:0.01];
        [self.user runAction:moveToClick];
        //for (SKSpriteNode *block in _listOfBlock) {
                    //}
        if (location.x > CGRectGetMaxX(self.frame)-32 && location.y > CGRectGetMidY(self.frame)-32 && location.y < CGRectGetMidY(self.frame)+32) {
            SKScene* winScene  = [[WinScene alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
            [self.view presentScene:winScene transition:doors];
        }
    }
}

@end
