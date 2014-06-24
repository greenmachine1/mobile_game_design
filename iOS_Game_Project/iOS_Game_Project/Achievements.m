//
//  Achievements.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/23/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "Achievements.h"

@implementation Achievements
@synthesize numberOfAchievements;

// creation of a singleton Achievements //
+(id)sharedInstanceWithName:(NSString *)name{
    
    static Achievements *achievments;
    if(achievments == nil){
        
        achievments = [[self alloc] initWithName:name];
        
    }
    return achievments;
}


-(id)initWithName:(NSString *)name{
    
    if(self = [super init]){
        
        personsName = name;
            
        NSLog(@"%@", personsName);
        
        // starting off the dictionary with the one that is saved //
        arrayOfAchievementsDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:personsName]];
        
        NSLog(@"array -> %@", arrayOfAchievementsDictionary);
        
    }
    return self;
}




// time achievement //
-(NSString *)beatTheLevelInUnder_30_Seconds:(int)time{
    
    if((time <= 30) && (time > 20)){
        
        [arrayOfAchievementsDictionary setObject:@"Beat level in under 30 seconds!" forKey:@"beat_under_30"];
        
        [self updateUserDefaults];
        
        return @"Under 30 Seconds!";
    }else if((time <= 30) && (time > 10)){
        
        [arrayOfAchievementsDictionary setObject:@"Beat level in under 20 seconds!" forKey:@"beat_under_20"];
        
        [self updateUserDefaults];
    
        return @"Under 20 Seconds!";
    }else if((time <= 10) && (time > 0)){
        
        [arrayOfAchievementsDictionary setObject:@"Beat level in under 10 seconds!" forKey:@"beat_under_10"];
        
        [self updateUserDefaults];
    
        return @"Under 10 seconds!";
    }
    
    
    
    
    
    return @"Nope!";
}




// an achievement for killing the ninja squid //
-(NSString *)killingTheNinjaSquidAchievement:(BOOL)trueOrFalse{
    
    if(trueOrFalse){
        
        [arrayOfAchievementsDictionary setObject:@"Killed the Ninja Squid!" forKey:@"ninja_squid_death"];
        
        [self updateUserDefaults];
    
        return @"You killed the Ninja Squid!";
        
    }else{
        
        return @"";
    }
    

}




-(NSString *)killingTheNinjaSquidUnderACertainTime:(int)time killTheSquid:(BOOL)trueOrFalse{
    
    if(trueOrFalse){
        
        if((time <= 30) && (time > 20)){
            
            [arrayOfAchievementsDictionary setObject:@"Beat level in under 30 seconds and killed the Ninja Squid!" forKey:@"ninja_squid_death_and_30_seconds"];
            
            [self updateUserDefaults];
            
            return @"Under 30 Seconds and you killed the Ninja Squid!";
        }else if((time <= 30) && (time > 10)){
            
            [arrayOfAchievementsDictionary setObject:@"Beat level in under 20 seconds and killed the Ninja Squid!" forKey:@"ninja_squid_death_and_20_seconds"];
            
            [self updateUserDefaults];
            
            return @"Under 20 Seconds and you killed the Ninja Squid!";
        }else if((time <= 10) && (time > 0)){
            
            [arrayOfAchievementsDictionary setObject:@"Beat level in under 10 seconds and killed the Ninja Squid!" forKey:@"ninja_squid_death_and_10_seconds"];
            
            [self updateUserDefaults];
            
            return @"Under 10 seconds and you killed the Ninja Squid!";
        }
    }
    
    return @"";
}


-(void)updateUserDefaults{
    
    [[NSUserDefaults standardUserDefaults] setObject:arrayOfAchievementsDictionary forKey:personsName];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}



// returns the list of achievements //
-(NSMutableDictionary *)listOfAchievements:(NSString *)name{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:name];
    
}






@end
