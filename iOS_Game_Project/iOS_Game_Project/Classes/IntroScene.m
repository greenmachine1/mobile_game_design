//
//  IntroScene.m
//  iOS_Game_Project
//
//  Created by Cory Green on 5/5/14.
//  Copyright Cory Green 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"

#import "Block_sprite_Object.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------
- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    

    
    
// -----------------------------------------------------------------------
    // **** enabling audio for effects **** //
    hammer = [OALSimpleAudio sharedInstance];
    water = [OALSimpleAudio sharedInstance];
    
    
// -----------------------------------------------------------------------
    // **** getting the x and y coords of the screen size **** //
    xBounds = self.contentSize.width;
    yBounds = self.contentSize.height;

    
    // **** changing the background color to a light blue **** //
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.1 green:0.4 blue:0.5 alpha:1.0]];
    
    // **** adding the background color to the scene **** //
    [self addChild:background];
    
    
    
// -----------------------------------------------------------------------
    // **** setting the sprite to hold the guy image **** //
    guySprite = [CCSprite spriteWithImageNamed:@"guy_pixel_art.png"];
    
    // **** setting the location to be the very center of the screen **** //
    [guySprite setPosition:ccp(self.contentSize.width / 2, self.contentSize.height / 2)];
    
    // **** addin the guy to the screen **** //
    [self addChild:guySprite];
    
    
    
    
    
// -----------------------------------------------------------------------
    // **** calling on the block sprite object **** //
    
    Block_sprite_Object *newObject = [Block_sprite_Object createBlockWithLocation:ccp(100.0f, 100.0f)];
    Block_sprite_Object *secondObject = [Block_sprite_Object createBlockWithLocation:ccp(200.0f, 140.0f)];
    
    // **** from this I can get specific x and y values from each object **** //
    // **** for collision detection **** //
    pointOfSecondObject = [secondObject returnedPosition];
    
    [self addChild:secondObject];
    [self addChild:newObject];
    
    
    
    
// -----------------------------------------------------------------------
    // **** adding the enemy sprite **** //
    enemySprite = [CCSprite spriteWithImageNamed:@"enemy.png"];
    
    // **** setting its position **** //
    [enemySprite setPosition:ccp(200.0, 300.0)];
    
    // **** adding it to the scene **** //
    [self addChild:enemySprite];
    
    // **** triggering the action sequence **** //
    [self actionSequence];
    
	return self;
}


-(void)onEnter{
    [super onEnter];
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
}




// ------------------------------------------------------------------------
// **** up and down movement of the enemy
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




// ------------------------------------------------------------------------
// **** update loop **** //
-(void)update:(CCTime)delta{
    
    if([self collisionOfFirstObject:guySprite.position second:pointOfSecondObject] == true){
        NSLog(@"Collision!");
        
        // **** repositioning my guy **** //
        guySprite.position = ccp(20, 200);
        
        // **** plays a hammer type sound **** //
        [water playBg:@"Hammer.mp3" loop:false];
        
        pointOfEnemy = ccp(enemySprite.position.x, enemySprite.position.y);
        
    }
    
}







// -------------------------------------------------------------------------
// **** checking for collision, taking in two points and comparing **** //
-(BOOL)collisionOfFirstObject:(CGPoint)firstObject second:(CGPoint)secondObject{
    
    if((firstObject.x <= secondObject.x + 20) && (firstObject.x >= secondObject.x - 20) &&
       (firstObject.y <= secondObject.y + 20) && (firstObject.y >= secondObject.y - 20)){
        
        return true;
    }
    return false;
}


// -------------------------------------------------------------------------
// **** move the guy to a point on the screen **** //
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CGPoint touchPoint = [touch locationInNode:self];
    
    NSLog(@"%@", NSStringFromCGPoint(touchPoint));
    
    CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:1.0f position:touchPoint];
    
    [guySprite runAction:actionMove];
    
    // **** this basically sees if your touch over the enemy is true and if so **** //
    // **** play a sea sound **** //
    if((touchPoint.x <= enemySprite.position.x + 20) && (touchPoint.x >= enemySprite.position.x - 20) &&
       (touchPoint.y <= enemySprite.position.y + 20) && (touchPoint.y >= enemySprite.position.y - 20)){
    
        // **** plays a sea sound **** //
        [water playBg:@"sea_audio.mp3" loop:false];
    }
    
}




@end
