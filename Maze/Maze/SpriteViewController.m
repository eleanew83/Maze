//
//  SpriteViewController.m
//  Maze
//
//  Created by Yi-Lin Jao on 7/22/13.
//  Copyright (c) 2013 Yi-Lin Jao. All rights reserved.
//

#import "SpriteViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "MazeScene.h"

@interface SpriteViewController ()

@end

@implementation SpriteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)loadView
{
    self.view = [[SKView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	SKView *spriteView = (SKView*) self.view;
    spriteView.showsDrawCount = YES;
    spriteView.showsNodeCount = YES;
    spriteView.showsFPS = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    MazeScene* maze = [[MazeScene alloc] initWithSize:CGSizeMake(768,1024)];
    SKView *spriteView = (SKView*) self.view;
    [spriteView presentScene: maze];
}

@end
