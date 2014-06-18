//
//  MainMenuScene.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 5/25/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import "GameCenterClass.h"
#import <GameKit/GameKit.h>

@interface MainMenuScene : CCScene<GKGameCenterControllerDelegate>
{
    int xBounds;
    int yBounds;
    
    CCLayoutBox *layoutBox;
    
    GameCenterClass *newGameCenterClass;
    GKGameCenterViewController *newGameCenterView;
    
}

+(MainMenuScene *)scene;


@end
