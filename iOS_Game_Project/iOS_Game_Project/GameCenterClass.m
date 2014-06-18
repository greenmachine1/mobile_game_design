//
//  GameCenterClass.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/17/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "GameCenterClass.h"
#import <GameKit/GameKit.h>

@implementation GameCenterClass
@synthesize isAuthorized, _localPlayer;

+(id)sharedGameCenter{
    
    static GameCenterClass *gameCenterClass = nil;
    if(gameCenterClass == nil){
        gameCenterClass = [[self alloc] init];
    }
    return gameCenterClass;
}

-(id)init{
    
    if(self = [super init]){
        
        isAuthorized = NO;
        
        localPlayer = [GKLocalPlayer localPlayer];
        
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
            
            if(localPlayer.isAuthenticated){
                
                _localPlayer = localPlayer;
                isAuthorized = YES;
                
                NSString *nameString = [[NSString alloc] initWithFormat:@"%@", localPlayer.playerID];
                
                NSLog(@"Logged in as %@", nameString);
                
            }else{
                
                isAuthorized = NO;
            }
        }];
    }
    return self;
}








@end
