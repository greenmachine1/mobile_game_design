//
//  Enemy_Sprite_Object.m
//  iOS_Game_Project
//
//  Created by Cory Green on 5/14/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "Enemy_Sprite_Object.h"
#import "cocos2d.h"

@implementation Enemy_Sprite_Object


+(id)createEnemyWithLocation:(CGPoint)location{
    
    return [[self alloc] initWithLocation:location];
    
}

-(id)initWithLocation:(CGPoint)location{
    
    if(self = [super init]){
        
        locationPoint = location;
        
        self.position = location;
        
        mainEnemySprite = [CCSprite spriteWithImageNamed:@"enemy.png"];
        
        [self addChild:mainEnemySprite];
        
        [self moveUpAndDown];
        
    }
    return self;
}

-(void)moveUpAndDown{
    
    CCActionMoveTo *downMovement = [CCActionMoveTo actionWithDuration:3.0f position:ccp(self.position.x, self.position.y - 128)];
    
    CCActionMoveTo *upMovement = [CCActionMoveTo actionWithDuration:3.0f position:ccp(self.position.x, locationPoint.y)];
    
    CCActionSequence *upAndDownActionSequence = [CCActionSequence actionOne:downMovement two:upMovement];
    
    CCActionRepeatForever *repeatAllActions = [CCActionRepeatForever actionWithAction:upAndDownActionSequence];
    
    [self runAction:repeatAllActions];
    
}

//   returning the position   //
-(CGPoint)returnLocation{
    
    return self.position;
}

//   returns the bounding box around the sprite   //
-(CGRect)getBoundingBox{
    
    return CGRectMake(self.position.x - (mainEnemySprite.contentSize.width / 2),
                      self.position.y - (mainEnemySprite.contentSize.height / 2),
                      mainEnemySprite.contentSize.width,
                      mainEnemySprite.contentSize.height);
}

@end
