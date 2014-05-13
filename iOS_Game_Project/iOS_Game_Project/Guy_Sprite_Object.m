//
//  Guy_Sprite_Object.m
//  iOS_Game_Project
//
//  Created by Cory Green on 5/12/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "Guy_Sprite_Object.h"

#import "cocos2d.h"

@implementation Guy_Sprite_Object


// **** creation of guy sprite **** //
+(id)createGuySpriteWithLocation:(CGPoint)locationPoint{
    
    return [[self alloc] initWithLocation:locationPoint];
    
}

// **** init with location
-(id)initWithLocation:(CGPoint)locationPoint{
    
    if(self = [super init]){
        
        self.position = locationPoint;
        
        guySprite = [CCSprite spriteWithImageNamed:@"guy_pixel_art.png"];
        
        [self addChild:guySprite];
    }
    return self;
    
}

@end
