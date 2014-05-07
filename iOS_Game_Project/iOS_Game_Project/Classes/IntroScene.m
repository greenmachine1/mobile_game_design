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
    
    xBounds = (self.contentSize.width);
    yBounds = (self.contentSize.height);

    
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
    
    // **** adding in the block sprite **** //
    blockSprite = [CCSprite spriteWithImageNamed:@"Block.png"];
    
    // **** setting its position **** //
    [blockSprite setPosition:ccp(100.0, 100.0)];
    
    // **** adding it to the scene **** //
    [self addChild:blockSprite];
    

	return self;
}

// **** updated every second **** //
-(void)update:(CCTime)delta{
    
    // **** moving the guy sprite **** //
    // **** this is also a form of collision detection **** //
    // **** making sure he doesnt go past the wall bounds **** //
    if(guySprite.position.x < (xBounds - 30)){
        guySprite.position = ccp(guySprite.position.x + 1, guySprite.position.y);
    }
}



@end
