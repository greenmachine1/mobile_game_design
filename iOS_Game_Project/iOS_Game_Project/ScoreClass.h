//
//  ScoreClass.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/18/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreClass : NSObject{
    
    int highScore;
    int amountOfScores;
}


+(id)sharedInstance;

@property (nonatomic)int highScoreModify;
@property (nonatomic)int amountOfScoresModify;

@end
