//
//  Main_Guy_Object.m
//  iOS_Game_Project
//
//  Created by Cory Green on 5/11/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "Main_Guy_Object.h"

#import "cocos2d.h"

@implementation Main_Guy_Object


// **** class method for initializing the guy **** //
+(id)createGuyAtLocation:(CGPoint)location{
    
    return [[self alloc] initWithLocation:location];
    
}


// **** initialize the guy **** //
-(id)initWithLocation:(CGPoint)location{
    
    if(self = [super init]){
        
        locationPoint = location;
        
        mainGuySprite = [CCSprite spriteWithImageNamed:@"guy_pixel_art.png"];
        
        mainGuySprite.position = location;
        
        [self addChild:mainGuySprite];
        
    }
    return self;
}


-(void)moveGuyToPoint:(CGPoint)pointToMoveToo{
    
    CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:1.0f position:pointToMoveToo];
    
    [mainGuySprite runAction:actionMove];
    
}

// **** return its current location **** //
-(CGPoint)returnLocation{
    
    return mainGuySprite.position;
}

@end
