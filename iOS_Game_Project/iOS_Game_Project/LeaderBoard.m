//
//  LeaderBoard.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/19/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "LeaderBoard.h"
#import "MainMenuScene.h"

@implementation LeaderBoard


+(LeaderBoard *)scene{
    
    return [[self alloc] init];
}

-(id)init{
    
    if(self = [super init]){
        
        xBounds = self.contentSize.width;
        yBounds = self.contentSize.height;
        
        newScoreClass = [ScoreClass sharedInstance];
        NSLog(@"%i", newScoreClass.amountOfScoresModify);
        
        // setting the background color //
        CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.1 green:0.4 blue:0.5 alpha:1.0]];
        [self addChild:background];
        
        // main layout //
        mainLayoutBox = [[CCLayoutBox alloc] init];
        mainLayoutBox.anchorPoint = ccp(0.5f, 0.5f);
        mainLayoutBox.direction = CCLayoutBoxDirectionVertical;
        mainLayoutBox.position = ccp(xBounds / 2, yBounds / 2);
        
        CCSprite *layoutBoxSprite = [CCSprite spriteWithImageNamed:@"menu_box_pause.png"];
        layoutBoxSprite.anchorPoint = ccp(0.5f, 0.5f);
        
        [mainLayoutBox addChild:layoutBoxSprite];
        
        
        // leader board label //
        CCLabelTTF *leaderBoardLabel = [CCLabelTTF labelWithString:@"High Scores" fontName:@"Chalkduster" fontSize:20.0f];
        leaderBoardLabel.anchorPoint = ccp(0.5f, 0.5f);
        leaderBoardLabel.position = ccp(layoutBoxSprite.position.x, layoutBoxSprite.contentSize.height - 40.0f);
        [layoutBoxSprite addChild:leaderBoardLabel z:2];
        
        
        
        // creating a list of scores //
        for(int i = 1; i < newScoreClass.amountOfScoresModify; i++){
            
            CCLabelTTF *scoresLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i Score", i] fontName:@"Chalkduster" fontSize:20.0f];
            scoresLabel.anchorPoint = ccp(0.5f, 0.5f);
            scoresLabel.position = ccp(layoutBoxSprite.position.x, (layoutBoxSprite.contentSize.height - 40.0f) - (30 * i));
            [layoutBoxSprite addChild:scoresLabel];
            
        }
        
        
        CCButton *backButton = [CCButton buttonWithTitle:@"Done!" fontName:@"Chalkduster" fontSize:30.0f];
        backButton.anchorPoint = ccp(0.5f, 0.5f);
        backButton.position = ccp(layoutBoxSprite.position.x, (layoutBoxSprite.contentSize.height - 225.0f));
        backButton.color = [CCColor redColor];
        [backButton setTarget:self selector:@selector(onBack)];
        [layoutBoxSprite addChild:backButton];
        
        
        [self addChild:mainLayoutBox];
        
        
    }
    return self;
    
}

// back to the main menu //
-(void)onBack{
    
    [[CCDirector sharedDirector] replaceScene:[MainMenuScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
    
}

@end
