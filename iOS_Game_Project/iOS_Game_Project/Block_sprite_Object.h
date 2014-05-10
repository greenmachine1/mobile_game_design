//
//  Block_sprite_Object.h
//  iOS_Game_Project
//
//  Created by Cory Green on 5/10/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCNode.h"

#import "cocos2d.h"

@interface Block_sprite_Object : CCNode
{
    CCSprite *blockSprite;
    CGPoint location;
}

// **** creation of the enemy **** //
+(id)createBlockWithLocation:(CGPoint)location;
-(CGPoint)returnedPosition;

@end
