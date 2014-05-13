//
//  Block_Wall.m
//  iOS_Game_Project
//
//  Created by Cory Green on 5/11/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "Block_Wall.h"

@implementation Block_Wall

@synthesize name;
// **** creation of wall block **** //
+(id)createWallAtPosition:(CGPoint)point{
    
    return [[self alloc] initWithPoint:point];
    
}

// **** initialization of the sprite **** //
-(id)initWithPoint:(CGPoint)point{
    
    if(self = [super init]){
        
        name = @"Block";
        
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

// **** returns the bounding box around the sprite **** //
-(CGRect)getBoundingBox{
    
    return CGRectMake(self.position.x - (brickWallSprite.contentSize.width / 2),
                      self.position.y - (brickWallSprite.contentSize.height / 2),
                      brickWallSprite.contentSize.width,
                      brickWallSprite.contentSize.height);
}

@end
