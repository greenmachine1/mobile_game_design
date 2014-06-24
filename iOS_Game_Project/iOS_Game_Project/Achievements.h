//
//  Achievements.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/23/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Achievements : NSObject{
    
    int numberOfAchievements;
    NSString *personsName;
    
    NSMutableArray *arrayOfAchievements;
    
    NSMutableDictionary *arrayOfAchievementsDictionary;
    
}

+(id)sharedInstanceWithName:(NSString *)name;
-(NSString *)beatTheLevelInUnder_30_Seconds:(int)time;
-(NSMutableDictionary *)listOfAchievements:(NSString *)name;

@property (nonatomic)int numberOfAchievements;

@end
