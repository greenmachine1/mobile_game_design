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

#import "Enemy_Sprite_Object.h"

#import "Main_Guy_Object.h"

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
    
    // **** creating an instance of the main guy **** //
    newMainGuy = [Main_Guy_Object createGuyAtLocation:ccp(self.contentSize.width / 2, self.contentSize.height / 2)];
    
    [self addChild:newMainGuy];
    
    
    
    
    
// -----------------------------------------------------------------------
    // **** calling on the block sprite object **** //
    
    Block_sprite_Object *newObject = [Block_sprite_Object createBlockWithLocation:ccp(100.0f, 100.0f)];
    secondObject = [Block_sprite_Object createBlockWithLocation:ccp(200.0f, 140.0f)];
    
    // **** from this I can get specific x and y values from each object **** //
    // **** for collision detection **** //
    pointOfSecondObject = [secondObject returnedPosition];
    
    [self addChild:secondObject];
    [self addChild:newObject];
    
    
    
    
// -----------------------------------------------------------------------
    // **** adding the enemy sprite **** //
    // **** creating an enemy with a starting point **** //
    newEnemy = [Enemy_Sprite_Object createEnemyWithStartingPoint:ccp(200.0f, 300.0f)];
    
    [self addChild:newEnemy];
    
	return self;
}


-(void)onEnter{
    [super onEnter];
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
}






// ------------------------------------------------------------------------
// **** update loop **** //
-(void)update:(CCTime)delta{
    
    
    // **** running collision detection on the guy sprite and point of the second object **** //
    if([self collisionOfFirstObject:[newMainGuy returnLocation] second:pointOfSecondObject] == true){
        NSLog(@"Collision!");
        
        NSLog(@"Location %@", NSStringFromCGPoint([newMainGuy returnLocation]));
        
        // **** plays a hammer type sound **** //
        [water playBg:@"Hammer.mp3" loop:false];
    }
    
}







// -------------------------------------------------------------------------
// **** checking for collision, taking in two points and comparing **** //
-(BOOL)collisionOfFirstObject:(CGPoint)first second:(CGPoint)second{
    
    if((first.x <= second.x + 20) && (first.x >= second.x - 20) &&
       (first.y <= second.y + 20) && (first.y >= second.y - 20)){
        
        [newMainGuy moveGuyToPoint:ccp(50.0f, 50.0f)];
        
        NSLog(@"Location %@", NSStringFromCGPoint([newMainGuy returnLocation]));
        
        return true;
    }
    return false;
}






// -------------------------------------------------------------------------
// **** move the guy to a point on the screen **** //
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CGPoint touchPoint = [touch locationInNode:self];
    
    NSLog(@"%@", NSStringFromCGPoint(touchPoint));
    
    [newMainGuy moveGuyToPoint:touchPoint];
    
    // **** this basically sees if your touch over the enemy is true and if so **** //
    // **** play a sea sound **** //
    if([self collisionOfFirstObject:touchPoint second:[newEnemy returnLocationOfEnemy]] == true){
        
        // **** plays a sea sound **** //
        [water playBg:@"sea_audio.mp3" loop:false];
    }
}




@end
