//
//  DPad.h
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/5/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d-ui.h"
#import "cocos2d.h"

@interface DPad : CCNode
{
    CCSprite *mainDirectionalCircle;
    CCSpriteFrame *directionPad;
    
    CCButton *upButton;
    CCButton *downButton;
    CCButton *leftButton;
    CCButton *rightButton;
    
    NSString *directionString;
    
}
+(id)createDPadAtLocation:(CGPoint)location;
-(NSString *)direction;
-(void)enableDisableDPadInput:(BOOL)enableDisable;

@end
