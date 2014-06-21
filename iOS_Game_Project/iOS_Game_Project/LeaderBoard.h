//
//  LeaderBoard.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/19/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d-ui.h"
#import "cocos2d.h"
#import "ScoreClass.h"

@interface LeaderBoard : CCScene
{
    int xBounds;
    int yBounds;
    
    CCLayoutBox *mainLayoutBox;
    ScoreClass *newScoreClass;
    CCSprite *layoutBoxSprite;
    
    CCLabelTTF *scoresLabel;
    
    NSMutableArray *nameArray;
}

+(LeaderBoard *)scene;
@end
