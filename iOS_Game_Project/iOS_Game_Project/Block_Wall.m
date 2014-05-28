//
//  Block_Wall.m
//  iOS_Game_Project
//
//  Created by Cory Green on 5/11/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "Block_Wall.h"
#import "CCAnimation.h"

@implementation Block_Wall

@synthesize name;
//   creation of wall block   //
+(id)createWallAtPosition:(CGPoint)point{
    
    return [[self alloc] initWithPoint:point];
    
}

//   initialization of the sprite   //
-(id)initWithPoint:(CGPoint)point{
    
    if(self = [super init]){
        
        name = @"Block";
        
        //   setting the location   //
        self.position = point;
        
        //   setting the image of the sprite   //
        brickWallSprite = [CCSprite spriteWithImageNamed:@"Block.png"];
        
        [self addChild:brickWallSprite];
    }
    return self;
}

-(CGPoint)returnLocation{
    
    return self.position;
    
}

//   returns the bounding box around the sprite   //
-(CGRect)getBoundingBox{
    
    return CGRectMake(self.position.x - (brickWallSprite.contentSize.width / 2),
                      self.position.y - (brickWallSprite.contentSize.height / 2),
                      brickWallSprite.contentSize.width,
                      brickWallSprite.contentSize.height);
}

-(void)blockAnimate{
    
    // loading images into cache
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"blockanimation.plist"];
    
    NSMutableArray *blockImages = [[NSMutableArray alloc] init];
    
    for(int i = 1; i < 6; i++){
        
        [blockImages addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Block%i.png", i]]];
        
        
    }
    
    
    // creating the animation //
    CCAnimation *animateBlock = [CCAnimation animationWithSpriteFrames:blockImages delay:0.3f];
    
    // creating an action based on that animation //
    CCActionAnimate *animateAction = [CCActionAnimate actionWithAnimation:animateBlock];
    
    CCSprite *blockSprite = [CCSprite spriteWithImageNamed:@"Block1.png"];
    
    // attaching that action to the block sprite
    [blockSprite runAction:animateAction];
    
    //blockSprite.position = ccp(xBounds / 2, yBounds / 2);
    
    [self addChild:blockSprite];
    
    
}

@end
