//
//  ScoreClass.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/18/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "ScoreClass.h"

@implementation ScoreClass
@synthesize highScoreModify, amountOfScoresModify;

+(id)sharedInstance{
    
    static ScoreClass *scoreClass;
    if(scoreClass == nil){
        scoreClass = [[self alloc] init];
    }
    return scoreClass;
}


-(id)init{
    
    if(self = [super init]){
        
        highScore = 0;
        amountOfScores = 6;
        
        amountOfScoresModify = amountOfScores;
        highScore = highScoreModify;
        
    }
    return self;
}

@end
