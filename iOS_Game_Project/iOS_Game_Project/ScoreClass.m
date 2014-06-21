//
//  ScoreClass.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/18/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "ScoreClass.h"

@implementation ScoreClass
@synthesize amountOfScoresModify, nameOfUser;

+(id)sharedInstance{
    
    static ScoreClass *scoreClass;
    if(scoreClass == nil){
        scoreClass = [[self alloc] init];
    }
    return scoreClass;
}


-(id)init{
    
    if(self = [super init]){
        
        amountOfScores = 6;
        amountOfScoresModify = amountOfScores;
        nameOfUser = @"";
        nameAndScoreOfUser = [[NSMutableDictionary alloc] init];
        
        
        
    }
    return self;
}




-(void)setHighScore:(int)score{
    
    highScore = score;

    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:highScore] forKey:@"highScore"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}




-(NSNumber *)returnhighScore{
    
    return[[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"];
}



// setting the name and score of the user //
-(void)setNameAndScoreOfUser:(NSString *)name andScore:(int)score{
    
    // setting an entry //
    [nameAndScoreOfUser setObject:[NSNumber numberWithInt:score] forKey:name];
    [[NSUserDefaults standardUserDefaults] setObject:nameAndScoreOfUser forKey:@"userDictionary"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}


// returning the entire dictionary //
-(NSDictionary *)returnDictionaryOfNameAndScores{
    
    //return nameAndScoreOfUser;
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userDictionary"];
}



-(int)getAmountOfPlayers{
    
    return (int)nameAndScoreOfUser.count;
    
}








@end
