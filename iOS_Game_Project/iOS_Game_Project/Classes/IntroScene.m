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

#import "Block_Wall.h"

#import "Guy_Sprite_Object.h"

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
    // **** creation of the guy sprite **** //
    newGuySprite = [Guy_Sprite_Object createGuySpriteWithLocation:ccp(200.0f, 200.0f)];
    
    // **** adding the guy to the scene **** //
    [self addChild:newGuySprite];
    
    
    
// -----------------------------------------------------------------------
    // **** creation of the blocks ***** //
    [self creationOfBlocks];
    
    
    
// -----------------------------------------------------------------------
    // **** looking for the block wall **** //
    for(Block_Wall *blocks in self.children){
        
        if([blocks isKindOfClass:[Block_Wall class]]){
            NSLog(@"%@", NSStringFromCGPoint([blocks returnLocation]));
        }
    }
	return self;
}


// -----------------------------------------------------------------------
// **** creation of the blocks method **** //
-(void)creationOfBlocks{
    
    
    NSLog(@"x : %i and y: %i", xBounds, yBounds);
    // **** creation of the upper level blocks **** //
    for(int i = 1; i < xBounds / 64; i ++){
        
        Block_Wall *newBlockWallLayout = [Block_Wall createWallAtPosition:ccp(i * 64, 32.0f)];
        [self addChild:newBlockWallLayout];
    }
    
    
    // **** creation of the lower level blocks **** //
    for(int j = 1; j < xBounds / 64; j++){
        
        Block_Wall *newBlockWallLayout = [Block_Wall createWallAtPosition:ccp(j * 64, yBounds - 32)];
        [self addChild:newBlockWallLayout];
    }
    
}





// -----------------------------------------------------------------------
-(void)onEnter{
    [super onEnter];
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
}



// ------------------------------------------------------------------------
// **** update loop **** //
-(void)update:(CCTime)delta{
    
    
    
}

// -------------------------------------------------------------------------
// **** move the guy to a point on the screen **** //
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CGPoint touchPoint = [touch locationInNode:self];
    
    NSLog(@"%@", NSStringFromCGPoint(touchPoint));
    
    newGuySprite.position = touchPoint;
    
    // **** this basically sees if your touch over the enemy is true and if so **** //
    // **** play a sea sound **** //
    //if([self collisionOfFirstObject:touchPoint second:[newEnemy returnLocationOfEnemy]] == true){
        
        // **** plays a sea sound **** //
    //    [water playBg:@"sea_audio.mp3" loop:false];
    //}
}















@end
