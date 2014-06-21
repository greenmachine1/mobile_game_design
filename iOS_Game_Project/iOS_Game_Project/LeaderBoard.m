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
        
        nameArray = [[NSMutableArray alloc] init];
        
        // setting the background color //
        CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.1 green:0.4 blue:0.5 alpha:1.0]];
        [self addChild:background];
        
        // main layout //
        mainLayoutBox = [[CCLayoutBox alloc] init];
        mainLayoutBox.anchorPoint = ccp(0.5f, 0.5f);
        mainLayoutBox.direction = CCLayoutBoxDirectionVertical;
        mainLayoutBox.position = ccp(xBounds / 2, yBounds / 2);
        
        layoutBoxSprite = [CCSprite spriteWithImageNamed:@"menu_box_pause.png"];
        layoutBoxSprite.anchorPoint = ccp(0.5f, 0.5f);
        
        [mainLayoutBox addChild:layoutBoxSprite];
        
        
        // leader board label //
        CCLabelTTF *leaderBoardLabel = [CCLabelTTF labelWithString:@"High Scores" fontName:@"Chalkduster" fontSize:20.0f];
        leaderBoardLabel.anchorPoint = ccp(0.5f, 0.5f);
        leaderBoardLabel.position = ccp(layoutBoxSprite.position.x, layoutBoxSprite.contentSize.height - 40.0f);
        [layoutBoxSprite addChild:leaderBoardLabel z:2];
        
        
        
        // setting the leaderboard //
        [self persistantLeaderBoard];
        
        
        
        CCButton *backButton = [CCButton buttonWithTitle:@"Done!" fontName:@"Chalkduster" fontSize:15.0f];
        backButton.anchorPoint = ccp(0.5f, 0.5f);
        backButton.position = ccp(layoutBoxSprite.position.x - ((layoutBoxSprite.contentSize.width / 2) / 2), (layoutBoxSprite.contentSize.height - 225.0f));
        backButton.name = @"back";
        backButton.color = [CCColor redColor];
        [backButton setTarget:self selector:@selector(onBack:)];
        [layoutBoxSprite addChild:backButton];
        
        
        CCButton *deleteScoresButton = [CCButton buttonWithTitle:@"Delete Scores!" fontName:@"Chalkduster" fontSize:15.0f];
        deleteScoresButton.anchorPoint = ccp(0.5f, 0.5f);
        deleteScoresButton.position = ccp(layoutBoxSprite.position.x + ((layoutBoxSprite.contentSize.width / 2) /2), (layoutBoxSprite.contentSize.height - 225.0f));
        deleteScoresButton.name = @"delete";
        deleteScoresButton.color = [CCColor redColor];
        [deleteScoresButton setTarget:self selector:@selector(onBack:)];
        [layoutBoxSprite addChild:deleteScoresButton];
        
        [self addChild:mainLayoutBox];
        
        
    }
    return self;
    
}


-(void)persistantLeaderBoard{
    
    
    // ------------------------- > persistant data of leader boar < --------------------------------- //
    // loading all the names into an array so I can access them on an //
    // integer basis //
    for(NSString *names in [[NSUserDefaults standardUserDefaults] objectForKey:@"userDictionary"]){
        
        [nameArray addObject:names];
        
    }
    
    // creating a list of scores //
    for(int i = 0; i < nameArray.count; i++){
        
        
        
        // putting the name and score into a string for use //
        NSString *tempNameAndScore = [[NSString alloc] initWithFormat:@"%@ %@", [nameArray objectAtIndex:i], [[[NSUserDefaults standardUserDefaults] objectForKey:@"userDictionary"] objectForKey:[nameArray objectAtIndex:i]]];
        
        
        // creating a label /
        scoresLabel = [CCLabelTTF labelWithString:tempNameAndScore fontName:@"Chalkduster" fontSize:20.0f];
        scoresLabel.anchorPoint = ccp(0.5f, 0.5f);
        scoresLabel.position = ccp(layoutBoxSprite.position.x, (layoutBoxSprite.contentSize.height - 40.0f) - (30 * (i + 1)));
        [layoutBoxSprite addChild:scoresLabel];
    }
    
    
    
}


// going back to the main menu and deleting //
// the leader board //
-(void)onBack:(id)sender{
    
    CCButton *button = (CCButton *)sender;
    
    if([button.name isEqualToString:@"back"]){
    
        [[CCDirector sharedDirector] replaceScene:[MainMenuScene scene]
                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
        
    }else if([button.name isEqualToString:@"delete"]){
        
        [scoresLabel removeFromParentAndCleanup:true];
        
        [nameArray removeAllObjects];
        [newScoreClass deleteTheScoreBoard];
        [self persistantLeaderBoard];
        
        [[CCDirector sharedDirector] replaceScene:[MainMenuScene scene]
                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
        
    }
    
}

@end
