//
//  Achievements.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/23/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Achievements : NSObject{
    
    
}

+(id)sharedInstance;
-(NSString *)beatTheLevelInUnder_30_Seconds:(int)time;


@end