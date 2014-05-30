//
//  EndBox.m
//  iOS_Game_Project
//
//  Created by Cory Green on 5/14/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "EndBox.h"
#import "cocos2d.h"
#import "CCAnimation.h"

@implementation EndBox


+(id)createEndBoxWithLocation:(CGPoint)location{
    
    return [[self alloc] initWithLocation:location];
    

}

-(id)initWithLocation:(CGPoint)location{
    
    
    if(self = [super init]){
        
        self.position = location;
        
        endBoxSprite = [CCSprite spriteWithImageNamed:@"Flag-1.png"];
        
        [self addChild:endBoxSprite];
        
        [self flagAnimate];
        
    }
    return self;
    
}

//   returns the bounding box around the sprite   //
-(CGRect)getBoundingBox{
    
    return CGRectMake(self.position.x - (endBoxSprite.contentSize.width / 2),
                      self.position.y - (endBoxSprite.contentSize.height / 2),
                      endBoxSprite.contentSize.width,
                      endBoxSprite.contentSize.height);
}


-(void)flagAnimate{
    
    [endBoxSprite removeFromParentAndCleanup:TRUE];
    
    // loading images into cache
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Flag.plist"];
    
    
    // ascending order //
    NSMutableArray *flagImages = [[NSMutableArray alloc] init];
    
    for(int i = 1; i < 8; i++){
        
        [flagImages addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Flag-%i.png", i]]];
        NSLog(@"numbers going up %i", i);
        
    }
    
    // descending order //
    NSMutableArray *flagImagesInReverse = [[NSMutableArray alloc] init];
    
    for(int j = 8; j > 1; j--){
        
        [flagImagesInReverse addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Flag-%i.png", j]]];
        NSLog(@"numbers decending %i", j);
        
    }
    
    
    // creating the animation //
    CCAnimation *animateFlagForward = [CCAnimation animationWithSpriteFrames:flagImages delay:0.1f];
    
    // creating an action based on that animation //
    CCActionAnimate *animateAction = [CCActionAnimate actionWithAnimation:animateFlagForward];
    
    // creating the animation in reverse //
    CCAnimation *animateFlagBackwards = [CCAnimation animationWithSpriteFrames:flagImagesInReverse delay:0.1f];
    
    // creating an action based on the reverse animation //
    CCActionAnimate *animateActionBackwards = [CCActionAnimate actionWithAnimation:animateFlagBackwards];
    
    
    
    // combining both actions to make a loop
    CCActionSequence *backAndForthAnimation = [CCActionSequence actionOne:animateAction two:animateActionBackwards];
    
    CCActionRepeatForever *repeatAllActions = [CCActionRepeatForever actionWithAction:backAndForthAnimation];
    
    
    
    
    CCSprite *flagSprite = [CCSprite spriteWithImageNamed:@"Flag-1.png"];
    
    // attaching that action to the block sprite
    [flagSprite runAction:repeatAllActions];
    
    
    
    [self addChild:flagSprite];
    
    
}




@end
