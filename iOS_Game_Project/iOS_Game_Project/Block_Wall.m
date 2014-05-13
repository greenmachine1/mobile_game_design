//
//  Block_Wall.m
//  iOS_Game_Project
//
//  Created by Cory Green on 5/11/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "Block_Wall.h"

@implementation Block_Wall


// **** creation of wall block **** //
+(id)createWallAtPosition:(CGPoint)point{
    
    return [[self alloc] initWithPoint:point];
    
}

// **** initialization of the sprite **** //
-(id)initWithPoint:(CGPoint)point{
    
    if(self = [super init]){
        
        // **** setting the location **** //
        self.position = point;
        
        // **** setting the image of the sprite **** //
        brickWallSprite = [CCSprite spriteWithImageNamed:@"Block.png"];
    
        [self addChild:brickWallSprite];
    }
    return self;
}

-(CGPoint)returnLocation{
    
    return self.position;
    
}

@end
