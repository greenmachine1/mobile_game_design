//
//  CreditsScene.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 5/26/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CreditsScene.h"
#import "cocos2d-ui.h"
#import "cocos2d.h"
#import "MainMenuScene.h"

@implementation CreditsScene


+(CreditsScene *)scene{
    
    return [[self alloc] init];
    
    
}



-(id)init{
    
    
    if(self = [super init]){
        
        xBounds = self.contentSize.width;
        yBounds = self.contentSize.height;
        
        
        // setting the background color //
        CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.1 green:0.4 blue:0.5 alpha:1.0]];
        [self addChild:background];
    
        
        CCLabelTTF *libraryCreditLabel = [CCLabelTTF labelWithString:@"Built using Cocos2d Version 3.0." fontName:@"Chalkduster" fontSize:20.0f];
        libraryCreditLabel.position = ccp(xBounds / 2 , yBounds - 100.0f);
        libraryCreditLabel.anchorPoint = ccp(0.5f, 0.5f);
        [libraryCreditLabel verticalAlignment];
        
        
        
        CCLabelTTF *soundsLibraryCreditLabel = [CCLabelTTF labelWithString:@"Sounds heard from\n    Westar Music." fontName:@"Chalkduster" fontSize:20.0f];
        soundsLibraryCreditLabel.position = ccp(libraryCreditLabel.position.x, libraryCreditLabel.position.y - 50.0f);
        soundsLibraryCreditLabel.anchorPoint = ccp(0.5f, 0.5f);
        [soundsLibraryCreditLabel verticalAlignment];
        
        
        CCLabelTTF *artworkLibraryCreditLabel = [CCLabelTTF labelWithString:@"All artwork made by \n      Cory Green." fontName:@"Chalkduster" fontSize:20.0f];
        artworkLibraryCreditLabel.position = ccp(soundsLibraryCreditLabel.position.x, soundsLibraryCreditLabel.position.y - 70.0f);
        artworkLibraryCreditLabel.anchorPoint = ccp(0.5f, 0.5f);
        [artworkLibraryCreditLabel verticalAlignment];
        
        
        
        CCButton *backButton = [CCButton buttonWithTitle:@"Back" fontName:@"Chalkduster" fontSize:30.0f];
        backButton.position = ccp(xBounds / 2, 40.0f);
        backButton.anchorPoint = ccp(0.5f, 0.5f);
        [backButton setTarget:self selector:@selector(onBack)];
        
        [self addChild:backButton];
        [self addChild:artworkLibraryCreditLabel];
        [self addChild:libraryCreditLabel];
        [self addChild:soundsLibraryCreditLabel];
    
    }
    return self;
}


-(void)onBack{
    
    [[CCDirector sharedDirector] replaceScene:[MainMenuScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
}

@end
    