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
#import "Line.h"
//#import <UIGravityBehavior.h>

@interface MazeScene ()
@property BOOL contentCreated;
@property NSMutableArray *listOfBlock;
@property SKSpriteNode *user;
@end
static const uint32_t userCategory =  0;
static const uint32_t blockCategory =  0x1 << 1;

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
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.gravity = CGPointMake(0,0);
    self.physicsWorld.contactDelegate = self;
    
    _listOfBlock = [[NSMutableArray alloc] init];
    [self createMaze];
    
    _user = [self newUser];
    _user.position = CGPointMake(CGRectGetMinX(self.frame)+20,CGRectGetMidY(self.frame)+16);
    
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

- (void)update:(NSTimeInterval)currentTime
{
}

- (void)didSimulatePhysics
{
    
}

- (SKSpriteNode *)newBlock
{
    SKSpriteNode *block = [[SKSpriteNode alloc] initWithColor:[SKColor grayColor] size:CGSizeMake(32,32)];
    block.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:block.size];
    block.physicsBody.usesPreciseCollisionDetection = YES;
    block.physicsBody.dynamic = NO;
    block.physicsBody.categoryBitMask = blockCategory;
    block.physicsBody.contactTestBitMask = userCategory;
    
    return block;
}

- (SKSpriteNode *)newUser
{
    SKSpriteNode *user = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(32,32)];
    user.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:user.size];
    user.physicsBody.dynamic = YES;
    user.physicsBody.affectedByGravity = NO;
    user.physicsBody.usesPreciseCollisionDetection = YES;
    user.physicsBody.categoryBitMask = userCategory;
    user.physicsBody.contactTestBitMask = blockCategory;
    
    return user;
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    if((contact.bodyA.categoryBitMask & contact.bodyB.categoryBitMask) == 0)
    {
        /*SKScene* loseScene  = [[LoseScene alloc] initWithSize:self.size];
        SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
        [self.view presentScene:loseScene transition:doors];*/
    }

}

- (void)touchesBegan:(NSSet*) touches withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        CGPoint location = [t locationInNode:self];
        CGPoint vector = CGPointMake(location.x-_user.position.x, location.y-_user.position.y);
        [_user.physicsBody applyForce:vector];
        //SKAction *moveToClick = [SKAction moveTo:location duration:0.01];
        //[self.user runAction:moveToClick];
        //[self setXComponent:location.x-_user.position.x setYComponent:location.y-_user.position.y];
        
        //Line *line = [[Line alloc] init];
        //[line setBegin:_user.position];
        //[line setEnd:location];
        
        //disable clicking on wall = losing
        
       /* for (SKSpriteNode *block in _listOfBlock) {
            if ([block containsPoint:location]) {
                SKScene* loseScene  = [[LoseScene alloc] initWithSize:self.size];
                SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
                [self.view presentScene:loseScene transition:doors];
            }*/
        
            //for (CGPoint point in line.pts) {
            //    if ([block containsPoint:point]) {
            //        SKScene* loseScene  = [[LoseScene alloc] initWithSize:self.size];
            //        SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
            //        [self.view presentScene:loseScene transition:doors];
            //    }
            //}
        
        /*if (location.x > CGRectGetMaxX(self.frame)-32 && location.y > CGRectGetMidY(self.frame)-32 && location.y < CGRectGetMidY(self.frame)+32) {
            SKScene* winScene  = [[WinScene alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
            [self.view presentScene:winScene transition:doors];
        }*/
        
        
        if (_user.position.x > CGRectGetMaxX(self.frame)-32 && _user.position.y > CGRectGetMidY(self.frame)-32 && _user.position.y < CGRectGetMidY(self.frame)+32){
            SKScene* winScene  = [[WinScene alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
            [self.view presentScene:winScene transition:doors];
            
        }
    }
}

@end
