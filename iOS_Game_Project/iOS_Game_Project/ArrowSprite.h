//
//  ArrowSprite.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 5/26/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d-ui.h"
#import "cocos2d.h"

@interface ArrowSprite : CCNode
{
    CCSprite *arrowSprite;
}

+(id)createArrowAtLocation:(CGPoint)location;

@end
