//
//  GameCenterClass.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/17/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GameCenterClass : NSObject{
    
    GKLocalPlayer *localPlayer;
    
    BOOL isAuthorized;
}

+(id)sharedGameCenter;

@property (nonatomic, readonly)BOOL isAuthorized;
@property (nonatomic, readonly)GKLocalPlayer *_localPlayer;

@end
