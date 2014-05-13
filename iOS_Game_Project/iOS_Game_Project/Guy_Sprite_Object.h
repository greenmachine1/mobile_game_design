//
//  Guy_Sprite_Object.h
//  iOS_Game_Project
//
//  Created by Cory Green on 5/12/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCNode.h"

#import "cocos2d.h"

@interface Guy_Sprite_Object : CCNode
{
    CCSprite *guySprite;
}

+(id)createGuySpriteWithLocation:(CGPoint)locationPoint;
-(CGPoint)returnLocation;
@end
