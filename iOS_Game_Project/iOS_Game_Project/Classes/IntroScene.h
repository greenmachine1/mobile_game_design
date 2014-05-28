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
#import "Guy_Sprite_Object.h"
#import "Enemy_Sprite_Object.h"
#import "EndBox.h"








/**
 *  The intro scene
 *  Note, that scenes should now be based on CCScene, and not CCLayer, as previous versions
 *  Main usage for CCLayer now, is to make colored backgrounds (rectangles)
 *
 */
@interface IntroScene : CCScene{
    
    OALSimpleAudio *playSound;
    
    int xBounds;
    int yBounds;
    
    int speed;
    int score;
    
    float xDistance;
    float yDistance;
    
    CGPoint touchPoint;
    
    Guy_Sprite_Object *newGuySprite;
    Enemy_Sprite_Object *newEnemySprite;
    EndBox *newEndBox;
    
    CCLayoutBox *goalBox;
    
    // pause elements //
    CCNodeColor *backgroundColorOnPause;
    CCButton *pauseButton;
    CCLayoutBox *pauseLayoutBox;
    
    BOOL tutorialMode;
    
}



+(IntroScene *)sceneCameFromTutorial:(BOOL)yesOrNo;


- (id)initWithTutorialYesOrNo:(BOOL)yesOrNo;

-(void)cameFromTutorial;

@end