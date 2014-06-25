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
        
        userAchievementsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:USERACHIEVE]];
        
        
        
    }
    return self;
    
}



-(void)setNameOfCurrentUser:(NSString *)passedInName{
    
    userName = passedInName;
    
    NSLog(@"Current user Passed in %@", userName);
    
    arrayOfAchievements = [[NSMutableArray alloc] initWithArray:[userAchievementsDictionary objectForKey:[NSString stringWithFormat:@"%@_achieve",userName ]]];
    
    NSLog(@"array -> %@", arrayOfAchievements);

}



// finished the level in a certain amount of time //
-(void)finishingLevelWithinTime:(int)time{
    
    if((time <= 30) && (time > 20)){
        
        [self saveInfo:@"Achievement:30 seconds!"];
        
    }else if((time <= 20) && (time > 10)){
        
        [self saveInfo:@"Achievement:20 seconds!"];
        
    }else if((time <= 10) && (time > 0)){
        
        [self saveInfo:@"Achievement:10 seconds!"];
        
    }
}




// finished the level in a certain amount of time and killed the ninja squid //
-(void)finishedLevelWithinTime:(int)time andKilledNinjaSquid:(int)trueOrFalse{
    
    if(((time <= 30) && (time > 20)) && (trueOrFalse == 1)){
        
        [self saveInfo:@"Achievement:30 seconds and Ninja Squid Death!"];
        
    }else if (((time <= 20) && (time > 10)) && (trueOrFalse == 1)){
        
        [self saveInfo:@"Achievement:20 seconds and Ninja Squid Death!"];
        
    }else if (((time <= 100) && (time > 0)) && (trueOrFalse == 1)){
        
        [self saveInfo:@"Achievement:10 seconds and Ninja Squid Death!"];
        
    }
    
    
    
}




// saving the info for the current user //
-(void)saveInfo:(NSString *)passedInStringToSave{
    
    [arrayOfAchievements addObject:passedInStringToSave];
    
    
    NSCountedSet *set = [[NSCountedSet alloc] initWithArray:arrayOfAchievements];
    
    for(id item in set){
        
        NSLog(@"name %@ count %lu", item, (unsigned long)[set countForObject:item]);
        
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
    
}


-(NSArray *)returnAllAchievements{
    
    return arrayOfAchievements;
    
}






@end
