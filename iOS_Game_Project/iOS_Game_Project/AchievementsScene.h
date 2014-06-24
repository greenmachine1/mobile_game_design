//
//  AchievementsScene.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/23/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "Achievements.h"

@interface AchievementsScene : CCScene
{
    int xBounds;
    int yBounds;
    
    NSString *personsName;
    CCLayoutBox *mainLayout;
    
    
}


+(AchievementsScene *)sceneWithName:(NSString *)name;
-(id)initWithName:(NSString *)passedInName;
@end
