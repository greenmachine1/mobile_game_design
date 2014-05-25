//
//  SplashScreen.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 5/24/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "SplashScreen.h"
#import "cocos2d.h"
#import "IntroScene.h"

@implementation SplashScreen

// creation of the splash screen //
+(SplashScreen *)scene{
    
    return [[self alloc] init];
    
}

-(id)init{
    
    if(self = [super init]){
        
        int xBounds = self.contentSize.width;
        int yBounds = self.contentSize.height;
        
        mainSplashScreen = [CCSprite spriteWithImageNamed:@"Intro_graphic.png"];
        
        mainSplashScreen.scale = 0.5f;
        
        mainSplashScreen.position = ccp(xBounds / 2, yBounds / 2);
        
        [self addChild:mainSplashScreen];
        
        
        // switches scenes after 5 seconds of displaying the splash screen //
        [self performSelector:@selector(switchScreen) withObject:self afterDelay:5.0f];
        
    }
    return  self;
    
}


-(void)switchScreen{
    
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
    
}


@end
