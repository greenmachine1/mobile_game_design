//
//  Guy_Sprite_Object.m
//  iOS_Game_Project
//
//  Created by Cory Green on 5/12/14.
//  Copyright (c) 2014 Cory Green. All rights reserved.
//

#import "Guy_Sprite_Object.h"
#import "cocos2d.h"

@implementation Guy_Sprite_Object


//   creation of guy sprite   //
+(id)createGuySpriteWithLocation:(CGPoint)locationPoint{
    
    return [[self alloc] initWithLocation:locationPoint];
    
}

//   init with location
-(id)initWithLocation:(CGPoint)locationPoint{
    
    if(self = [super init]){
        
        self.position = locationPoint;
        
        guySprite = [CCSprite spriteWithImageNamed:@"guy_pixel_art.png"];
        
        
        
        [self addChild:guySprite];
    }
    return self;
    
}




//   returning the position   //
-(CGPoint)returnLocation{
    
    return self.position;
}



//   returns the bounding box around the sprite   //
-(CGRect)getBoundingBox{
    
    return CGRectMake(self.position.x - (guySprite.contentSize.width / 2),
                      self.position.y - (guySprite.contentSize.height / 2),
                      guySprite.contentSize.width,
                      guySprite.contentSize.height);
}



-(void)changeColor{
    
    // changes the guy to red //
    guySprite.color = [CCColor colorWithRed:1.0f green:0.0f blue:0.0f];
    
    [self performSelector:@selector(changeBackColor) withObject:self afterDelay:2.0f];
    
}



-(void)changeBackColor{
    
    // changes the guy back to normal //
    guySprite.color = [CCColor colorWithRed:1.0f green:1.0f blue:1.0f];
    
}


@end
