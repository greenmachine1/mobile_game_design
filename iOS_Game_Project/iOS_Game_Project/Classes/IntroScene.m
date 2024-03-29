//
//  IntroScene.m
//  iOS_Game_Project
//
//  Created by Cory Green on 5/5/14.
//  Copyright Cory Green 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "Block_Wall.h"
#import "Guy_Sprite_Object.h"
#import "Enemy_Sprite_Object.h"
#import "EndBox.h"
#import "heathHeartSprite.h"
#import "cocos2d.h"
#import "CCAnimation.h"
#import "MainMenuScene.h"
#import "ArrowSprite.h"
#import "CreditsScene.h"
#import "MoveableBlock.h"
#import "DPad.h"
#import "GameCenterClass.h"
#import "ScoreClass.h"
#import "LeaderBoard.h"
#import "Achievements.h"





// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene
@synthesize leaderboard;

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+(IntroScene *)sceneCameFromTutorial:(BOOL)yesOrNo
{
	return [[self alloc] initWithTutorialYesOrNo:yesOrNo];
}



- (id)initWithTutorialYesOrNo:(BOOL)yesOrNo
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // setting up for tutorial mode //
    tutorialMode = yesOrNo;
    
    // movement right and left //
    movementBoolean = true;
    
    // enemy loop stuff //
    stopXOfEnemy = 100;
    startXOfEnemy = 50;

    enemyDeath = 0;
    numberOfAxes = 2;

    // enabling audio for effects //
    playSound = [OALSimpleAudio sharedInstance];
    
    
    // getting the x and y coords of the screen size //
    xBounds = self.contentSize.width;
    yBounds = self.contentSize.height;
    
    // setting the movement speed of the guy //
    speed = 50;
    
    // setting the initial score which is 4 //
    score = 4;
    
    
    // background stuff //
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.1 green:0.4 blue:0.5 alpha:1.0]];
    [background setZOrder:0];
    
    //   adding the background color to the scene   //
    [self addChild:background];
    
    
    // creating the guy //
    newGuySprite = [Guy_Sprite_Object createGuySpriteWithLocation:ccp(xBounds - 64, yBounds / 2)];
    [newGuySprite setZOrder:1];
    
    touchPoint = newGuySprite.position;
    
    [self addChild:newGuySprite];
    
    [self creationOfBlocks];
    [self creationOfEnemy];
    [self createEndBox];
    
    [self creationOfPlayerInfo];
    
    if(tutorialMode == YES){
        
        [self cameFromTutorial];
        
    }
    
    // setting up instances of my singletons //
    newScoreClass = [ScoreClass sharedInstance];
    newGameCenterClass = [GameCenterClass sharedGameCenter];
    playerAchievements = [Achievements sharedInstance];
    
    
    
    
	return self;
}





-(void)onEnter{
    [super onEnter];
    
    
    if(!tutorialMode){
        timeIncrease = 0;
        // timer for the game, gets the total seconds gone by //
        startTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerOfGame:) userInfo:nil repeats:TRUE];
        [startTimer fire];
    }
    
    // should be asking for user info here
    if(newGameCenterClass.isAuthorized == false){
        
        // asking if there is a current user logged in //
        // if not, then ask the user to log in //
        if( [[[NSUserDefaults standardUserDefaults] objectForKey:@"mainName"] isEqualToString:@""] ){
            // stop the timer so the user can enter in their name //
            [startTimer invalidate];
        
            [self askForUserName];
        }
    }
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
}




-(void)timerOfGame:(NSDate *)time{
    [timeLabel removeFromParentAndCleanup:TRUE];
    
    timeIncrease++;
    
    NSString *timeString = [NSString stringWithFormat:@"Time %i", timeIncrease];
    
    timeLabel = [CCLabelTTF labelWithString:timeString fontName:@"Papyrus" fontSize:30.0f];
    timeLabel.anchorPoint = ccp(0.5f, 0.5f);

    // setting the time to be in the player controls box //
    timeLabel.position = ccp((backgroundBox.contentSize.width / 2) - 20.0f, backgroundBox.contentSize.height + 10.0f);
    timeLabel.fontSize = 20.0f;
    
    timeLabel.fontColor = [CCColor blackColor];
    [timeLabel setZOrder:4];
    [self addChild:timeLabel];
    
}




-(void)creationOfPlayerInfo{
    
    playerControlsLayoutBox = [[CCLayoutBox alloc] init];
    playerControlsLayoutBox.position = ccp(80.0f , 160.0f);
    playerControlsLayoutBox.anchorPoint = ccp(0.5f, 0.5f);
    
    
    backgroundBox = [CCSprite spriteWithImageNamed:@"Options_background.png"];
    backgroundBox.position = ccp(playerControlsLayoutBox.contentSize.width, playerControlsLayoutBox.contentSize.height);
    backgroundBox.anchorPoint = ccp(0.5f, 0.5f);
    [playerControlsLayoutBox addChild:backgroundBox z:3];
    
    
    // this is the bottom left hand corner that will provide the //
    // D-pad, hearts, pause button, and axes info //
    newDPad = [DPad createDPadAtLocation:ccp((backgroundBox.contentSize.width / 2) - 2.0f, backgroundBox.contentSize.height - 180.0f)];
    [newDPad enableDisableDPadInput:false];
    [backgroundBox addChild:newDPad z:2];
    
    
    
    // creation of the hearts //
    for(int i = 1; i < 5; i++){
        
        newHealthHeart = [heathHeartSprite createHeathHeartAtLocation:ccp(((newDPad.contentSize.width / 2) - 6.0f) + (32 * i), newDPad.position.y + 200.0f)];
        [backgroundBox addChild:newHealthHeart z:2 name:@"Heart"];
    }
    
    axeSprite = [CCSprite spriteWithImageNamed:@"Axe_sprite.png"];
    axeSprite.position = ccp(newDPad.position.x + 92.0f, newDPad.position.y + 165.0f);
    [backgroundBox addChild:axeSprite z:2 name:@"axe"];
    
    amountOfAxesLabel = [CCLabelTTF labelWithString:@"x2" fontName:@"Chalkduster" fontSize:20.0f];
    
    amountOfAxesLabel.position = ccp(axeSprite.position.x + 30.0f, axeSprite.position.y);
    amountOfAxesLabel.fontColor = [CCColor redColor];
    [backgroundBox addChild:amountOfAxesLabel z:3];
    
    
    // adding pause functionality //
    CCSpriteFrame *pauseSprite = [CCSpriteFrame frameWithImageNamed:@"pause_sprite.png"];
    pauseButton = [CCButton buttonWithTitle:nil spriteFrame:pauseSprite];
    pauseButton.position = ccp((backgroundBox.contentSize.width / 2) + 50.0f,  backgroundBox.contentSize.height - 20.0f);
    
    NSLog(@"width %f, height %f", backgroundBox.contentSize.width, backgroundBox.contentSize.height);
    
    [pauseButton setTarget:self selector:@selector(onPauseGame)];
    
    [backgroundBox addChild:pauseButton z:4];
    
    [self addChild:playerControlsLayoutBox];
}







-(void)creationOfEnemy{
    
    newEnemySprite = [Enemy_Sprite_Object createEnemyWithLocation:ccp(208.0f, (yBounds - 224.0f) - 32.0f)];
    [self addChild:newEnemySprite z:1 name:@"mainEnemy"];
    
    
    otherEnemySprite = [Enemy_Sprite_Object createEnemyWithLocation:ccp(xBounds - 150.0f, 64.0f)];
    [otherEnemySprite setZOrder:1];
    [otherEnemySprite moveUpAndDown];
    [self addChild:otherEnemySprite];
    
}


-(void)createEndBox{
    
    newEndBox = [EndBox createEndBoxWithLocation:ccp(224.0f, yBounds - 80.0f)];
    [newEndBox setZOrder:1];
    [self addChild:newEndBox];
    
}





-(void)creationOfBlocks{
    
    
    // getting the width / 32 + 2
    int numberOfBlocksInTheWidth = ((xBounds / 16) + 2);
    int numberOfBlocksInTheHeight = ((yBounds / 16) + 2);
    
    for(int i = 1; i < numberOfBlocksInTheWidth; i++){
        
        // making sure the blocks get created at intervals of 1 ,3 ,5, 7, 9... //
        if((i % 2) == 1){
            
            // creation of the lower and upper walls
            Block_Wall *lowerWall = [Block_Wall createWallAtPosition:ccp(i * 16.0f, 16.0f)];
            [self addChild:lowerWall];
            
            Block_Wall *upperWall = [Block_Wall createWallAtPosition:ccp(i * 16, yBounds - 16)];
            [self addChild:upperWall];
        }
    }
    
    // creating the dividing wall //
    for(int j = 1; j < numberOfBlocksInTheHeight; j++){
        if((j % 2) == 1){
            Block_Wall *dividingWall = [Block_Wall createWallAtPosition:ccp(176.0f, j * 16)];
            [self addChild:dividingWall];
            
            // creating the backwall //
            Block_Wall *mazeBackWall = [Block_Wall createWallAtPosition:ccp(xBounds - 8, j * 16)];
            [self addChild:mazeBackWall];
        }
    }
    
    
    
    
    
    // ------------------------> creation of the maze itself <-------------------------------- //
    // wall protruding out of the dividing wall
    for(int l = 1; l < 4; l++){
        
        if((l % 2) == 1){
            
            Block_Wall *mazeWall = [Block_Wall createWallAtPosition:ccp(192.0f + (16 * l), yBounds - 208)];
            [self addChild:mazeWall];
            
        }
    }
    
    // wall coming down the middle //
    for(int m = 1; m < numberOfBlocksInTheHeight; m++){
        
        if((m % 2) == 1){
            
            Block_Wall *mazeWall = [Block_Wall createWallAtPosition:ccp(368.0f, (yBounds - 224) + (16 * m))];
            [self addChild:mazeWall];
        }
    }
    
    
    
    // wall coming out of the right side as the starting point divider //
    for(int n = 1; n < 6; n ++){
        if((n % 2) == 1){
            Block_Wall *mazeWall = [Block_Wall createWallAtPosition:ccp(448.0f + (16 * n), yBounds - 208.0f)];
            [self addChild:mazeWall];
            
            Block_Wall *mazeWallLower = [Block_Wall createWallAtPosition:ccp(448.0f + (16 * n), yBounds - 112)];
            [self addChild:mazeWallLower];
        }
    }
    
    
    // ---------------> creation of the moveable blocks <----------------- //
    
    moveableBlock = [MoveableBlock createMovableBlockWithLocation:ccp(368.0f, (yBounds - 224.0f) - 32.0f)];
    moveableBlock.anchorPoint = ccp(0.5f, 0.5f);
    moveableBlock.scaleY = 2.0f;
    [self addChild:moveableBlock z:0 name:@"midblock"];
    
    
    MoveableBlock *newBlock = [MoveableBlock createMovableBlockWithLocation:ccp(464.0f, yBounds - 160.0f)];
    newBlock.anchorPoint = ccp(0.5f,0.5f);
    newBlock.scaleY = 2.0f;
    [self addChild:newBlock z:0 name:@"midblock1"];
    
    
    
    // -----------------> creation of the breakable blocks <-------------------- //
    // wall protruding from the dividing wall just before the end flag //
    for(int k = 1; k < 10; k++){
        
        if((k % 2) == 1){
            
            mazeBreakableBlock = [Breakable_Block createBlockAtLocation:ccp(192.0f + (16 * k), yBounds - 144)];
            mazeBreakableBlock.name = [NSString stringWithFormat:@"%i", k];
            
            [self addChild:mazeBreakableBlock];
        }
        
    }
    
}









// creating a popup that allows the user to resume or go to main menu //
-(void)onPauseGame{
    
    pauseButton.enabled = NO;
    [newDPad enableDisableDPadInput:true];
    
    // stopping the timer //
    [startTimer invalidate];
    
    // changing the color of the background to better denote the pausing effect //
    backgroundColorOnPause = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6]];
    backgroundColorOnPause.zOrder = 4;
    [self addChild:backgroundColorOnPause];
    
    
    // pausing the game //
    [[CCDirector sharedDirector] pause];
    
    
    // creating elements for the pause menu //
    CCSprite *menuBoxPause = [CCSprite spriteWithImageNamed:@"menu_box_pause.png"];
    
    pauseLayoutBox = [[CCLayoutBox alloc] init];
    pauseLayoutBox.anchorPoint = ccp(0.5, 0.5);
    pauseLayoutBox.direction = CCLayoutBoxDirectionVertical;
    [pauseLayoutBox setZOrder:5];
    
    
    
    // resume button //
    CCButton *resumeButton = [CCButton buttonWithTitle:@"Resume!" fontName:@"Chalkduster" fontSize:20.0f];
    [resumeButton setTarget:self selector:@selector(resumeButton)];
    resumeButton.position = ccp(menuBoxPause.contentSize.width / 2, (menuBoxPause.contentSize.height / 2) + 50.0f);
    
    
    // back to main menu button //
    CCButton *mainMenuButton = [CCButton buttonWithTitle:@"Main Menu!" fontName:@"Chalkduster" fontSize:20.0f];
    [mainMenuButton setTarget:self selector:@selector(mainMenuButton)];
    mainMenuButton.position = ccp(menuBoxPause.contentSize.width / 2, (menuBoxPause.contentSize.height / 2) );
    
    
    // setting the resumeButton to be the child of the sprite //
    // menuBoxPause square //
    [menuBoxPause addChild:mainMenuButton];
    [menuBoxPause addChild:resumeButton];
    
    [pauseLayoutBox addChild:menuBoxPause];
    
    pauseLayoutBox.position = ccp(xBounds / 2, yBounds / 2);
    
    [self addChild:pauseLayoutBox];
    
    
    // print out any achievements associated with that user //
    NSLog(@"%@", [[[NSUserDefaults standardUserDefaults] objectForKey:@"userAchievements"]objectForKey:[[NSUserDefaults standardUserDefaults] objectForKey:@"mainName"]]);
}



// resuming the game //
-(void)resumeButton{
    
    // resuming the timer //
    startTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerOfGame:) userInfo:nil repeats:TRUE];
    [startTimer fire];
    
    pauseButton.enabled = YES;
    [newDPad enableDisableDPadInput:false];
    
    // removes elements from pause from the screen //
    [backgroundColorOnPause removeFromParentAndCleanup:true];
    [pauseLayoutBox removeFromParentAndCleanup:true];
    
    
    // resuming the game //
    [[CCDirector sharedDirector] resume];
    
}


// going back to the main menu //
-(void)mainMenuButton{
    
    // removes elements from pause from the screen //
    [backgroundColorOnPause removeFromParentAndCleanup:true];
    [pauseLayoutBox removeFromParentAndCleanup:true];
    
    // resuming the game //
    [[CCDirector sharedDirector] resume];
    
    [[CCDirector sharedDirector] replaceScene:[MainMenuScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
    
}
    










-(void)update:(CCTime)delta{
    
    // if the tutorial mode is off //
    if(tutorialMode == false){
        
        // movement //
        if([[newDPad direction]  isEqualToString: @"up"]){
            
            newGuySprite.position = ccp((newGuySprite.position.x),(newGuySprite.position.y + 1 + (speed * delta)));
                                        
        }else if([[newDPad direction] isEqualToString:@"down"]){
            
            newGuySprite.position = ccp((newGuySprite.position.x), (newGuySprite.position.y - 1 - (speed * delta)));
            
        }else if([[newDPad direction] isEqualToString:@"left"]){
            
            newGuySprite.position = ccp((newGuySprite.position.x - 1 - (speed * delta)),(newGuySprite.position.y));
            
        }else if([[newDPad direction] isEqualToString:@"right"]){
            
            newGuySprite.position = ccp((newGuySprite.position.x + 1 + (speed * delta)) ,(newGuySprite.position.y));
            
        }else if([[newDPad direction] isEqualToString:@"stopped"]){
            
            
        }
        
        
    // do not permit movement in tutorial mode //
    }else{
    }
    
    //[self collisionWithAnyBlock];
    [self collisionWithMovableBlock];
    [self collisionWithMovableBlockAndWall];
    [self collisionForEnemy];
    
    // experiment to see if I can create a generic collision detection function //
    for(Block_Wall *blockWall in self.children){
        
        if([blockWall isKindOfClass:[Block_Wall class]]){
            
            if(CGRectIntersectsRect([newGuySprite getBoundingBox], [blockWall getBoundingBox])){
                
                [self generalCollisionBetweenTwoObjects:newGuySprite secondObject:blockWall];
            }
        }
    }

    
    [self collisionWithEnd];
    [self collisionWithEnemyAndMovableBlock];
    [self collisionWithEnemyAndWall];
    [self collisionWithGuyAndBreakableBlock];
    
    
    // movement of the enemy sprite //
    if(movementBoolean == true){
        
        newEnemySprite.position = ccp(newEnemySprite.position.x + 1 + (speed * delta), newEnemySprite.position.y);
        
    }else if(movementBoolean == false){
        
        newEnemySprite.position = ccp(newEnemySprite.position.x - 1 - (speed * delta), newEnemySprite.position.y);
    }
    
    // if the proximity between the left and right motions is within 15 points //
    // of each other.... remove the sprite from the scene //
    if((stopXOfEnemy - startXOfEnemy) < 15){
        
        NSLog(@"in here!");
        
        [self removeChildByName:@"mainEnemy" cleanup:true];
        //[newEnemySprite removeFromParentAndCleanup:true];
        stopXOfEnemy = 1000;
        
        enemyDeath = enemyDeath + 1;
        
        enemyPointSprite = [CCSprite spriteWithImageNamed:@"Enemy_death.png"];
        enemyPointSprite.position = ccp(newGuySprite.position.x , newGuySprite.position.y + 32);
        enemyPointSprite.scaleX = 2.0f;
        enemyPointSprite.scaleY = 2.0f;
        [self addChild:enemyPointSprite z:3];
        
        [self performSelector:@selector(removeEnemyDeath) withObject:nil afterDelay:2.0f];
    }
}

-(void)removeEnemyDeath{
    
    [enemyPointSprite removeFromParentAndCleanup:true];
}





-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    touchPoint = [touch locationInNode:self];
}




// general collision //
-(void)generalCollisionBetweenTwoObjects:(CCNode*)objectInMotion secondObject:(CCNode*)stationaryObject{
    
    // object in motion collides going up with a stationary object //
    if( (objectInMotion.position.y + 16 > stationaryObject.position.y - 16) &&
       (((objectInMotion.position.x + 16 > stationaryObject.position.x - 16) &&
         (objectInMotion.position.x - 16 < stationaryObject.position.x + 16)) &&
        (! (objectInMotion.position.y + 16 > stationaryObject.position.y)))){
           
           // position the moving object below the stationary one //
           objectInMotion.position = ccp(objectInMotion.position.x, stationaryObject.position.y - 32);
    
       // object in motion collides going down with a stationary object //
       }else if( (objectInMotion.position.y - 16 < stationaryObject.position.y + 16) &&
                (((objectInMotion.position.x + 16 > stationaryObject.position.x - 16) &&
                  (objectInMotion.position.x - 16 < stationaryObject.position.x + 16)) &&
                 (!(objectInMotion.position.y - 16 < stationaryObject.position.y)))){
                    
            // position the moving object above the stationary one //
            objectInMotion.position = ccp(objectInMotion.position.x, stationaryObject.position.y + 32);
                    
        // object in motion collides to the left with the stationary one //
        }else if( (objectInMotion.position.x - 16 < stationaryObject.position.x + 16) &&
                ((objectInMotion.position.y + 16 > stationaryObject.position.y - 16) &&
                (objectInMotion.position.y - 16 < stationaryObject.position.y + 16)) &&
                (!(objectInMotion.position.x - 16 < stationaryObject.position.x))){
            
            // position the moving object to the right of the stationary one //
            objectInMotion.position = ccp(stationaryObject.position.x + 32, objectInMotion.position.y);
        
        // object in motion collides to the left of the stationary one //
        }else if( (objectInMotion.position.x - 16 < stationaryObject.position.x + 16) &&
                 ((objectInMotion.position.y + 16 > stationaryObject.position.y - 16) &&
                  (objectInMotion.position.y - 16 < stationaryObject.position.y + 16)) &&
                 (!(objectInMotion.position.x - 16 < stationaryObject.position.y))){
            
            // position of the moving object to the left of the stationary one //
            objectInMotion.position = ccp(stationaryObject.position.x - 32, objectInMotion.position.y);
            
        }
}




// detecting collision between the guy and the breakable block //
-(void)collisionWithGuyAndBreakableBlock{
    
    for(Breakable_Block *breakBlock in self.children){
        
        if([breakBlock isKindOfClass:[Breakable_Block class]]){
            
            if(CGRectIntersectsRect([breakBlock getBoundingBox], [newGuySprite getBoundingBox])){
            
                // this is correct for collision //
                // up //
                if( (newGuySprite.position.y + 16 > breakBlock.position.y - 16) &&
                   (((newGuySprite.position.x + 16 > breakBlock.position.x - 16) &&
                     (newGuySprite.position.x - 16 < breakBlock.position.x + 16)) &&
                    (!(newGuySprite.position.y + 16 > breakBlock.position.y)))){
                    
                      
                        // position guy just below the block //
                        newGuySprite.position = ccp(newGuySprite.position.x, breakBlock.position.y - 32);
                        [newGuySprite stopAllActions];
                    
                        // should come up with a popup giving the user the choice to break through the block //
                        // based on if they have anymore axes to use //
                    
                    if(!(numberOfAxes <= 0)){
                        CCSpriteFrame *breakBlockButton = [CCSpriteFrame frameWithImageNamed:@"Axe_sprite.png"];
                        
                        CCButton *destroyButton = [CCButton buttonWithTitle:@"" spriteFrame:breakBlockButton];
                        destroyButton.anchorPoint = ccp(0.5f, 0.5f);
                        destroyButton.position = ccp(breakBlock.contentSize.width / 2, breakBlock.contentSize.height / 2);
                        destroyButton.name = breakBlock.name;
                        [destroyButton setTarget:self selector:@selector(onDestroyBlock:)];
                        [breakBlock addChild:destroyButton];
                    }
                 // down //
                }else if( (newGuySprite.position.y - 16 < breakBlock.position.y + 16) &&
                         (((newGuySprite.position.x + 16 > breakBlock.position.x - 16) &&
                          (newGuySprite.position.x - 16 < breakBlock.position.x + 16)) &&
                         (!(newGuySprite.position.y - 16 < breakBlock.position.y)))){
                    
                             
                    newGuySprite.position = ccp(newGuySprite.position.x, breakBlock.position.y + 32);
                    [newGuySprite stopAllActions];
                    
                    if(!(numberOfAxes <= 0)){
                        CCSpriteFrame *breakBlockButton = [CCSpriteFrame frameWithImageNamed:@"Axe_sprite.png"];
                        
                        CCButton *destroyButton = [CCButton buttonWithTitle:@"" spriteFrame:breakBlockButton];
                        destroyButton.anchorPoint = ccp(0.5f, 0.5f);
                        destroyButton.position = ccp(breakBlock.contentSize.width / 2, breakBlock.contentSize.height / 2);
                        destroyButton.name = breakBlock.name;
                        [destroyButton setTarget:self selector:@selector(onDestroyBlock:)];
                        [breakBlock addChild:destroyButton];
                    }
                    
                             
                             
                // right //
                }else if( (newGuySprite.position.x - 16 < breakBlock.position.x + 16) &&
                         ((newGuySprite.position.y + 16 > breakBlock.position.y - 16) &&
                          (newGuySprite.position.y - 16 < breakBlock.position.y + 16)) &&
                         (!(newGuySprite.position.x - 16 < breakBlock.position.x))){
                    
                    newGuySprite.position = ccp(breakBlock.position.x + 32, newGuySprite.position.y);
                    [newGuySprite stopAllActions];
                    
                    if(!(numberOfAxes <= 0)){
                        CCSpriteFrame *breakBlockButton = [CCSpriteFrame frameWithImageNamed:@"Axe_sprite.png"];
                        
                        CCButton *destroyButton = [CCButton buttonWithTitle:@"" spriteFrame:breakBlockButton];
                        destroyButton.anchorPoint = ccp(0.5f, 0.5f);
                        destroyButton.position = ccp(breakBlock.contentSize.width / 2, breakBlock.contentSize.height / 2);
                        destroyButton.name = breakBlock.name;
                        [destroyButton setTarget:self selector:@selector(onDestroyBlock:)];
                        [breakBlock addChild:destroyButton];
                    }
                    
                    
                // left //
                }else if( (newGuySprite.position.x - 16 < breakBlock.position.x + 16) &&
                         ((newGuySprite.position.y + 16 > breakBlock.position.y - 16) &&
                          (newGuySprite.position.y - 16 < breakBlock.position.y + 16)) &&
                         (!(newGuySprite.position.x - 16 < breakBlock.position.y))){
                    
                    newGuySprite.position = ccp(breakBlock.position.x - 32, newGuySprite.position.y);
                    [newGuySprite stopAllActions];
                    
                    if(!(numberOfAxes <= 0)){
                        CCSpriteFrame *breakBlockButton = [CCSpriteFrame frameWithImageNamed:@"Axe_sprite.png"];
                        
                        CCButton *destroyButton = [CCButton buttonWithTitle:@"" spriteFrame:breakBlockButton];
                        destroyButton.anchorPoint = ccp(0.5f, 0.5f);
                        destroyButton.position = ccp(breakBlock.contentSize.width / 2, breakBlock.contentSize.height / 2);
                        destroyButton.name = breakBlock.name;
                        [destroyButton setTarget:self selector:@selector(onDestroyBlock:)];
                        [breakBlock addChild:destroyButton];
                    }
                    
                    
                }
            }
                 
        }
    }
}





// this removes the block from the view //
-(void)onDestroyBlock:(id)sender{
    
    if(!(numberOfAxes <= 0)){
        
        [amountOfAxesLabel removeFromParentAndCleanup:true];
        
        amountOfAxesLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"x%i", numberOfAxes - 1] fontName:@"Chalkduster" fontSize:20.0f];
        
        amountOfAxesLabel.position = ccp(axeSprite.position.x + 30.0f, axeSprite.position.y);
        amountOfAxesLabel.fontColor = [CCColor redColor];
        [backgroundBox addChild:amountOfAxesLabel z:3];
    
        
        NSLog(@"number of axes left %i", numberOfAxes);
        CCButton *button = (CCButton *)sender;
        
        [self removeChildByName:button.name cleanup:true];
        
        numberOfAxes--;
    }
}






// detecting collision between the enemy and movable block //
-(void)collisionWithEnemyAndMovableBlock{
    
    for(Enemy_Sprite_Object *enemySprite in self.children){
        
        if([enemySprite isKindOfClass:[Enemy_Sprite_Object class]]){
            
            for(MoveableBlock *moveableBlockObject in self.children){
                
                if([moveableBlockObject isKindOfClass:[MoveableBlock class]]){
                    
                    if(CGRectIntersectsRect([enemySprite getBoundingBox], [moveableBlockObject getBoundingBox])){
                        
                        if([[enemySprite name] isEqualToString:@"mainEnemy"]){
                            
                            movementBoolean = false;
                            
                            // need to get the stopping point //
                            stopXOfEnemy = enemySprite.position.x;
                        }
                        
                    }
                }
            }
        }
    }
}



// detecting collision between the enemy and movable block //
-(void)collisionWithEnemyAndWall{
    
    for(Enemy_Sprite_Object *enemySpriteObject in self.children){
        
        if([enemySpriteObject isKindOfClass:[Enemy_Sprite_Object class]]){
            
            for(Block_Wall *blockWall in self.children){
                
                if([blockWall isKindOfClass:[Block_Wall class]]){
                    
                    if(CGRectIntersectsRect([enemySpriteObject getBoundingBox], [blockWall getBoundingBox])){
                        
                        if([[enemySpriteObject name] isEqualToString:@"mainEnemy"]){
                            
                            movementBoolean = true;
                            
                            // need to get the stopping point //
                            startXOfEnemy = enemySpriteObject.position.x;
                        }

                    }
                }
            }
        }
    }
}



-(void)collisionWithEnd{
    
    //   if the guy is in the end box boundry   //
    if(CGRectIntersectsRect([newGuySprite getBoundingBox], [newEndBox getBoundingBox])){
        
        touchPoint = ccp(xBounds - 64, yBounds / 2);
        [newDPad enableDisableDPadInput:true];
        
        //   reposition the guy so as to not keep triggering the collision   //
        newGuySprite.position = touchPoint;
        [newGuySprite stopAllActions];
        [playSound playBg:@"Applause.mp3"];
        
        // stopping the timer //
        [startTimer invalidate];
        
        
        // setting the time achievement //
        int timeAtStop = (int)timeIncrease;
        

        // --------- > setting an achievement < ----------------//
        // checking to see if the finished time is within range //
        // if it is, award and achievement to that user //
        
        // making sure that game center isnt authorized //
        if(!(newGameCenterClass.isAuthorized)){
            
            achievementsArray = [[NSMutableArray alloc] init];
            
            
            // finished game within a certain amount of time
            if(!([[playerAchievements finishingLevelWithinTime:timeAtStop] isEqualToString:@""])){
                
                [achievementsArray addObject:[playerAchievements finishingLevelWithinTime:timeAtStop]];
            }
            
            if(!([[playerAchievements finishedLevelWithinTime:timeAtStop andKilledNinjaSquid:enemyDeath] isEqualToString:@""])){
                
                [achievementsArray addObject:[playerAchievements finishedLevelWithinTime:timeAtStop andKilledNinjaSquid:enemyDeath]];
            }
            
            
            
            

            // everytime this is called, it will increment by 1 //
            [playerAchievements incrementGamePlayed];
            
            
            // saying that if all the hearts are still in place by the end //
            // add an achievement to the list!
            if(score == 4){
                
                [playerAchievements incrementHeartsAvailable];
                
                if(!([[playerAchievements finishedAfter_3_GamesAndStillHaveAllHeartsLeft] isEqualToString:@""])){
                    
                    [achievementsArray addObject:[playerAchievements finishedAfter_3_GamesAndStillHaveAllHeartsLeft]];
                    
                }
            }

            // completed a perfect game ---> no time restriction <---//
            if(!([[playerAchievements completionPerfect:score andKillingOfNinjaSquid:enemyDeath] isEqualToString:@""])){
                
                [achievementsArray addObject:[playerAchievements completionPerfect:score andKillingOfNinjaSquid:enemyDeath]];
                
            }

            // displays the achievement //
            [self displayAchievementCameFromGameWin:true];

        }
    }
}





// shows the achievement to the user //
-(void)displayAchievementCameFromGameWin:(BOOL)trueOrFalse{
    
    
    if(trueOrFalse == true){
        
        cameFromGoal = true;
        
    }else{
        
        cameFromGoal = false;
    }
    
        // setting the background color to be a transparent black
        CCNodeColor *newbackgroundColor = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6f]];
        [newbackgroundColor setZOrder:4];
        [self addChild:newbackgroundColor];
    
        NSLog(@"count for achievements array %lu", (unsigned long)[achievementsArray count]);
    
        for(int i = 0; i < achievementsArray.count; i++){
    
            achievementLabel = [CCLabelTTF labelWithString:[achievementsArray objectAtIndex:i] fontName:@"Chalkduster" fontSize:20.0f];
            achievementLabel.anchorPoint = ccp(0.5f, 0.5f);
            achievementLabel.position = ccp(xBounds / 2, (yBounds - 40.0f) - (20 * (i + 1)));
            achievementLabel.color = [CCColor greenColor];
            [self addChild:achievementLabel z:4];
        
        }
    
    [self performSelector:@selector(removeAchievementsLabel) withObject:nil afterDelay:4.0f];

}



-(void)removeAchievementsLabel{
    
    [achievementLabel removeFromParentAndCleanup:true];
    [achievementsArray removeAllObjects];
    
    // basically I need to present the user with a good job then transition to the //
    // goal section or the game over section //
    if(cameFromGoal == true){
        
        [self displayGoal];
        
    }else if(cameFromGoal == false){
        
        [self gameOver];
        
    }
    
}













-(void)collisionForEnemy{
    
    //   basically If the user touches the enemy, I need to reset their position   //
    if((CGRectIntersectsRect([newGuySprite getBoundingBox], [newEnemySprite getBoundingBox])) || (CGRectIntersectsRect([otherEnemySprite getBoundingBox], [newGuySprite getBoundingBox]))){
        
        [playSound playBg:@"sea_audio.mp3"];
        
        score = score - 1;
        
        // removes one heart at a time from the screen //
        [backgroundBox removeChildByName:@"Heart" cleanup:YES];
        
        touchPoint = ccp(xBounds - 64, yBounds / 2);
        
        //   resets the position of the guy   //
        newGuySprite.position = touchPoint;
        
        //   stops the guy from continuing to move after hitting   //
        [newGuySprite stopAllActions];
        
        // changes the color when hit to denote visually... that hes been hit //
        [newGuySprite changeColor];
        
        NSLog(@"Amount of hearts left %i", score);
        
        if(!(newGameCenterClass.isAuthorized)){
            
            achievementsArray = [[NSMutableArray alloc] init];
            
            // game over //
            if(score < 1){
            
                // setting the name and score (Even though you lost) to the achievements center //
                if( !([[[NSUserDefaults standardUserDefaults] objectForKey:@"mainName"] isEqualToString:@""] )){
                
                    NSLog(@"In here super in here!");
                
                    // sets the score with the saved name and current score //
                    [newScoreClass setNameAndScoreOfUser:[[NSUserDefaults standardUserDefaults] objectForKey:@"mainName"] andScore:totalScore];
                }
                
                // add the award for dying to the player achievements //
                if(!([[playerAchievements awardPlayerForDeath:score] isEqualToString:@""])){
                    
                    NSLog(@"In here super in here as welllllllllllllllll!");
                    
                    [achievementsArray addObject:[playerAchievements awardPlayerForDeath:score]];
                    
                    NSLog(@"Whats in the array %@", [playerAchievements awardPlayerForDeath:score]);
                    NSLog(@"Whats in the array %@", achievementsArray);
                    
                }

                [self displayAchievementCameFromGameWin:false];
            }
            
        // if connected to game center //
        }else{
            
            [self gameOver];
            
        }
        
    }
}




// --- > collision with movable block < --- //
-(void)collisionWithMovableBlock{

        // checking to see if it is of type MovableBlock //
        for (MoveableBlock *moveableBlocks in self.children){
                
            if([moveableBlocks isKindOfClass:[MoveableBlock class]]){
                    
                if(CGRectIntersectsRect([moveableBlocks getBoundingBox], [newGuySprite getBoundingBox])){
                        
                    float widthOfGuy = [newGuySprite getBoundingBox].size.width / 2;
                    float widthOfBox = [moveableBlock getBoundingBox].size.width / 2;

                    // need to say -> if guy position + 16 is greater than block position - 16 but not greater than block position x //
                    if(( (newGuySprite.position.x - widthOfGuy) < (moveableBlocks.position.x + widthOfBox) ) && (! ((newGuySprite.position.x) > (moveableBlocks.position.x)))) {
                            
                        moveableBlocks.position = ccp(moveableBlocks.position.x + 5.0f, moveableBlocks.position.y);
                            
                    }else if(((newGuySprite.position.x + widthOfGuy) > (moveableBlocks.position.x - widthOfBox)) && (!((newGuySprite.position.x) < (moveableBlocks.position.x)))){
                            
                        moveableBlocks.position = ccp(moveableBlocks.position.x - 5.0f, moveableBlocks.position.y);
                        
                    }
            }
        }
    }
}





-(void)collisionWithMovableBlockAndWall{
    
    // loading up the movable block class
    for(MoveableBlock *moveblock in self.children){
        
        if([moveblock isKindOfClass:[MoveableBlock class]]){
            
            for(Block_Wall *blockWall in self.children){
                
                if([blockWall isKindOfClass:[Block_Wall class]]){
                    
                    if(CGRectIntersectsRect([moveblock getBoundingBox], [blockWall getBoundingBox])){
                        
                        if((moveblock.position.x - 32 < blockWall.position.x + 32) && !(moveblock.position.x < blockWall.position.x)){
                            
                            moveblock.position = ccp(blockWall.position.x + 32, moveblock.position.y);
                            newGuySprite.position = ccp(moveblock.position.x + 32, newGuySprite.position.y);
                            NSLog(@"collision from the left");
                            
                        }else if( (moveblock.position.x + 32 > blockWall.position.x - 32) && !(moveblock.position.x > blockWall.position.x)){
                            
                            moveblock.position = ccp(blockWall.position.x - 32, moveblock.position.y);
                            newGuySprite.position = ccp(moveblock.position.x - 32, newGuySprite.position.y);
                            NSLog(@"collision from the right");
                            
                        }
                    }
                }
            }
        }
    }
}




// --- > collision with any block < --- //
-(void)collisionWithAnyBlock{
    
    // checking for block objects //
    for(Block_Wall *blocks in self.children){
        
        // checking to see if its the kind of class //
        if([blocks isKindOfClass:[Block_Wall class]]){
            
            // checking for intersection of two bounding boxes //
            if(CGRectIntersectsRect([blocks getBoundingBox], [newGuySprite getBoundingBox])){
                
                if(!([[blocks name] isEqualToString:@"midblock"])){
                
                    // this will give me the distance to stop at - 32 //
                    float distance = [blocks getBoundingBox].size.width;
                    
                    
                    //   naming all the constant boundries   //
                    float positiveXForGuy = newGuySprite.position.x + [newGuySprite getBoundingBox].size.width / 2;
                    float negativeXForGuy = newGuySprite.position.x - [newGuySprite getBoundingBox].size.width / 2;
                    float positiveYForGuy = newGuySprite.position.y + [newGuySprite getBoundingBox].size.height / 2;
                    float negativeYForGuy = newGuySprite.position.y - [newGuySprite getBoundingBox].size.height / 2;
                
                    float positiveXForBlock = blocks.position.x + [blocks getBoundingBox].size.width / 2;
                    float negativeXForBlock = blocks.position.x - [blocks getBoundingBox].size.width / 2;
                    float positiveYForBlock = blocks.position.y + [blocks getBoundingBox].size.height / 2;
                    float negativeYForBlock = blocks.position.y - [blocks getBoundingBox].size.height / 2;
                
                
                    //   checking to see if the right side of the free standing block has been touched   //
                    //   if so, check the top and bottom edges to make sure its free before allowing   //
                    //   to pass   //
                    if((negativeXForGuy < positiveXForBlock) && ((negativeYForGuy < positiveYForBlock) && (positiveYForGuy > negativeYForBlock)) && (!(negativeXForGuy < blocks.position.x))){
                    
                        NSLog(@"hit at left");
                        newGuySprite.position = ccp(blocks.position.x + distance , newGuySprite.position.y);
                        [newGuySprite stopAllActions];
                        
                        
                        
                    }
                
                    //   checking to see if the left side of the free standing block has been touched   //
                    //   if so, check the top and bottom edges to makes sure its free before allowing   //
                    //   to pass   //
                    else if((positiveXForGuy > negativeXForBlock) && ((negativeYForGuy < positiveYForBlock) && (positiveYForGuy > negativeYForBlock)) && (!(positiveXForGuy > blocks.position.x))){
                        
                        NSLog(@"hit at right");
                        newGuySprite.position = ccp(blocks.position.x - distance, newGuySprite.position.y);
                        [newGuySprite stopAllActions];
                    
                        
                    }
                
                
                    //   use the same principals as above for top and bottom collision   //
                    else if((positiveYForGuy > negativeYForBlock) && ((negativeXForGuy < positiveXForBlock) && (positiveXForGuy > negativeXForBlock)) && (!(positiveYForGuy > blocks.position.y))){
                    
                        NSLog(@"hit from up");
                        newGuySprite.position = ccp(newGuySprite.position.x, blocks.position.y - distance);
                        [newGuySprite stopAllActions];
                    
                        
                    }
                
                
                    else if((negativeYForGuy < positiveYForBlock) && ((negativeXForGuy < positiveXForBlock) && (positiveXForGuy > negativeXForBlock)) && (!(negativeYForGuy < blocks.position.y))){
                    
                        newGuySprite.position = ccp(newGuySprite.position.x, blocks.position.y + distance);
                        [newGuySprite stopAllActions];
                    
                        
                    }
                
                }

            }
        }
    }
}










// ---------------------- > End Game Goal < ----------------------- //
-(void)displayGoal{

    [newGuySprite stopAllActions];
    

    
    
    // setting the background color to be a transparent black
    CCNodeColor* newbackgroundColor = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6f]];
    [newbackgroundColor setZOrder:4];
    [self addChild:newbackgroundColor];
    
    goalBoxLayout = [[CCLayoutBox alloc] init];
    goalBoxLayout.anchorPoint = ccp(0.5f, 0.5f);
    goalBoxLayout.position = ccp(xBounds / 2, yBounds / 2);
    goalBoxLayout.direction = CCLayoutBoxDirectionVertical;
    [goalBoxLayout setZOrder:4];
    
    
    scoreBox = [CCSprite spriteWithImageNamed:@"tutorial_done_box.png"];
    scoreBox.anchorPoint = ccp(0.5f, 0.5f);
    scoreBox.position = ccp((xBounds / 2), yBounds / 2);
    [scoreBox setZOrder:4];
    [goalBoxLayout addChild:scoreBox];
    
    
    // hearts = 500 a peice, for every second that goes by, you loose 10 points //
    // the total is hearts - time
    int enemyDeathFinalScore = 500 * enemyDeath;
    
    
    // setting the score info //
    int heartsScore = score * 500;
    int timeScore = timeIncrease * 10;
    totalScore = heartsScore - timeScore + enemyDeathFinalScore;
    

    if(totalScore < 0){
        totalScore = 0;
    }
    

    NSString *finalScore = [NSString stringWithFormat:@"Final Score (Hearts x Time) = %i", totalScore];
    
    gameScoreLabel = [CCLabelTTF labelWithString:finalScore fontName:@"Chalkduster" fontSize:12.0f];
    gameScoreLabel.anchorPoint = ccp(0.5f, 0.5f);
    gameScoreLabel.position = ccp((scoreBox.position.x), (scoreBox.contentSize.height / 2));
    [gameScoreLabel setZOrder:4];
    [scoreBox addChild:gameScoreLabel];
    
    goalBoxSprite = [CCSprite spriteWithImageNamed:@"tutorial_done_box.png"];
    goalBoxSprite.anchorPoint = ccp(0.5f, 0.5f);
    goalBoxSprite.position = ccp(xBounds / 2, yBounds / 2);
    [goalBoxSprite setZOrder:4];
    [goalBoxLayout addChild:goalBoxSprite];
    
    gameOverLabel = [CCLabelTTF labelWithString:@"Goal!!!!!" fontName:@"Chalkduster" fontSize:30.0f];
    gameOverLabel.anchorPoint = ccp(0.5f, 0.5f);
    gameOverLabel.position = ccp((goalBoxSprite.contentSize.width / 2), (goalBoxSprite.contentSize.height / 2));
    [goalBoxSprite addChild:gameOverLabel];
    
    [self addChild:goalBoxLayout];
    
    
    
    // ---------------------- > local game center and local leaderboard < ---------------------- //
    // checking to make sure the user is logged into the game center //
    if(newGameCenterClass.isAuthorized == true){

        [self sendScoreToGameCenter];
        
        [self performSelector:@selector(transitionToMainMenu) withObject:nil afterDelay:4.0f];
        
        
        
    // if not connected to game center, user can upload the name and score //
    // into the local leaderboard //
    }else{
        
        if( !([[[NSUserDefaults standardUserDefaults] objectForKey:@"mainName"] isEqualToString:@""] )){
            
            
            // sets the score with the saved name and current score //
            [newScoreClass setNameAndScoreOfUser:[[NSUserDefaults standardUserDefaults] objectForKey:@"mainName"] andScore:totalScore];
            
            [self performSelector:@selector(transitionToLeaderBoard) withObject:nil afterDelay:4.0f];
            
        }else{
        
            [self performSelector:@selector(transitionToLeaderBoard) withObject:nil afterDelay:4.0f];
        }
    }
}

-(void)transitionToMainMenu{
    
    [[CCDirector sharedDirector] replaceScene:[MainMenuScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
}


-(void)transitionToLeaderBoard{
    
    [[CCDirector sharedDirector] replaceScene:[LeaderBoard scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
}









// asking for the users name //
-(void)askForUserName{

    // setting the background color to be a transparent black
    backgroundColor = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6f]];
    [backgroundColor setZOrder:3];
    [self addChild:backgroundColor];
    
    // replacement text prompting the user to enter their name //
    
    gameScoreLabelReplacement = [CCLabelTTF labelWithString:@"Please enter your name!" fontName:@"Chalkduster" fontSize:12.0f];
    gameScoreLabelReplacement.anchorPoint = ccp(0.5f, 0.5f);
    gameScoreLabelReplacement.position = ccp(xBounds / 2, (yBounds / 2) - 20.0f);
    [gameScoreLabelReplacement setZOrder:4];
    [self addChild:gameScoreLabelReplacement];
    
    
    
    CCSprite *textSprite = [CCSprite spriteWithImageNamed:@"tutorial_done_box.png"];
    mainTextField = [CCTextField textFieldWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"tutorial_done_box.png"]];
    
    mainTextField.fontSize = 20.0f;
    mainTextField.contentSize = CGSizeMake((scoreBox.contentSize.width), (scoreBox.contentSize.height));
    mainTextField.preferredSize = textSprite.contentSize;
    mainTextField.anchorPoint = ccp(0.5f, 0.5f);
    mainTextField.positionType = CCPositionTypeNormalized;
    mainTextField.padding = 10.0f;
    mainTextField.position = ccp(0.5f, 0.6f);
    [mainTextField setTarget:self selector:@selector(onTextEntered)];

    [self addChild:mainTextField z:4];
    

}


// called when the return key is pressed on the keyboard
-(void)onTextEntered{
    
    // setting the main name for the achievements //
    mainName = mainTextField.string;
    
    // setting the main name user default //
    [[NSUserDefaults standardUserDefaults] setObject:mainName forKey:@"mainName"];
    
    // setting the name of the user within the achievements class
    [playerAchievements setNameOfCurrentUser:[[NSUserDefaults standardUserDefaults] objectForKey:@"mainName"]];
    
    NSLog(@"%@", [playerAchievements returnAmountOfPlayedGames]);
    
    // resuming the timer //
    startTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerOfGame:) userInfo:nil repeats:TRUE];
    [startTimer fire];
    
    [mainTextField removeFromParentAndCleanup:true];
    
    [gameScoreLabelReplacement removeFromParentAndCleanup:true];
    
    [backgroundColor removeFromParentAndCleanup:true];
}




// method that sends info to the game center //
-(void)sendScoreToGameCenter{
    
    // getting the available leaderboards //
    [GKLeaderboard loadLeaderboardsWithCompletionHandler:^(NSArray *leaderboards, NSError *error) {
        
        self.leaderboard = leaderboards;
        
        GKScore *scoreReport = [[GKScore alloc] initWithLeaderboardIdentifier:[leaderboard[0] identifier]];
        scoreReport.value = totalScore;
        scoreReport.context = 0;
        
        
        NSArray *scoresArray = @[scoreReport];
        [GKScore reportScores:scoresArray withCompletionHandler:^(NSError *error) {
            
            if(!(error)){
                
                NSLog(@"Submit success");
                
            }else{
                
                NSLog(@"Error %@", error);
            }
            
        } ];
        
    }];
    
}











// Game Over section //
-(void)gameOver{

    [startTimer invalidate];
    
    [newGuySprite removeFromParentAndCleanup:TRUE];
    
    // setting the background color to be a transparent black
    CCNodeColor *newbackgroundColor = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6f]];
    [newbackgroundColor setZOrder:4];
    [self addChild:newbackgroundColor];
    
    
    [self displayGameOver];

}


-(void)displayGameOver{
    
    CCLayoutBox *gameOverLayoutBox = [[CCLayoutBox alloc] init];
    gameOverLayoutBox.anchorPoint = ccp(0.5f, 0.5f);
    gameOverLayoutBox.position = ccp(xBounds / 2, yBounds / 2);
    [gameOverLayoutBox setZOrder:4];
    
    
    CCSprite *gameOverBoxSprite = [CCSprite spriteWithImageNamed:@"menu_box_pause.png"];
    gameOverBoxSprite.anchorPoint = ccp(0.5f, 0.5f);
    gameOverBoxSprite.position = ccp(xBounds / 2, yBounds / 2);
    [gameOverBoxSprite setZOrder:4];
    [gameOverLayoutBox addChild:gameOverBoxSprite];
    
    gameOverLabel = [CCLabelTTF labelWithString:@"Game Over!" fontName:@"Papyrus" fontSize:30.0f];
    gameOverLabel.anchorPoint = ccp(0.5f, 0.5f);
    gameOverLabel.position = ccp((gameOverBoxSprite.contentSize.width / 2), gameOverBoxSprite.position.y + 50.0f);
    [gameOverBoxSprite addChild:gameOverLabel];
    
    
    CCButton *playAgainButton = [CCButton buttonWithTitle:@"Play Again!" fontName:@"Papyrus" fontSize:20.0f];
    playAgainButton.anchorPoint = ccp(0.5f, 0.5f);
    playAgainButton.position = ccp((gameOverBoxSprite.contentSize.width / 2), gameOverBoxSprite.position.y - 20.0f);
    playAgainButton.name = @"Play_Again";
    [playAgainButton setTarget:self selector:@selector(gameOverMenuButtons:)];
    [gameOverBoxSprite addChild:playAgainButton];
    
    
    CCButton *mainMenuButton = [CCButton buttonWithTitle:@"Main Menu!" fontName:@"Papyrus" fontSize:20.0f];
    mainMenuButton.anchorPoint = ccp(0.5f, 0.5f);
    mainMenuButton.position = ccp((gameOverBoxSprite.contentSize.width / 2), gameOverBoxSprite.position.y - 60.0f);
    mainMenuButton.name = @"Main_Menu";
    [mainMenuButton setTarget:self selector:@selector(gameOverMenuButtons:)];
    [gameOverBoxSprite addChild:mainMenuButton];
    
    [self addChild:gameOverLayoutBox];
    
    pauseButton.enabled = NO;
    
    
    
}



-(void)gameOverMenuButtons:(id)sender{
    
    CCButton *button = (CCButton *)sender;
    if([button.name isEqualToString:@"Play_Again"]){
        
        [[CCDirector sharedDirector] replaceScene:[IntroScene sceneCameFromTutorial:NO]
                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
    }else if([button.name isEqualToString:@"Main_Menu"]){
        
        [[CCDirector sharedDirector] replaceScene:[MainMenuScene scene]
                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
    }
}











// --------------- > tutorial section < ----------------- //
// this will be a custom version of the game scene that turns off all aspects of the game //
// but shows the user what do do through an animated tutorial //
-(void)cameFromTutorial{
    
    [startTimer invalidate];
    
    
    backgroundColorOnPause = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6]];
    backgroundColorOnPause.zOrder = 4;
    [self addChild:backgroundColorOnPause];
    
    // stop tutorial button //
    CCSpriteFrame *stopTutorialButtonSprite = [CCSpriteFrame frameWithImageNamed:@"tutorial_done_box.png"];
    tutorialDoneButton = [CCButton buttonWithTitle:@"Done with Tutorial!" spriteFrame:stopTutorialButtonSprite];
    tutorialDoneButton.anchorPoint = ccp(0.5f, 0.5f);
    tutorialDoneButton.position = ccp(xBounds / 2, 40.0f);
    tutorialDoneButton.name = @"done_with_tutorial";
    [tutorialDoneButton setTarget:self selector:@selector(nextInstruction:)];
    
    // making the tutorial done button more visible than anything else //
    [self addChild:tutorialDoneButton z:5];
    [newGuySprite setZOrder:5];
    
    
    
    // movement arrow
    CCSpriteFrame *arrowFrameSprite = [CCSpriteFrame frameWithImageNamed:@"Guy_move_Arrow.png"];
    arrowButton = [CCButton buttonWithTitle:@"Move this way!" spriteFrame:arrowFrameSprite];
    arrowButton.position = ccp(newGuySprite.position.x - 100.0f, newGuySprite.position.y);
    arrowButton.name = @"first_Next";
    arrowButton.anchorPoint = ccp(0.5f, 0.5f);
    [arrowButton setTarget:self selector:@selector(nextInstruction:)];
    
    // making the first arrow more visible than anything else //
    [self addChild:arrowButton z:5];
    
    
    secondArrowButton = [CCButton buttonWithTitle:@"Watch for Enemy!" spriteFrame:arrowFrameSprite];
    secondArrowButton.position = ccp(newEnemySprite.position.x + 100, 200.0f);
    secondArrowButton.anchorPoint = ccp(0.5f, 0.5f);
    secondArrowButton.name = @"second_Next";
    secondArrowButton.visible = false;
    [secondArrowButton setTarget:self selector:@selector(nextInstruction:)];
    [self addChild:secondArrowButton z:2];
    
    
    thirdArrowButton = [CCButton buttonWithTitle:@"Get to the Goal!" spriteFrame:arrowFrameSprite];
    thirdArrowButton.position = ccp(newEndBox.position.x + 80.0f, newEndBox.position.y + 80.0f);
    thirdArrowButton.anchorPoint = ccp(0.5f, 0.5f);
    thirdArrowButton.name = @"third_Next";
    thirdArrowButton.rotation = 320.0f;
    thirdArrowButton.visible = false;
    [thirdArrowButton setTarget:self selector:@selector(nextInstruction:)];
    [self addChild:thirdArrowButton z:2];
    
    
    
    forthArrowButton = [CCButton buttonWithTitle:@"Hearts!" spriteFrame:arrowFrameSprite];
    forthArrowButton.position = ccp(220.0f, yBounds - 32);
    forthArrowButton.anchorPoint = ccp(0.5f, 0.5f);
    forthArrowButton.name = @"forth_Next";
    forthArrowButton.visible = false;
    [forthArrowButton setTarget:self selector:@selector(nextInstruction:)];
    
    
    
    // instruction label //
    heartInstruction = [CCLabelTTF labelWithString:@" Hit an enemy and your hearts go down.\nWhen you have zero hearts, the game is over!\n \n  Hearts are worth 500pts a piece.\nFor every second that goes by, your total\nscore is subtracted by 10 pts." fontName:@"Chalkduster" fontSize:12.0f];
    heartInstruction.position = ccp(forthArrowButton.contentSize.width / 2, forthArrowButton.contentSize.height - 100.0f);
    heartInstruction.anchorPoint = ccp(0.5f, 0.5f);
    heartInstruction.name = @"heart_instruction";
    heartInstruction.visible = false;

    [forthArrowButton addChild:heartInstruction];
    
    [self addChild:forthArrowButton z:2];

    
}



// what to do when a button is pressed //
// highlighting certain elements //
-(void)nextInstruction:(id)sender{
    
    CCButton *button = (CCButton *)sender;
    if (([button.name isEqualToString:@"first_Next"])) {
        
        arrowButton.visible = false;
        secondArrowButton.visible = true;
        
        [secondArrowButton setZOrder:2];
        [newGuySprite setZOrder:2];
        
        [secondArrowButton setZOrder:5];
        [newEnemySprite setZOrder:5];
        
        
    }else if([button.name isEqualToString:@"second_Next"]){
        
        secondArrowButton.visible = false;
        thirdArrowButton.visible = true;
        
        [secondArrowButton setZOrder:2];
        [newEnemySprite setZOrder:2];
        
        [thirdArrowButton setZOrder:5];
        [newEndBox setZOrder:5];
        
        
    }else if([button.name isEqualToString:@"third_Next"]){
        
        NSLog(@"in here");
        
        thirdArrowButton.visible = false;
        forthArrowButton.visible = true;
        heartInstruction.visible = true;
        
        [thirdArrowButton setZOrder:2];
        [newEndBox setZOrder:2];
        
        [forthArrowButton setZOrder:5];
        [newHealthHeart setZOrder:5];
        
        
    }else if([button.name isEqualToString:@"forth_Next"]){
        
        arrowButton.visible = true;
        forthArrowButton.visible = false;
        heartInstruction.visible = false;
        
        [arrowButton setZOrder:5];
        [newGuySprite setZOrder:5];
        [newHealthHeart setZOrder:2];
        
        
    // done with the tutorial //
    }else if([button.name isEqualToString:@"done_with_tutorial"]){
        
        [[CCDirector sharedDirector] replaceScene:[MainMenuScene scene]
                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
    }
}






@end
