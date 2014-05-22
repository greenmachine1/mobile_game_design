//
//  pauseAndPlay.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 5/22/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "pauseAndPlay.h"

#import "cocos2d.h"

@implementation pauseAndPlay



+(id)creationOfPauseAndPlayAtLocation:(CGPoint)location{
    
    return [[self alloc] initWithLocation:location];
    
}


-(id)initWithLocation:(CGPoint)location{
    
    
    if(self = [super init]){
        
        
        self.position = location;
        
        pauseSprite = [CCSprite spriteWithImageNamed:@"pause_sprite.png"];
        
        
        
        [self addChild:pauseSprite];
        
    }
    return self;
    
}

//   returns the bounding box around the sprite   //
-(CGRect)getBoundingBox{
    
    return CGRectMake(self.position.x - (pauseSprite.contentSize.width / 2),
                      self.position.y - (pauseSprite.contentSize.height / 2),
                      pauseSprite.contentSize.width,
                      pauseSprite.contentSize.height);
}

-(void)pauseAndResume:(int)toggle{
    
    
    pauseSprite = [CCSprite spriteWithImageNamed:@"play.png"];
    
    [self addChild:pauseSprite];
    
    
    
    
}
@end
