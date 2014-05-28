//
//  CreditsScene.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 5/26/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface CreditsScene : CCScene
{
    int xBounds;
    int yBounds;
    
    CCLayoutBox *creditsLayout;
    
}

+(CreditsScene *)scene;
@end
