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
#import "heathHeartSprite.h"
#import "MoveableBlock.h"
#import "DPad.h"
#import "Breakable_Block.h"
#import "ScoreClass.h"
#import "GameCenterClass.h"
#import "Achievements.h"

/**
 *  The intro scene
 *  Note, that scenes should now be based on CCScene, and not CCLayer, as previous versions
 *  Main usage for CCLayer now, is to make colored backgrounds (rectangles)
 *
 */
@interface IntroScene : CCScene<UITextFieldDelegate>{
    
    // basic elements //
    OALSimpleAudio *playSound;
    
    int xBounds;
    int yBounds;
    
    int speed;
    int score;
    int totalScore;
    
    CGPoint touchPoint;
    
    // main sprites //
    Guy_Sprite_Object *newGuySprite;
    Enemy_Sprite_Object *newEnemySprite;
    EndBox *newEndBox;
    CCLayoutBox *goalBox;
    heathHeartSprite *newHealthHeart;
    MoveableBlock *moveableBlock;
    Breakable_Block *mazeBreakableBlock;
    
    // pause elements //
    CCNodeColor *backgroundColorOnPause;
    CCButton *pauseButton;
    CCLayoutBox *pauseLayoutBox;
    
    DPad *newDPad;
    
    CCLabelTTF *timeLabel;
    
    int timeIncrease;
    NSTimer *startTimer;
    
    
    // tutorial elements //
    BOOL tutorialMode;
    CCButton *arrowButton;
    CCButton *tutorialDoneButton;
    CCButton *secondArrowButton;
    CCButton *thirdArrowButton;
    CCButton *forthArrowButton;
    CCLabelTTF *heartInstruction;
    
    CCLayoutBox *playerControlsLayoutBox;
    CCSprite *backgroundBox;
    Achievements *playerAchievements;
    
    BOOL movementBoolean;
    float startXOfEnemy;
    float stopXOfEnemy;
    
    float differenceXOfEnemy;
    int enemyDeath;
    
    CCSprite *enemyPointSprite;
    int numberOfAxes;
    
    CCSprite *axeSprite;
    CCLabelTTF *amountOfAxesLabel;
    

    ScoreClass *newScoreClass;
    GameCenterClass *newGameCenterClass;
    
    
    NSMutableDictionary *namesAndScores;
    
    CCLabelTTF *gameScoreLabel;
    CCLabelTTF *gameOverLabel;
    CCSprite *goalBoxSprite;
    CCSprite *scoreBox;
    CCLayoutBox *goalBoxLayout;
    
    CCTextField *mainTextField;
    
}



+(IntroScene *)sceneCameFromTutorial:(BOOL)yesOrNo;
- (id)initWithTutorialYesOrNo:(BOOL)yesOrNo;

@property (nonatomic, strong)NSArray *leaderboard;

@end