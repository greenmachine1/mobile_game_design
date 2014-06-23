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
        
        //nameArray = [[NSMutableArray alloc] init];
        
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

// ------------------------- > persistant data of leader board < --------------------------------- //
-(void)persistantLeaderBoard{
    
    
    // setting the local score array //
    NSMutableArray *localScoreArray = [[NSMutableArray alloc] init];
    NSMutableArray *finalSortedNumbers = [[NSMutableArray alloc] init];
    NSMutableArray *finalNameAndSCores = [[NSMutableArray alloc] init];
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
        
        NSArray *temp = [userDictionary allKeysForObject:[finalSortedNumbers objectAtIndex:j]];

        // saving it all to an array for the leaderboard //
        [finalNameAndSCores addObject:[NSString stringWithFormat:@"%@ %@", [temp lastObject], finalSortedNumbers[j]]];
    }
    

    
    // -----------------> making of the score labels <-------------------- //
    for(int i = 0; i < localScoreArray.count; i++){
        
        // putting the name and score into a string for use //
        // need to lign up the name and scores 
        NSString *tempNameAndScore = [[NSString alloc] initWithFormat:@"%@", finalNameAndSCores[i]];
        
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
        
        //[nameArray removeAllObjects];
        
        [newScoreClass deleteTheScoreBoard];
        [self persistantLeaderBoard];
        
        [[CCDirector sharedDirector] replaceScene:[MainMenuScene scene]
                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
        
    }
    
}

@end
