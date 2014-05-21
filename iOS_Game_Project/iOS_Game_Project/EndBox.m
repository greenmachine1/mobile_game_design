//
//  EndBox.m
//  iOS_Game_Project
//
//  Created by Cory Green on 5/14/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "EndBox.h"

#import "cocos2d.h"

@implementation EndBox


+(id)createEndBoxWithLocation:(CGPoint)location{
    
    return [[self alloc] initWithLocation:location];
    
    
    
    
}

-(id)initWithLocation:(CGPoint)location{
    
    
    if(self = [super init]){
        
        self.position = location;
        
        endBoxSprite = [CCSprite spriteWithImageNamed:@"Goal.png"];
        
        [self addChild:endBoxSprite];
        
    }
    return self;
    
}

// **** returns the bounding box around the sprite **** //
-(CGRect)getBoundingBox{
    
    return CGRectMake(self.position.x - (endBoxSprite.contentSize.width / 2),
                      self.position.y - (endBoxSprite.contentSize.height / 2),
                      endBoxSprite.contentSize.width,
                      endBoxSprite.contentSize.height);
}


@end
