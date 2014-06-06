//
//  DPad.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/5/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "DPad.h"

@implementation DPad

+(id)createDPadAtLocation:(CGPoint)location{
    
    return [[self alloc] initWithLocation:location];
}

-(id)initWithLocation:(CGPoint)location{
    
    if(self = [super init]){
        
        directionString = @"stopped";
        
        
        CCLayoutBox *newLayoutBox = [[CCLayoutBox alloc] init];
        newLayoutBox.position = location;
        newLayoutBox.anchorPoint = ccp(0.5f, 0.5f);
        
        mainDirectionalCircle = [CCSprite spriteWithImageNamed:@"DpadBackground.png"];
        mainDirectionalCircle.anchorPoint = ccp(0.5f, 0.5f);
        mainDirectionalCircle.position = ccp(newLayoutBox.contentSize.width / 2, newLayoutBox.contentSize.height / 2);
        
        [newLayoutBox addChild:mainDirectionalCircle];
        
        
        
        directionPad = [CCSpriteFrame frameWithImageNamed:@"ThumbPoint.png"];
        
        
        upButton = [CCButton buttonWithTitle:@"" spriteFrame:directionPad];
        upButton.scaleX = 1.4f;
        upButton.scaleY = 1.4f;
        upButton.name = @"up";
        upButton.position = ccp(mainDirectionalCircle.position.x, mainDirectionalCircle.position.y + 50);
        [mainDirectionalCircle addChild:upButton];
        
        leftButton = [CCButton buttonWithTitle:@"" spriteFrame:directionPad];
        leftButton.scaleX = 1.4f;
        leftButton.scaleY = 1.4f;
        leftButton.name = @"left";
        leftButton.position = ccp(mainDirectionalCircle.position.x - 50, mainDirectionalCircle.position.y);
        [mainDirectionalCircle addChild:leftButton];
        
        rightButton = [CCButton buttonWithTitle:@"" spriteFrame:directionPad];
        rightButton.scaleX = 1.4f;
        rightButton.scaleY = 1.4f;
        rightButton.name = @"right";
        rightButton.position = ccp(mainDirectionalCircle.position.x + 50, mainDirectionalCircle.position.y);
        [mainDirectionalCircle addChild:rightButton];
        
        downButton = [CCButton buttonWithTitle:@"" spriteFrame:directionPad];
        downButton.scaleX = 1.4f;
        downButton.scaleY = 1.4f;
        downButton.name = @"down";
        downButton.position = ccp(mainDirectionalCircle.position.x, mainDirectionalCircle.position.y - 50);
        [mainDirectionalCircle addChild:downButton];
        
        
        
        [self addChild:newLayoutBox z:3];
        
    }
    return self;
}


-(NSString *)direction{
    
    if(upButton.highlighted == true){
        
        return @"up";
        
    }else if(downButton.highlighted == true){
        
        return @"down";
        
    }else if(leftButton.highlighted == true){
        
        return @"left";
        
    }else if(rightButton.highlighted == true){
        
        return @"right";
        
    }
    
    else if(!((upButton.highlighted) || (downButton.highlighted) || (leftButton.highlighted) || (rightButton.highlighted))){
        
        return @"stopped";
        
    }
    
    
    return @"stopped";
   
    
    
}



@end
