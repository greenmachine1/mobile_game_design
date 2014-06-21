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
    
    NSString *nameOfUser;
}


+(id)sharedInstance;
-(void)setHighScore:(int)score;
-(NSNumber *)returnhighScore;


@property (nonatomic)int amountOfScoresModify;
@property (nonatomic, strong)NSString *nameOfUser;


@end
