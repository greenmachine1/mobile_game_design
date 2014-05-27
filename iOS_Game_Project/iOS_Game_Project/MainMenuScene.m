//
//  MainMenuScene.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 5/25/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "MainMenuScene.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "IntroScene.h"
#import "CreditsScene.h"
#import "GamePlayTutorialScene.h"


@implementation MainMenuScene



// main menu scene //
+(MainMenuScene *)scene{
    
    return [[self alloc] init];
    
}

-(id)init{
    
    if(self = [super init]){
        
        xBounds = self.contentSize.width;
        yBounds = self.contentSize.height;
        
        
        // setting the background color //
        CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.1 green:0.4 blue:0.5 alpha:1.0]];
        [self addChild:background];
        
        
        // creating a layout box for the menu items to reside //
        layoutBox = [[CCLayoutBox alloc] init];
        
        
        
        // creating a sprite for the game menu items //
        CCSpriteFrame *playGameSpriteFrame = [CCSpriteFrame frameWithImageNamed:@"Block.png"];
        CCSpriteFrame *gameTutorialSpriteFrame = [CCSpriteFrame frameWithImageNamed:@"Block.png"];
        CCSpriteFrame *creditsSpriteFrame = [CCSpriteFrame frameWithImageNamed:@"Block.png"];
        
        
        // setting buttons //
        CCButton *playGameButton = [CCButton buttonWithTitle:@"Play Game!" spriteFrame:playGameSpriteFrame];
        
        
        
        CCButton *gamePlayTutorialButton = [CCButton buttonWithTitle:@"Game Tutorial!" spriteFrame:gameTutorialSpriteFrame];
        
        
        CCButton *creditsButton = [CCButton buttonWithTitle:@"Credits!" spriteFrame:creditsSpriteFrame];
        
        
        
        // setting the buttons actions
        [playGameButton setTarget:self selector:@selector(playGame)];
        [gamePlayTutorialButton setTarget:self selector:@selector(gamePlayTutorial)];
        [creditsButton setTarget:self selector:@selector(gameCredits)];
        

        
        // positioning and spacing of the layout box //
        layoutBox.position = ccp((xBounds / 2) - (playGameSpriteFrame.originalSize.width / 2), (yBounds / 2) - 150.0f);
        layoutBox.spacing = 10.0f;
        layoutBox.direction = CCLayoutBoxDirectionVertical;
        layoutBox.color = [CCColor greenColor];
        
        
        [layoutBox addChild:creditsButton];
        [layoutBox addChild:gamePlayTutorialButton];
        [layoutBox addChild:playGameButton];
        
        [self addChild:layoutBox];
        
        
    }
    
    return self;
    
}


// transition to the gameplay scene //
-(void)playGame{
    
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
    
}


// transition to the game play tutorial //
-(void)gamePlayTutorial{
    
    [[CCDirector sharedDirector] replaceScene:[GamePlayTutorialScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
    
    
}


// transition to the game credits //
-(void)gameCredits{
    
    [[CCDirector sharedDirector] replaceScene:[CreditsScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
    
}


@end
