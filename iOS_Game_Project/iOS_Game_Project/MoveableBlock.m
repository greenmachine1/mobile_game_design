//
//  MoveableBlock.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/3/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "MoveableBlock.h"
#import "cocos2d-ui.h"
#import "cocos2d.h"


@implementation MoveableBlock

+(id)createMovableBlockWithLocation:(CGPoint)location{
    
    return [[self alloc] initWithLocation:location];
    
}


-(id)initWithLocation:(CGPoint)location{
    
    if(self = [super init]){
        
        blockSprite = [CCSprite spriteWithImageNamed:@"Block_movable.png"];
        blockSprite.color = [CCColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f];
        
        self.position = location;
        
        [self addChild:blockSprite];
    }
    return self;
}


//   returns the bounding box around the sprite   //
-(CGRect)getBoundingBox{
    
    return CGRectMake(self.position.x - (blockSprite.contentSize.width / 2),
                      self.position.y - (blockSprite.contentSize.height / 2),
                      blockSprite.contentSize.width,
                      blockSprite.contentSize.height);
}

@end
