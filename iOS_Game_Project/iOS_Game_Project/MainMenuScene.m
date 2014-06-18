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
#import "GameCenterClass.h"
#import <GameKit/GameKit.h>



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
        
        // same image used for the pause menu //
        CCSprite *menuBoxSprite = [CCSprite spriteWithImageNamed:@"menu_box_pause.png"];
 
        layoutBox.anchorPoint = ccp(0.5f, 0.5f);
        layoutBox.direction = CCLayoutBoxDirectionVertical;
        
        
        
        // creation of the buttons
        CCButton *playGameButton = [CCButton buttonWithTitle:@"Play Game!" fontName:@"Papyrus" fontSize:25.0f];
        [playGameButton setTarget:self selector:@selector(playGame)];
        playGameButton.position = ccp(menuBoxSprite.contentSize.width / 2, (menuBoxSprite.contentSize.height / 2) + 50.0f);
        
        CCButton *gamePlayTutorialButton = [CCButton buttonWithTitle:@"Game Play Tutorial!" fontName:@"Papyrus" fontSize:25.0f];
        [gamePlayTutorialButton setTarget:self selector:@selector(gamePlayTutorial)];
        gamePlayTutorialButton.position = ccp(menuBoxSprite.contentSize.width / 2, menuBoxSprite.contentSize.height / 2);
        
        CCButton *creditsButton = [CCButton buttonWithTitle:@"Credits!" fontName:@"Papyrus" fontSize:25.0f];
        [creditsButton setTarget:self selector:@selector(gameCredits)];
        creditsButton.position = ccp(menuBoxSprite.contentSize.width / 2, (menuBoxSprite.contentSize.height / 2) - 50.0f);
        
        CCButton *gameCenterButton = [CCButton buttonWithTitle:@"Game Center" fontName:@"Papyrus" fontSize:25.0f];
        [gameCenterButton setTarget:self selector:@selector(gameCenter)];
        gameCenterButton.position = ccp(menuBoxSprite.contentSize.width / 2,(menuBoxSprite.contentSize.height / 2) - 90.0f);
        
        
        
        
        // adding the buttons as children to the box sprite //
        [menuBoxSprite addChild:gameCenterButton];
        [menuBoxSprite addChild:creditsButton];
        [menuBoxSprite addChild:gamePlayTutorialButton];
        [menuBoxSprite addChild:playGameButton];
        
        
        // adding the box sprite to the layout //
        [layoutBox addChild:menuBoxSprite];
        layoutBox.position = ccp(xBounds / 2, yBounds / 2);
        
        // then finally adding the layout to the scene //
        [self addChild:layoutBox];
        
        
    }
    
    return self;
    
}


// transition to the gameplay scene //
-(void)playGame{
    
    [[CCDirector sharedDirector] replaceScene:[IntroScene sceneCameFromTutorial:NO]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
    
}


// transition to the game play tutorial //
-(void)gamePlayTutorial{
    
    
    [[CCDirector sharedDirector] replaceScene:[IntroScene sceneCameFromTutorial:YES]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
    
}


// transition to the game credits //
-(void)gameCredits{
    
    [[CCDirector sharedDirector] replaceScene:[CreditsScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
    
}


// goes to the game center info //
-(void)gameCenter{

    newGameCenterClass = [GameCenterClass sharedGameCenter];
    newGameCenterView = [[GKGameCenterViewController alloc] init];
    
    // setting the delegate //
    newGameCenterView.gameCenterDelegate = self;
    
    // checking to see if im logged in on gameCenter //
    if(newGameCenterClass.isAuthorized == 1){
        
        // presenting the game center view //
        [[CCDirector sharedDirector] presentModalViewController:newGameCenterView animated:true];
        
    }
}


// dismisses the game center view controller //
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController{
    
    [[CCDirector sharedDirector] dismissViewControllerAnimated:TRUE completion:nil];
    
}


@end
