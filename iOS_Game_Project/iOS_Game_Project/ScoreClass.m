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
        

        
    }
    return self;
}








@end
