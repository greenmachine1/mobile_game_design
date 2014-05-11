//
//  Enemy_Sprite_Object.h
//  iOS_Game_Project
//
//  Created by Cory Green on 5/11/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCNode.h"

#import "cocos2d.h"

@interface Enemy_Sprite_Object : CCNode
{
    CCSprite *enemySprite;
    CGPoint startingPointOfSprite;
}

+(id)createEnemyWithStartingPoint:(CGPoint)startingPoint;
-(CGPoint)returnLocationOfEnemy;

@end
