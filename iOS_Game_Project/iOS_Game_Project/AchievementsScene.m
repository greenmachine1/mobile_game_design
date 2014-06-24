//
//  AchievementsScene.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/23/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "AchievementsScene.h"
#import "Achievements.h"
#import "cocos2d-ui.h"
#import "cocos2d.h"
#import "LeaderBoard.h"

@implementation AchievementsScene

+(AchievementsScene *)sceneWithName:(NSString *)name{
    
    return [[self alloc] initWithName:name];
}

-(id)initWithName:(NSString *)name{
    
    if(self = [super init]){
        
        xBounds = self.contentSize.width;
        yBounds = self.contentSize.height;
        
        personsName = name;
        NSLog(@"person -> %@",personsName);
        
        // setting the background color //
        CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.1 green:0.4 blue:0.5 alpha:1.0]];
        [self addChild:background];
        
        [self createLayout];
        
    }
    return self;
}


-(void)createLayout{
    
    mainLayout = [[CCLayoutBox alloc] init];
    mainLayout.anchorPoint = ccp(0.5f, 0.5f);
    mainLayout.position = ccp(xBounds / 2, yBounds / 2);
    
    // main green background box //
    CCSprite *mainLayoutBox = [CCSprite spriteWithImageNamed:@"menu_box_pause.png"];
    mainLayoutBox.anchorPoint = ccp(0.5f, 0.5f);
    mainLayoutBox.position = ccp(mainLayout.position.x, mainLayout.position.y);
    
    [mainLayout addChild:mainLayoutBox];
    
    
    CCLabelTTF *mainLabel = [CCLabelTTF labelWithString:personsName fontName:@"Chalkduster" fontSize:20.0f];
    mainLabel.anchorPoint = ccp(0.5f, 0.5f);
    mainLabel.position = ccp(mainLayoutBox.position.x, (mainLayoutBox.contentSize.height / 2) + 100.0f);
    [mainLayoutBox addChild:mainLabel];
    
    
    
    
    
    
    
    
    
    // back button //
    CCButton *backButton = [CCButton buttonWithTitle:@"Back" fontName:@"Chalkduster" fontSize:20.0f];
    backButton.anchorPoint = ccp(0.5f, 0.5f);
    backButton.color = [CCColor redColor];
    backButton.position = ccp(mainLayoutBox.position.x, (mainLayoutBox.contentSize.height / 2) - 100.0f);
    [backButton setTarget:self selector:@selector(onBack)];
    [mainLayoutBox addChild:backButton];
    
    
    [self addChild:mainLayout z:2];
    
}


// going back to the leaderboard //
-(void)onBack{
    
    [[CCDirector sharedDirector] replaceScene:[LeaderBoard scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
    
}


@end
