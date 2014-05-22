//
//  pauseAndPlay.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 5/22/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCNode.h"

#import "cocos2d.h"

@interface pauseAndPlay : CCNode
{
    CCSprite *pauseSprite;
    CCSprite *resumeSprite;
}

+(id)creationOfPauseAndPlayAtLocation:(CGPoint)location;
-(CGRect)getBoundingBox;

-(void)pauseAndResume:(int)toggle;

@end
