//
//  heathHeartSprite.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 5/21/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"

@interface heathHeartSprite : CCNode
{
    CCSprite *healthSprite;
}

+(id)createHeathHeartAtLocation:(CGPoint)location;

@end
