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





// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

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


    // enabling audio for effects //
    playSound = [OALSimpleAudio sharedInstance];
    
    
    // getting the x and y coords of the screen size //
    xBounds = self.contentSize.width;
    yBounds = self.contentSize.height;
    
    
    
    // setting the movement speed of the guy //
    speed = 200;
    
    // setting the initial score which is 5 //
    score = 4;
    
    
    // background stuff //
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.1 green:0.4 blue:0.5 alpha:1.0]];
    [background setZOrder:0];
    
    //   adding the background color to the scene   //
    [self addChild:background];
    
    
    
    // adding pause functionality //
    CCSpriteFrame *pauseSprite = [CCSpriteFrame frameWithImageNamed:@"pause_sprite.png"];
    pauseButton = [CCButton buttonWithTitle:nil spriteFrame:pauseSprite];
    pauseButton.position = ccp(xBounds - 32.0f,  yBounds - 32.0f);
    [pauseButton setTarget:self selector:@selector(onPauseGame)];
    
    [self addChild:pauseButton];
    
    
    // creating the guy //
    newGuySprite = [Guy_Sprite_Object createGuySpriteWithLocation:ccp(xBounds - 64, yBounds / 2)];
    [newGuySprite setZOrder:1];
    
    touchPoint = newGuySprite.position;
    
    [self addChild:newGuySprite];
    [self creationOfBlocks];
    [self creationOfEnemy];
    [self createEndBox];
    [self creationOfHealthHearts];
    
    if(tutorialMode == YES){
        
        [self cameFromTutorial];
    }
    
    
	return self;
}



-(void)onEnter{
    [super onEnter];
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
}










// creating a popup that allows the user to resume or go to main menu //
-(void)onPauseGame{
    
    pauseButton.enabled = NO;
    
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
}







// resuming the game //
-(void)resumeButton{
    
    pauseButton.enabled = YES;
    
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
    










-(void)creationOfHealthHearts{
    
    for(int i = 1; i < 5; i++){
        
        newHealthHeart = [heathHeartSprite createHeathHeartAtLocation:ccp(32 * i, yBounds - 32)];
        [self addChild:newHealthHeart z:2 name:@"Heart"];
    }
}





-(void)creationOfEnemy{
    
    newEnemySprite = [Enemy_Sprite_Object createEnemyWithLocation:ccp(200.0f, yBounds - 96)];
    [newGuySprite setZOrder:1];
    [self addChild:newEnemySprite];
}







-(void)createEndBox{
    
    newEndBox = [EndBox createEndBoxWithLocation:ccp(64.0f, yBounds / 2)];
    [newEndBox setZOrder:1];
    [self addChild:newEndBox];
}






-(void)creationOfBlocks{
    
    //   creation of the upper level blocks   //
    for(int i = 1; i < xBounds / 64; i ++){
        Block_Wall *newBlockWallLayout = [Block_Wall createWallAtPosition:ccp((i * 64), 32.0f)];
        [self addChild:newBlockWallLayout z:1];
    }
    
    
    
    //   creation of the lower level blocks   //
    for(int j = 1; j < xBounds / 64; j++){
        
        Block_Wall *newBlockWallLayout = [Block_Wall createWallAtPosition:ccp(j * 64, yBounds - 32)];
        [self addChild:newBlockWallLayout z:1];
    }
    
    
    //   creation of the middle block   //
    Block_Wall *midBlock = [Block_Wall createWallAtPosition:ccp(128.0f, 96.0f)];
    
    // animate the block //
    [midBlock blockAnimate];
    [self addChild:midBlock z:1];

}








-(void)update:(CCTime)delta{


    if(tutorialMode == false){
        // correct movement using delta time //
        if(newGuySprite.position.x < touchPoint.x){
        
            newGuySprite.position = ccp(newGuySprite.position.x + speed * delta, newGuySprite.position.y);
        
        }
        if(newGuySprite.position.x > touchPoint.x){
        
            newGuySprite.position = ccp(newGuySprite.position.x - speed * delta, newGuySprite.position.y);
        
        }
        if(newGuySprite.position.y < touchPoint.y){
        
            newGuySprite.position = ccp(newGuySprite.position.x, newGuySprite.position.y + speed * delta);
        
        }
        if(newGuySprite.position.y > touchPoint.y){
        
            newGuySprite.position = ccp(newGuySprite.position.x, newGuySprite.position.y - speed * delta);
        
        }
        if((newGuySprite.position.x == touchPoint.x) && (newGuySprite.position.y == touchPoint.y)){
        
            newGuySprite.position = ccp(newGuySprite.position.x, newGuySprite.position.y);
        
        }
        
    // stop movement of guy if in tutorial mode //
    }else{
        
        
        
        
    }
    
    
    [self collisionWithAnyBlock];
    [self collisionForEnemy];
    [self collisionWithEnd];
    
}





//   touch began should be just for updating the touch point and   //
//   nothing more   //
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    touchPoint = [touch locationInNode:self];
}






-(void)collisionWithEnd{
    
    //   if the guy is in the end box boundry   //
    if(CGRectIntersectsRect([newGuySprite getBoundingBox], [newEndBox getBoundingBox])){
        
        //   reposition the guy so as to not keep triggering the collision   //
        newGuySprite.position = ccp(xBounds - 64, yBounds / 2);
        
        [newGuySprite stopAllActions];
        
        [playSound playBg:@"Applause.mp3"];
        
    }
}






-(void)collisionForEnemy{
    
    //   basically If the user touches the enemy, I need to reset their position   //
    if(CGRectIntersectsRect([newGuySprite getBoundingBox], [newEnemySprite getBoundingBox])){
        
        [playSound playBg:@"sea_audio.mp3"];
        
        score = score - 1;

        // removes one heart at a time from the screen //
        [self removeChildByName:@"Heart" cleanup:YES];
        
        touchPoint = ccp(xBounds - 64, yBounds / 2);
        
        //   resets the position of the guy   //
        newGuySprite.position = touchPoint;
        
        //   stops the guy from continuing to move after hitting   //
        [newGuySprite stopAllActions];
        
        // changes the color when hit to denote visually... that hes been hit //
        [newGuySprite changeColor];
        
        // game over //
        if(score < 1){
            
            [self gameOver];
            
        }
    }
    
}




-(void)gameOver{
    
    
    
    // setting the background color to be a transparent black
    CCNodeColor *backgroundColor = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6f]];
    [backgroundColor setZOrder:4];
    [self addChild:backgroundColor];
    
    
    
    
    CCLayoutBox *gameOverLayoutBox = [[CCLayoutBox alloc] init];
    gameOverLayoutBox.anchorPoint = ccp(0.5f, 0.5f);
    gameOverLayoutBox.position = ccp(xBounds / 2, yBounds / 2);
    [gameOverLayoutBox setZOrder:4];
    
    
    CCSprite *gameOverBoxSprite = [CCSprite spriteWithImageNamed:@"menu_box_pause.png"];
    gameOverBoxSprite.anchorPoint = ccp(0.5f, 0.5f);
    gameOverBoxSprite.position = ccp(xBounds / 2, yBounds / 2);
    [gameOverBoxSprite setZOrder:4];
    [gameOverLayoutBox addChild:gameOverBoxSprite];
    
    CCLabelTTF *gameOverLabel = [CCLabelTTF labelWithString:@"Game Over!" fontName:@"Chalkduster" fontSize:30.0f];
    gameOverLabel.anchorPoint = ccp(0.5f, 0.5f);
    gameOverLabel.position = ccp((gameOverBoxSprite.contentSize.width / 2), gameOverBoxSprite.position.y + 50.0f);
    [gameOverBoxSprite addChild:gameOverLabel];
    
    
    CCButton *playAgainButton = [CCButton buttonWithTitle:@"Play Again!" fontName:@"Chalkduster" fontSize:20.0f];
    playAgainButton.anchorPoint = ccp(0.5f, 0.5f);
    playAgainButton.position = ccp((gameOverBoxSprite.contentSize.width / 2), gameOverBoxSprite.position.y - 20.0f);
    playAgainButton.name = @"Play_Again";
    [playAgainButton setTarget:self selector:@selector(gameOverMenuButtons:)];
    [gameOverBoxSprite addChild:playAgainButton];
    
    
    CCButton *mainMenuButton = [CCButton buttonWithTitle:@"Main Menu!" fontName:@"Chalkduster" fontSize:20.0f];
    mainMenuButton.anchorPoint = ccp(0.5f, 0.5f);
    mainMenuButton.position = ccp((gameOverBoxSprite.contentSize.width / 2), gameOverBoxSprite.position.y - 60.0f);
    mainMenuButton.name = @"Main_Menu";
    [mainMenuButton setTarget:self selector:@selector(gameOverMenuButtons:)];
    [gameOverBoxSprite addChild:mainMenuButton];

    [self addChild:gameOverLayoutBox];
    
    pauseButton.enabled = NO;
    
    score = 4;
    
    [self creationOfHealthHearts];
    
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





-(void)collisionWithAnyBlock{
    
    // checking for block objects //
    for(Block_Wall *blocks in self.children){
        
        // checking to see if its the kind of class //
        if([blocks isKindOfClass:[Block_Wall class]]){
            
            // checking for intersection of two bounding boxes //
            if(CGRectIntersectsRect([blocks getBoundingBox], [newGuySprite getBoundingBox])){
            
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
                    
                    newGuySprite.position = ccp(blocks.position.x + 64 , newGuySprite.position.y);
                    [newGuySprite stopAllActions];
                }
                
                //   checking to see if the left side of the free standing block has been touched   //
                //   if so, check the top and bottom edges to makes sure its free before allowing   //
                //   to pass   //
                else if((positiveXForGuy > negativeXForBlock) && ((negativeYForGuy < positiveYForBlock) && (positiveYForGuy > negativeYForBlock)) && (!(positiveXForGuy > blocks.position.x))){
        
                    newGuySprite.position = ccp(blocks.position.x - 64, newGuySprite.position.y);
                    [newGuySprite stopAllActions];
                    
                }
                
                
                //   use the same principals as above for top and bottom collision   //
                else if((positiveYForGuy > negativeYForBlock) && ((negativeXForGuy < positiveXForBlock) && (positiveXForGuy > negativeXForBlock)) && (!(positiveYForGuy > blocks.position.y))){
                    
                    newGuySprite.position = ccp(newGuySprite.position.x, blocks.position.y - 64);
                    [newGuySprite stopAllActions];
                    
                }
                
                
                else if((negativeYForGuy < positiveYForBlock) && ((negativeXForGuy < positiveXForBlock) && (positiveXForGuy > negativeXForBlock)) && (!(negativeYForGuy < blocks.position.y))){
                    
                    newGuySprite.position = ccp(newGuySprite.position.x, blocks.position.y + 64);
                    [newGuySprite stopAllActions];
                    
                }
            }
        }
    }
}











// --------------- > tutorial section < ----------------- //
// this will be a custom version of the game scene that turns off all aspects of the game //
// but shows the user what do do through an animated tutorial //
-(void)cameFromTutorial{
    
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
    
    
    
    forthArrowButton = [CCButton buttonWithTitle:@"Done with Tutorial!" spriteFrame:arrowFrameSprite];
    forthArrowButton.position = ccp(220.0f, yBounds - 32);
    forthArrowButton.anchorPoint = ccp(0.5f, 0.5f);
    forthArrowButton.name = @"forth_Next";
    forthArrowButton.visible = false;
    [forthArrowButton setTarget:self selector:@selector(nextInstruction:)];
    
    // instruction label //
    heartInstruction = [CCLabelTTF labelWithString:@" Hit an enemy and your hearts go down.\nWhen you have zero hearts, the game is over!" fontName:@"Chalkduster" fontSize:10.0f];
    heartInstruction.position = ccp(forthArrowButton.contentSize.width / 2, forthArrowButton.contentSize.height - 80.0f);
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
