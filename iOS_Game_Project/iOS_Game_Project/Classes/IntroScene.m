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

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}



- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    

    // enabling audio for effects //
    playSound = [OALSimpleAudio sharedInstance];
    
    
    // getting the x and y coords of the screen size //
    xBounds = self.contentSize.width;
    yBounds = self.contentSize.height;
    
    // setting the movement speed of the guy //
    speed = 200;
    
    // setting the initial score which is 5 //
    score = 5;
    
    
    
    
    // background stuff //
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.1 green:0.4 blue:0.5 alpha:1.0]];
    [background setZOrder:0];
    
    //   adding the background color to the scene   //
    [self addChild:background];
    
    
    
    
    newGuySprite = [Guy_Sprite_Object createGuySpriteWithLocation:ccp(xBounds - 64, yBounds / 2)];
    [newGuySprite setZOrder:1];
    
    
    // setting the starting point as an initial reference //
    startPoint = newGuySprite.position;
    
    touchPoint = newGuySprite.position;
    
    NSLog(@"start point for guy is %@", NSStringFromCGPoint(touchPoint));

    //   adding the guy to the scene   //
    [self addChild:newGuySprite];
    
    [self creationOfBlocks];
    
    [self creationOfEnemy];
    
    [self createEndBox];
    
	return self;
}



-(void)onEnter{
    [super onEnter];
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
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
        
        Block_Wall *newBlockWallLayout = [Block_Wall createWallAtPosition:ccp(i * 64, 32.0f)];
        newBlockWallLayout.name = @"Lower";
        
        [self addChild:newBlockWallLayout z:1 name:@"Lower"];
    }
    
    
    //   creation of the lower level blocks   //
    for(int j = 1; j < xBounds / 64; j++){
        
        Block_Wall *newBlockWallLayout = [Block_Wall createWallAtPosition:ccp(j * 64, yBounds - 32)];
        newBlockWallLayout.name = @"Upper";
        [newBlockWallLayout setZOrder:1];
        [self addChild:newBlockWallLayout];
    }
    
    
    //   creation of the middle block   //
    Block_Wall *midBlock = [Block_Wall createWallAtPosition:ccp(128.0f, 96.0f)];
        
    midBlock.name = @"Middle";
    [midBlock setZOrder:1];
    [self addChild:midBlock];

}








-(void)update:(CCTime)delta{

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
    
    
    [self collisionForWall];

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
        
        [self goalPopup:@"Gooaaaal!"];
    }
}






-(void)collisionForEnemy{
    
    //   basically If the user touches the enemy, I need to reset their position   //
    if(CGRectIntersectsRect([newGuySprite getBoundingBox], [newEnemySprite getBoundingBox])){
        
        //   stops the guy from continuing to move after hitting   //
        [newGuySprite stopAllActions];
        
        [playSound playBg:@"sea_audio.mp3"];
        
        score = score - 1;
        
        NSLog(@"Score is %i", score);
        
        // game over //
        if(score < 1){
            
            [self gameOver];
        }
        
        touchPoint = ccp(xBounds - 64, yBounds / 2);
        
        //   resets the position of the guy   //
        newGuySprite.position = touchPoint;
        
        // changes the color when hit to denote visually... that hes been hit //
        [newGuySprite changeColor];
        
        
        newGuySprite.color = [CCColor redColor];
        
        [self goalPopup:@"Ouch!!!!"];
    }
    
}




-(void)gameOver{
    
    NSLog(@"Game Over!");
    
    
}






//   collision detection for all wall types   //
-(void)collisionForWall{
    
    //   looking for the block wall   //
    for(Block_Wall *blocks in self.children){
        
        //   going through all my block classes and getting their locations   //
        if([blocks isKindOfClass:[Block_Wall class]]){
            
            //   check for collision   //
            if(CGRectIntersectsRect([blocks getBoundingBox], [newGuySprite getBoundingBox])){
                
                if([blocks.name isEqualToString:@"Upper"]){
                    
                    NSLog(@"upper");
                    newGuySprite.position = ccp(newGuySprite.position.x, blocks.position.y - 64);
                    [newGuySprite stopAllActions];
                    NSLog(@"Collision at %@", NSStringFromCGPoint(newGuySprite.position));
                    
                }else if([blocks.name isEqualToString:@"Lower"]){
                    
                    NSLog(@"Lower");
                    //   repositioning my guy   //
                    newGuySprite.position = ccp(newGuySprite.position.x , blocks.position.y + 64);
                    [newGuySprite stopAllActions];
                    NSLog(@"Collision at %@", NSStringFromCGPoint(newGuySprite.position));
                    
                
                }else if([blocks.name isEqualToString:@"Middle"]){
                    
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
                    else if((positiveYForGuy > negativeYForBlock) && ((negativeXForGuy < positiveYForBlock) && (positiveXForGuy > negativeXForBlock)) && (!(positiveYForGuy > blocks.position.y))){
                        
                        
                        newGuySprite.position = ccp(newGuySprite.position.x, blocks.position.y - 64);
                        [newGuySprite stopAllActions];
                        
                        
                    }
                    
                    
                    else if((negativeYForGuy < positiveYForBlock) && ((negativeXForGuy < positiveXForBlock) && (positiveXForGuy > negativeXForBlock)) && (!(negativeYForGuy < blocks.position.y))){
                        
                        
                        newGuySprite.position = ccp(newGuySprite.position.x, blocks.position.y + 64);
                        
                        
                    }
                }
            }
        }
    }
}



// creating a pop up message that takes in a string //
-(void)goalPopup:(NSString *)passedInString{
    
    
    //   initializing a goalbox   //
    CCLayoutBox *goalBox = [[CCLayoutBox alloc] init];
    
    //   the ok button   //
    CCButton *okButton = [CCButton buttonWithTitle:@"Ok!"];
    okButton.block = ^(id sender){
        
        //   dismissing the box   //
        [goalBox removeFromParentAndCleanup:true];
        
    };
    
    //   setting up a label   //
    CCLabelTTF *label = [CCLabelTTF labelWithString:passedInString fontName:@"Chalkduster" fontSize:20.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.5f);
    
    
    //   setting parameters for the goal box   //
    goalBox.direction = CCLayoutBoxDirectionVertical;
    goalBox.spacing = 20.0f;
    goalBox.color = [CCColor greenColor];
    
    goalBox.position = ccp(xBounds / 2, yBounds / 2);
    goalBox.cascadeColorEnabled = YES;
    goalBox.cascadeOpacityEnabled = YES;
    
    [goalBox addChild:okButton];
    [goalBox addChild:label];
    
    [self addChild:goalBox];
    
}









@end
