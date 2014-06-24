//
//  Achievements.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/23/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "Achievements.h"

@implementation Achievements


-(id)init{
    
    if(self = [super init]){
        
        nameOfUser = [[NSString alloc] init];
        
    }
    return self;
}




-(void)changeName:(NSString *)name{
    
    nameOfUser = name;
    
    NSLog(@"Name passed in %@", nameOfUser);
    
    
}










@end
