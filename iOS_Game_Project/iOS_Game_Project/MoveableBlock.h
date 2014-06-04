//
//  MoveableBlock.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/3/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d-ui.h"
#import "cocos2d.h"

@interface MoveableBlock : CCNode
{
    
    CCSprite *blockSprite;
    
}


+(id)createMovableBlockWithLocation:(CGPoint)location;
-(CGRect)getBoundingBox;
@end
