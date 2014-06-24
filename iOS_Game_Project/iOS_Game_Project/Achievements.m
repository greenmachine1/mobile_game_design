//
//  Achievements.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/23/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "Achievements.h"

@implementation Achievements


// creation of a singleton Achievements //
+(id)sharedInstance{
    
    static Achievements *achievments;
    if(achievments == nil){
        
        achievments = [[self alloc] init];
        
    }
    return achievments;
}


-(id)init{
    
    if(self = [super init]){
        
        
    }
    return self;
    
}


// time achievement //
-(NSString *)beatTheLevelInUnder_30_Seconds:(int)time{
    
    if((time <= 30) && (time > 20)){
        
        return @"Under 30 Seconds!";
    }else if((time <= 30) && (time > 10)){
        
        return @"Under 20 Seconds!";
    }else if((time <= 10) && (time > 0)){
        
        return @"Under 10 seconds!";
    }
    
    return @"Nope!";
}


// an achievement for killing the ninja squid //
-(NSString *)killingTheNinjaSquidAchievement:(BOOL)trueOrFalse{
    
    if(trueOrFalse){
        return @"You killed the Ninja Squid!";
    }else{
        return @"";
    }
}


-(NSString *)killingTheNinjaSquidUnderACertainTime:(int)time killTheSquid:(BOOL)trueOrFalse{
    
    if(trueOrFalse){
        
        if((time <= 30) && (time > 20)){
            
            return @"Under 30 Seconds and you killed the Ninja Squid!";
        }else if((time <= 30) && (time > 10)){
            
            return @"Under 20 Seconds and you killed the Ninja Squid!";
        }else if((time <= 10) && (time > 0)){
            
            return @"Under 10 seconds and you killed the Ninja Squid!";
        }
    }
    
    return @"";

}






@end
