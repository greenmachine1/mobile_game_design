//
//  Breakable_Block.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/12/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d-ui.h"
#import "cocos2d.h"

@interface Breakable_Block : CCNode
{
    CCSprite *breakableBlockSprite;
    
}

+(id)createBlockAtLocation:(CGPoint)location;
-(CGRect)getBoundingBox;
@end
