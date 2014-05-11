//
//  IntroScene.h
//  iOS_Game_Project
//
//  Created by Cory Green on 5/5/14.
//  Copyright Cory Green 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using cocos2d-v3
#import "cocos2d.h"

#import "cocos2d-ui.h"

#import "Enemy_Sprite_Object.h"

#import "Block_sprite_Object.h"

#import "Main_Guy_Object.h"

// -----------------------------------------------------------------------

/**
 *  The intro scene
 *  Note, that scenes should now be based on CCScene, and not CCLayer, as previous versions
 *  Main usage for CCLayer now, is to make colored backgrounds (rectangles)
 *
 */
@interface IntroScene : CCScene{
    
    Main_Guy_Object *newMainGuy;
    Enemy_Sprite_Object *newEnemy;
    Block_sprite_Object *secondObject;
    
    OALSimpleAudio *hammer;
    OALSimpleAudio *water;
    
    int xBounds;
    int yBounds;
    
    CGPoint pointOfEnemy;
    CGPoint pointOfSecondObject;
    
}

// -----------------------------------------------------------------------

+ (IntroScene *)scene;
- (id)init;

// -----------------------------------------------------------------------
@end