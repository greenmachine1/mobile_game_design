//
//  EndBox.h
//  iOS_Game_Project
//
//  Created by Cory Green on 5/14/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"

@interface EndBox : CCNode
{
    CCSprite *endBoxSprite;
}

+(id)createEndBoxWithLocation:(CGPoint)location;
-(CGRect)getBoundingBox;

@end
