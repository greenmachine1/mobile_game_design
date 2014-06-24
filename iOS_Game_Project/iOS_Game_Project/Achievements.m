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
    

}

-(void)settingAnAchievementForuser{
    
    // saving an achievement for the current user //
    [userAchievementsDictionary setObject:@"Yep" forKey:userName];
    
    // setting it to correspond with the achievements NSUserDefaults //
    [[NSUserDefaults standardUserDefaults] setObject:userAchievementsDictionary forKey:USERACHIEVE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}






@end
