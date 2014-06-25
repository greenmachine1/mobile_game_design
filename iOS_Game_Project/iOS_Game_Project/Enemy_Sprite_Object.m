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

-(id)initWithLocation:(CGPoint)location {
    
    if(self = [super init]){
        
        locationPoint = location;
        
        rightPointToStopAt = ccp(self.position.x, 64.0f);
        
        pointToStopAt = 128.0f;
        
        self.position = location;
        
        mainEnemySprite = [CCSprite spriteWithImageNamed:@"enemy-32.png"];
        
        [self addChild:mainEnemySprite];
        
        
    }
    return self;
}

-(void)moveUpAndDown{
    
    CCActionMoveTo *downMovement = [CCActionMoveTo actionWithDuration:3.0f position:ccp(self.position.x, 256.0f)];
    
    CCActionMoveTo *upMovement = [CCActionMoveTo actionWithDuration:3.0f position:ccp(self.position.x, 64.0f)];
    
    CCActionSequence *upAndDownActionSequence = [CCActionSequence actionOne:downMovement two:upMovement];
    
    CCActionRepeatForever *repeatAllActions = [CCActionRepeatForever actionWithAction:upAndDownActionSequence];
    
    [self runAction:repeatAllActions];
    
}


-(void)sideToSide{
    
    rightMovement = [CCActionMoveTo actionWithDuration:3.0f position:ccp(self.position.x + pointToStopAt, self.position.y)];
    
    CCActionMoveTo *leftMovement = [CCActionMoveTo actionWithDuration:3.0f position:ccp(locationPoint.x, self.position.y)];
    
    CCActionSequence *leftAndRightActionSequence = [CCActionSequence actionOne:rightMovement two:leftMovement];
    
    CCActionRepeatForever *repeatAllActions = [CCActionRepeatForever actionWithAction:leftAndRightActionSequence];
    
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
