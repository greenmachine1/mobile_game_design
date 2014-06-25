//
//  Achievements.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/23/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "Achievements.h"

@implementation Achievements

// creating a constant name place //
static NSString *USERACHIEVE = @"userAchievements";


+(Achievements *)sharedInstance{
    
    static Achievements *achievements;
    if(achievements == nil){
        achievements = [[self alloc] init];
    }
    return achievements;
}



-(id)init{
    
    if(self = [super init]){
        
        userName = [[NSString alloc] init];
        
        numberOfHearts = 0;
        
        // setting the exsisting Dictionary to hold the stored dictionary for the user //
        userAchievementsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:USERACHIEVE]];
        
        NSLog(@"Whats in here! %@", userAchievementsDictionary);
        
        
        
    }
    return self;
    
}



-(void)setNameOfCurrentUser:(NSString *)passedInName{
    
    userName = passedInName;
    
    NSLog(@"Current user Passed in %@", userName);
    
    // loading the array with existing data for this user //
    arrayOfAchievements = [[NSMutableArray alloc] initWithArray:[userAchievementsDictionary objectForKey:[NSString stringWithFormat:@"%@_achieve",userName ]]];
    
    // loading the number with existing data for this user //
    numberOfGamesPlayed = [userAchievementsDictionary objectForKey:[NSString stringWithFormat:@"%@_numberOfGames", userName]];
    
    // loading the number with existing data for this user //
    numberOfHearts = [userAchievementsDictionary objectForKey:[NSString stringWithFormat:@"%@_numberOfHearts", userName]];
    
    
    NSLog(@"array -> %@", arrayOfAchievements);
    NSLog(@"int value ->%i", [numberOfGamesPlayed intValue]);
    
}


// finished the level in a certain amount of time //
-(NSString *)finishingLevelWithinTime:(int)time{
    
        if((time <= 30) && (time > 20)){
            
            [self saveInfo:@"Achievement:30 seconds!"];
                
            return @"Achievement:30 seconds!";
            
        }else if((time <= 20) && (time > 10)){
            
            [self saveInfo:@"Achievement:20 seconds!"];
                
            return @"Achievement:20 seconds!";
                
            
        }else if((time <= 10) && (time > 0)){
            
            [self saveInfo:@"Achievement:10 seconds!"];
                
            return @"Achievement:10 seconds!";
                
                
         }
    
    return @"";
}



// achievement for making it through 3 games with all hearts left //
-(NSString *)finishedAfter_3_GamesAndStillHaveAllHeartsLeft{
    
    NSLog(@"games played %@ and hearts left %@", numberOfGamesPlayed, numberOfHearts);
    
    // making sure that every 3 games is checked
    if(([numberOfGamesPlayed intValue] % 3 == 0) && ([numberOfHearts intValue] % 3 == 0)){
    
        [self saveInfo:@"Achievement:After 3 levels and all lives left!"];
    
        return @"Achievement:After 3 levels and all lives left!";
    }
    return @"";
    
}







// finished the level in a certain amount of time and killed the ninja squid //
-(NSString *)finishedLevelWithinTime:(int)time andKilledNinjaSquid:(int)trueOrFalse{
    
    if(((time <= 30) && (time > 20)) && (trueOrFalse == 1)){
        
        [self saveInfo:@"Achievement:30 seconds and Ninja Squid Death!"];
        
        return @"Achievement:30 seconds and Ninja Squid Death!";
        
    }else if (((time <= 20) && (time > 10)) && (trueOrFalse == 1)){
        
        [self saveInfo:@"Achievement:20 seconds and Ninja Squid Death!"];
        
        return @"Achievement:30 seconds and Ninja Squid Death!";
        
    }else if (((time <= 100) && (time > 0)) && (trueOrFalse == 1)){
        
        [self saveInfo:@"Achievement:10 seconds and Ninja Squid Death!"];
        
        return @"Achievement:30 seconds and Ninja Squid Death!";
        
    }
    
    return @"";
}


-(void)incrementGamePlayed{
    
    numberOfGamesPlayed = [NSNumber numberWithInt:[numberOfGamesPlayed intValue] + 1];
    
    NSLog(@"increment of games %@", numberOfGamesPlayed);
    
    [userAchievementsDictionary setObject:numberOfGamesPlayed forKey:[NSString stringWithFormat:@"%@_numberOfGames",userName ]];
    
    // setting it to correspond with the achievements NSUserDefaults //
    [[NSUserDefaults standardUserDefaults] setObject:userAchievementsDictionary forKey:USERACHIEVE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}



-(void)incrementHeartsAvailable{
    
    // incrementing the hearts
    numberOfHearts = [NSNumber numberWithInt:[numberOfHearts intValue] + 1];
    
    NSLog(@"increment of hearts %@", numberOfHearts);
    
    [userAchievementsDictionary setObject:numberOfHearts forKey:[NSString stringWithFormat:@"%@_numberOfHearts", userName]];
    
    // setting it to correspond with the achievements NSUserDefaults //
    [[NSUserDefaults standardUserDefaults] setObject:userAchievementsDictionary forKey:USERACHIEVE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}




// saving the info for the current user //
-(void)saveInfo:(NSString *)passedInStringToSave{
    
    [arrayOfAchievements addObject:passedInStringToSave];
    
    
    // finding out if more than one of the same achievement exsist //
    NSCountedSet *set = [[NSCountedSet alloc] initWithArray:arrayOfAchievements];
    
    for(id item in set){
        
        if([set countForObject:item] > 1){
            
            [arrayOfAchievements removeObject:item];
            [arrayOfAchievements addObject:item];
        }
    }
    
    
    NSLog(@"remaining array ->%@", arrayOfAchievements);
    
    // saving an achievement for the current user //
    [userAchievementsDictionary setObject:arrayOfAchievements forKey:[NSString stringWithFormat:@"%@_achieve",userName ]];
    
    // setting it to correspond with the achievements NSUserDefaults //
    [[NSUserDefaults standardUserDefaults] setObject:userAchievementsDictionary forKey:USERACHIEVE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}

-(void)deleteAllAchievements{
    
    [userAchievementsDictionary removeAllObjects];
    [[NSUserDefaults standardUserDefaults] setObject:userAchievementsDictionary forKey:USERACHIEVE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    numberOfGamesPlayed = [NSNumber numberWithInt:0];
    [userAchievementsDictionary setObject:numberOfGamesPlayed forKey:[NSString stringWithFormat:@"%@_numberOfGames",userName ]];
    // setting it to correspond with the achievements NSUserDefaults //
    [[NSUserDefaults standardUserDefaults] setObject:userAchievementsDictionary forKey:USERACHIEVE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    numberOfHearts = [NSNumber numberWithInt:0];
    [userAchievementsDictionary setObject:numberOfGamesPlayed forKey:[NSString stringWithFormat:@"%@_numberOfHearts",userName ]];
    // setting it to correspond with the achievements NSUserDefaults //
    [[NSUserDefaults standardUserDefaults] setObject:userAchievementsDictionary forKey:USERACHIEVE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}


-(NSArray *)returnAllAchievements{
    
    return arrayOfAchievements;
    
}

-(NSNumber *)returnAmountOfPlayedGames{

    return numberOfGamesPlayed;
}






@end
