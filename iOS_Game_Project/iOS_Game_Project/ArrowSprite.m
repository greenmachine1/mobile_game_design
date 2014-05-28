//
//  ArrowSprite.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 5/26/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "ArrowSprite.h"
#import "cocos2d.h"

@implementation ArrowSprite


+(id)createArrowAtLocation:(CGPoint)location{
    
    return [[self alloc ] initWithLocation:location];
    
}

-(id)initWithLocation:(CGPoint)location{
    
    if(self = [super init]){
        
        self.position = location;
        
        arrowSprite = [CCSprite spriteWithImageNamed:@"Guy_move_Arrow.png"];
        
        [self addChild:arrowSprite];
        
    }
    return self;
    
}
@end
