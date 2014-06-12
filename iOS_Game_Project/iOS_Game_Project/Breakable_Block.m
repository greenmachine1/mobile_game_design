//
//  Breakable_Block.m
//  iOS_Game_Project
//
//  Created by Greenmachine on 6/12/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "Breakable_Block.h"

@implementation Breakable_Block

+(id)createBlockAtLocation:(CGPoint)location{
    
    return [[self alloc] initWithLocation:location];
    
}



-(id)initWithLocation:(CGPoint)location{
    
    if(self = [super init]){
        
        breakableBlockSprite = [CCSprite spriteWithImageNamed:@"Breakable_block.png"];
        
        self.position = location;
        
        [self addChild:breakableBlockSprite];
        
        
    }
    return self;
    
}

//   returns the bounding box around the sprite   //
-(CGRect)getBoundingBox{
    
    return CGRectMake(self.position.x - (breakableBlockSprite.contentSize.width / 2),
                      self.position.y - (breakableBlockSprite.contentSize.height / 2),
                      breakableBlockSprite.contentSize.width,
                      breakableBlockSprite.contentSize.height);
}
@end
