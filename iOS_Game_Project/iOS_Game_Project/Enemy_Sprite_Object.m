//
//  Enemy_Sprite_Object.m
//  iOS_Game_Project
//
//  Created by Cory Green on 5/11/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "Enemy_Sprite_Object.h"

#import "cocos2d.h"


// **** enemy sprite object creation **** //
@implementation Enemy_Sprite_Object

+(id)createEnemyWithStartingPoint:(CGPoint)startingPoint{
    
    return [[self alloc] initWithPoint:startingPoint];
    
}


// ------------------------------------------------------------------------
// **** initialization **** //
-(id)initWithPoint:(CGPoint)point{
    
    if(self = [super init]){
        
        enemySprite = [CCSprite spriteWithImageNamed:@"enemy.png"];
        
        // **** starting the position with the ccpoint passed in **** //
        enemySprite.position = point;
        
        [self actionSequence];
        
        [self addChild:enemySprite];
        
    }
    return self;
    
}




// --------------------------------------------------------------------------
// **** starting the action sequence **** //
-(void)actionSequence{
    
    // **** setting up the first position **** //
    CCActionMoveTo *enemyMoveTo = [CCActionMoveTo actionWithDuration:2.0f position:ccp(200.0f, 20.f)];
    
    // **** setting up the second position **** //
    CCActionMoveTo *enemyMoveFrom = [CCActionMoveTo actionWithDuration:2.0f position:ccp(200.0f, 300.f)];
    
    // **** setting up the back and forth sequence **** //
    CCActionSequence *enemyActionSequence = [CCActionSequence actionOne:enemyMoveTo two:enemyMoveFrom];
    
    // **** repeating the sequence forever **** //
    CCActionRepeatForever *repeatEnemyActionSequence = [CCActionRepeatForever actionWithAction:enemyActionSequence];
    
    // **** setting it in motion **** //
    [enemySprite runAction:repeatEnemyActionSequence];
}



// --------------------------------------------------------------------------
// **** returning the position of the enemy **** //
-(CGPoint)returnLocationOfEnemy{
    
    return enemySprite.position;
    
}

@end
