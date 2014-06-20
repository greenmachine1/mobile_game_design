//
//  ScoreClass.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/18/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "ScoreClass.h"

@implementation ScoreClass
@synthesize amountOfScoresModify;

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
        
        NSLog(@"high score inside class %i", highScore);
        
        //[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:highScore] forKey:@"highScore"];
        
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








@end
