//
//  ScoreClass.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/18/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreClass : NSObject{
    
    NSUserDefaults *userDefaults;
    NSMutableDictionary *initialScoreDictionary;
    NSMutableDictionary *returnDictionary;
    
}


+(id)sharedInstance;
-(void)inputNewScore:(NSString *)name score:(int)score;
-(NSDictionary *)returnPlayerNameAndScores;
@end
