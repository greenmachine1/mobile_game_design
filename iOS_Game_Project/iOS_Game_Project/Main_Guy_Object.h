//
//  Main_Guy_Object.h
//  iOS_Game_Project
//
//  Created by Cory Green on 5/11/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCNode.h"

#import "cocos2d.h"

@interface Main_Guy_Object : CCNode
{
    CCSprite *mainGuySprite;
    CGPoint locationPoint;
}

+(id)createGuyAtLocation:(CGPoint)location;
-(void)moveGuyToPoint:(CGPoint)pointToMoveToo;
-(CGPoint)returnLocation;


@end
