//
//  LeaderBoard.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/19/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "LeaderBoard.h"
#import "MainMenuScene.h"
#import "AchievementsScene.h"
#import "IntroScene.h"
#import "Achievements.h"

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
        
        achievements = [Achievements sharedInstance];
        
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
        leaderBoardLabel.color = [CCColor redColor];
        leaderBoardLabel.position = ccp(layoutBoxSprite.position.x, layoutBoxSprite.contentSize.height - 40.0f);
        [layoutBoxSprite addChild:leaderBoardLabel z:2];
        
        
        
        // setting the leaderboard //
        [self persistantLeaderBoard];
        
        
        CCButton *backButton = [CCButton buttonWithTitle:@"Play again!" fontName:@"Chalkduster" fontSize:15.0f];
        backButton.anchorPoint = ccp(0.5f, 0.5f);
        backButton.position = ccp(layoutBoxSprite.position.x - (((layoutBoxSprite.contentSize.width / 2) / 2) + 5.0f), (layoutBoxSprite.contentSize.height - 220.0f));
        backButton.name = @"play";
        backButton.color = [CCColor redColor];
        [backButton setTarget:self selector:@selector(onBack:)];
        [layoutBoxSprite addChild:backButton];
        
        
        
        
        CCButton *deleteScoresButton = [CCButton buttonWithTitle:@"Delete Scores!" fontName:@"Chalkduster" fontSize:15.0f];
        deleteScoresButton.anchorPoint = ccp(0.5f, 0.5f);
        deleteScoresButton.position = ccp(layoutBoxSprite.position.x + (((layoutBoxSprite.contentSize.width / 2) /2) - 5.0f), (layoutBoxSprite.contentSize.height - 220.0f));
        deleteScoresButton.name = @"delete";
        deleteScoresButton.color = [CCColor redColor];
        [deleteScoresButton setTarget:self selector:@selector(onBack:)];
        [layoutBoxSprite addChild:deleteScoresButton];
        
        
        CCButton *menuButton = [CCButton buttonWithTitle:@"Main Menu!" fontName:@"Chalkduster" fontSize:15.0f];
        menuButton.anchorPoint = ccp(0.5f, 0.5f);
        menuButton.position = ccp(layoutBoxSprite.position.x, (layoutBoxSprite.contentSize.height) - 240.0f);
        menuButton.name = @"menu";
        menuButton.color = [CCColor redColor];
        [menuButton setTarget:self selector:@selector(onBack:)];
        [layoutBoxSprite addChild:menuButton];
        
        [self addChild:mainLayoutBox];
        
        
    }
    return self;
    
}

// ------------------------- > persistant data of leader board < --------------------------------- //
-(void)persistantLeaderBoard{
    
    
    // setting the local score array //
    NSMutableArray *localScoreArray = [[NSMutableArray alloc] init];
    NSMutableArray *finalSortedNumbers = [[NSMutableArray alloc] init];
    NSMutableArray *finalNameAndSCores = [[NSMutableArray alloc] init];
    nameArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *userDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDictionary"];
    
    for(NSNumber *score in [userDictionary allValues]){
        
        [localScoreArray addObject:score];
    }
    
    // comparing the elements in the array //
    NSArray *sortedNumbers = [localScoreArray sortedArrayUsingSelector:@selector(compare:)];
    
    // the sorted array is ascending so I reverse the array //
    for(int i = (int)sortedNumbers.count - 1; i >= 0; i--){
        
        [finalSortedNumbers addObject:sortedNumbers[i]];
    }

    
    
    
    
    // going through the dictionary and seing which value corresponds to the key //
    for(int j = 0; j < finalSortedNumbers.count; j++){
        
        // this holds all the names of the array //
        NSArray *tempNames = [userDictionary allKeysForObject:[finalSortedNumbers objectAtIndex:j]];
        
        // saving it all to an array for the leaderboard //
        [finalNameAndSCores addObject:[NSString stringWithFormat:@"%@ %@", [tempNames lastObject], finalSortedNumbers[j]]];
        
        [nameArray addObject:[tempNames lastObject]];
        
        
        if(finalNameAndSCores.count > 5){
            
            [finalNameAndSCores removeLastObject];
            [localScoreArray removeLastObject];
        }
         
    }
    
    
    

    
    // -----------------> making of the score labels <-------------------- //
    for(int i = 0; i < localScoreArray.count; i++){
        
        // putting the name and score into a string for use //
        // need to lign up the name and scores 
        NSString *tempNameAndScore = [[NSString alloc] initWithFormat:@"%@", finalNameAndSCores[i]];
        
        // creating a label //
        // need to convert this to buttons so that I can take the user to the corresponding //
        // achievement page //
        scoresButton = [CCButton buttonWithTitle:tempNameAndScore fontName:@"Chalkduster" fontSize:20.0f];
        scoresButton.anchorPoint = ccp(0.5f, 0.5f);
        scoresButton.position = ccp(layoutBoxSprite.position.x, (layoutBoxSprite.contentSize.height - 40.0f) - (30 * (i + 1)));
        scoresButton.name = [NSString stringWithFormat:@"%i", i];
        [scoresButton setTarget:self selector:@selector(onScoreButton:)];
        
        
        // the achievement sprite next to each name //
        CCSprite *arrowSprite = [CCSprite spriteWithImageNamed:@"Achievement_arrow.png"];
        arrowSprite.anchorPoint = ccp(0.5f, 0.5f);
        arrowSprite.scale = 0.7f;
        arrowSprite.position = ccp((layoutBoxSprite.contentSize.width) - 20.0f, scoresButton.position.y);
        [layoutBoxSprite addChild:arrowSprite z:5];
        
        
        
        
        
        
        [layoutBoxSprite addChild:scoresButton];
    }
}




// user clicks on the name to take them to the achievements section //
-(void)onScoreButton:(id)sender{
    
    CCButton *button = (CCButton *)sender;
    
    int indexOfButton = [button.name intValue];
    
    NSLog(@"index # %d", indexOfButton);
    

    // passing the name of the person you wish to see achievements on to the next scene //
    [[CCDirector sharedDirector] replaceScene:[AchievementsScene sceneWithName:[nameArray objectAtIndex:indexOfButton]]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
    
}



// going back to the main menu and deleting //
// the leader board //
-(void)onBack:(id)sender{
    
    CCButton *button = (CCButton *)sender;
    
    // play again button //
    if([button.name isEqualToString:@"play"]){
    
        [[CCDirector sharedDirector] replaceScene:[IntroScene sceneCameFromTutorial:NO]
                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
        
    // delete the leaderboard button //
    }else if([button.name isEqualToString:@"delete"]){
        
        [scoresLabel removeFromParentAndCleanup:true];
        
        [newScoreClass deleteTheScoreBoard];
        
        [achievements deleteAllAchievements];
        
        [self persistantLeaderBoard];
        
        [[CCDirector sharedDirector] replaceScene:[MainMenuScene scene]
                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
        
    // menu button //
    }else if([button.name isEqualToString:@"menu"]){
        
        [[CCDirector sharedDirector] replaceScene:[MainMenuScene scene]
                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
        
    }
    
}

@end
