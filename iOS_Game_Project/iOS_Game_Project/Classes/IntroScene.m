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
    
	return self;
}




-(void)onEnter{
    [super onEnter];
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
}




// **** update loop **** //
-(void)update:(CCTime)delta{
    
    
    
}















@end
