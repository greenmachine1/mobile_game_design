//
//  Enemy_Sprite_Object.h
//  iOS_Game_Project
//
//  Created by Cory Green on 5/14/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCNode.h"

#import "cocos2d.h"

@interface Enemy_Sprite_Object : CCNode
{
    
    CGPoint locationPoint;
    CCSprite *mainEnemySprite;
}

+(id)createEnemyWithLocation:(CGPoint)location;
-(CGPoint)returnLocation;
-(CGRect)getBoundingBox;

@end
