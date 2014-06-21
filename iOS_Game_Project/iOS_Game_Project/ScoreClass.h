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
    
    NSMutableDictionary *nameAndScoreOfUser;
}


+(id)sharedInstance;
-(void)setHighScore:(int)score;
-(NSNumber *)returnhighScore;
-(int)getAmountOfPlayers;
-(void)setNameAndScoreOfUser:(NSString *)name andScore:(int)score;
-(NSDictionary *)returnDictionaryOfNameAndScores;
-(void)deleteTheScoreBoard;


@property (nonatomic)int amountOfScoresModify;
@property (nonatomic, strong)NSString *nameOfUser;


@end
