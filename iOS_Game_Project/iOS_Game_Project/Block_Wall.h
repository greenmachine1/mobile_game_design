//
//  Block_Wall.h
//  iOS_Game_Project
//
//  Created by Cory Green on 5/11/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCNode.h"

#import "cocos2d.h"

@interface Block_Wall : CCNode
{
    CCSprite *brickWallSprite;
}

+(id)createWallAtPosition:(CGPoint)point;
-(CGPoint)returnLocation;

@end
