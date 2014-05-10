//
//  Block_sprite_Object.m
//  iOS_Game_Project
//
//  Created by Cory Green on 5/10/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "Block_sprite_Object.h"

@implementation Block_sprite_Object

// **** creation with the location inserted **** //
+(id)createBlockWithLocation:(CGPoint)location{
    
    // **** allocates and initializes **** //
    return [[self alloc]initWithLocation:location];
    
}

// **** initializes with the location **** //
-(id)initWithLocation:(CGPoint)thePoint{
    
    if(self =[super init]){
        
        location = thePoint;
        
        NSLog(@"instance of this enemy has been created");
        
        // **** adding in the block sprite **** //
        blockSprite = [CCSprite spriteWithImageNamed:@"Block.png"];
        
        blockSprite.position = thePoint;
        
        // **** adding it to the scene **** //
        [self addChild:blockSprite];
    }
    return self;
    
}

// **** returns the location of the sprite **** //
-(CGPoint)returnedPosition{
    
    return location;
}

@end
