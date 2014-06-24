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
    
}
+(Achievements *)sharedInstance;
-(void)setNameOfCurrentUser:(NSString *)passedInName;
-(void)finishingLevelWithinTime:(int)time;
-(NSArray *)returnAllAchievements;
-(void)deleteAllAchievements;


@end
