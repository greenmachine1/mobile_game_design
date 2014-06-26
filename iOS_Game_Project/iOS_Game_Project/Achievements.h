//
//  Achievements.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/23/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Achievements : NSObject{
    
    NSString *userName;
    NSMutableDictionary *userAchievementsDictionary;
    NSMutableArray *arrayOfAchievements;
    
    NSNumber *numberOfGamesPlayed;
    NSNumber *numberOfHearts;
    
}
+(Achievements *)sharedInstance;
-(void)setNameOfCurrentUser:(NSString *)passedInName;

-(NSString *)finishingLevelWithinTime:(int)time;
-(NSString *)finishedLevelWithinTime:(int)time andKilledNinjaSquid:(int)trueOrFalse;
-(NSNumber *)returnAmountOfPlayedGames;

-(NSString *)finishedAfter_3_GamesAndStillHaveAllHeartsLeft;
-(NSString *)completionPerfect:(int)allHeartsStillIntact andKillingOfNinjaSquid:(int)trueOrFalse;

-(NSString *)awardPlayerForDeath:(int)heartsLeft;

-(void)incrementGamePlayed;
-(void)incrementHeartsAvailable;

-(NSArray *)returnAllAchievements;
-(void)deleteAllAchievements;

@end
