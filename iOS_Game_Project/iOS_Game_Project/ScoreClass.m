//
//  ScoreClass.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/18/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "ScoreClass.h"

@implementation ScoreClass


+(id)sharedInstance{
    
    static ScoreClass *scoreClass;
    if(scoreClass == nil){
        scoreClass = [[self alloc] init];
    }
    return scoreClass;
}


-(id)init{
    
    if(self = [super init]){
        
        // setting up the user defaults //
        userDefaults = [NSUserDefaults standardUserDefaults];
        
        initialScoreDictionary = [[NSMutableDictionary alloc] init];
        
        returnDictionary = [[NSMutableDictionary alloc] init];
    
    }
    return self;
}


// need to be appending objects to the origiginal score dictionary //
-(void)inputNewScore:(NSString *)name score:(int)score{
    
    [initialScoreDictionary setObject:[NSNumber numberWithInt:score] forKey:name];
    
    [userDefaults setObject:returnDictionary forKey:@"userDic"];
    
        
}



// I want to return the main dictisonary in order of top to bottom scores //
-(NSDictionary *)returnPlayerNameAndScores{
    
    return [userDefaults objectForKey:@"userDic"];
    
}


@end
