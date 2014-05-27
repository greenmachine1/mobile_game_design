//
//  MainMenuScene.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 5/25/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"

@interface MainMenuScene : CCScene
{
    int xBounds;
    int yBounds;
    
    CCLayoutBox *layoutBox;
}

+(MainMenuScene *)scene;


@end
