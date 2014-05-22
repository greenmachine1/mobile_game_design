//
//  heathHeartSprite.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 5/21/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "heathHeartSprite.h"

#import "cocos2d.h"

@implementation heathHeartSprite

+(id)createHeathHeartAtLocation:(CGPoint)location{
    
    return [[self alloc] initWithLocation:location];
    
}

-(id)initWithLocation:(CGPoint)location{
    
    if(self = [super init]){
        
        
        healthSprite = [CCSprite spriteWithImageNamed:@"healthHeartSprite.png"];
        
        self.position = location;
        
        [self addChild:healthSprite];
    }
    return self;
    
}


@end
