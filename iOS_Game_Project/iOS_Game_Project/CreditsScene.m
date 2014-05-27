//
//  CreditsScene.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 5/26/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CreditsScene.h"
#import "cocos2d-ui.h"
#import "cocos2d.h"

@implementation CreditsScene


+(CreditsScene *)scene{
    
    return [[self alloc] init];
    
    
}



-(id)init{
    
    
    if(self = [super init]){
        
        xBounds = self.contentSize.width;
        yBounds = self.contentSize.height;
        
        
        // setting the background color //
        CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.1 green:0.4 blue:0.5 alpha:1.0]];
        [self addChild:background];
        
        
    }
    return self;
    
}
@end
