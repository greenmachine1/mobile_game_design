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



// -----------------------------------------------------------------------
- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    

    
    
// -----------------------------------------------------------------------
    // **** enabling audio for effects **** //
    playSound = [OALSimpleAudio sharedInstance];
    
    
    
// -----------------------------------------------------------------------
    // **** getting the x and y coords of the screen size **** //
    xBounds = self.contentSize.width;
    yBounds = self.contentSize.height;
    
    startingSpeed = 0;
    endingSpeed = 20;

    
    // **** changing the background color to a light blue **** //
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.1 green:0.4 blue:0.5 alpha:1.0]];
    
    // **** setting the depth order **** //
    [background setZOrder:0];
    
    // **** adding the background color to the scene **** //
    [self addChild:background];
    
    
    
// -----------------------------------------------------------------------
    // **** creation of the guy sprite **** //
    
    touchPoint = ccp(xBounds - 64, yBounds / 2);
    
    newGuySprite = [Guy_Sprite_Object createGuySpriteWithLocation:touchPoint];
    [newGuySprite setZOrder:1];
    
    endPoint = newGuySprite.position;
    
    // **** adding the guy to the scene **** //
    [self addChild:newGuySprite];
    
    
    
    
    
// -----------------------------------------------------------------------
    // **** creation of the blocks ***** //
    [self creationOfBlocks];
    
// -----------------------------------------------------------------------
    // **** creation of enemy **** //
    [self creationOfEnemy];
    
    
// -----------------------------------------------------------------------
    // **** creation of enemy **** //
    [self createEndBox];
    
    
    
    
	return self;
}




// ---------------------------------------------------------------------------------
// **** creation of enemy **** //
-(void)creationOfEnemy{
    
    //newEnemySprite = [Enemy_Sprite_Object createEnemyWithLocation:ccp(200.0f, yBounds - 96)];
    
    //[newGuySprite setZOrder:1];
    
    //[self addChild:newEnemySprite];
}





// ---------------------------------------------------------------------------------
// **** creation of end box **** //
-(void)createEndBox{
    
    //newEndBox = [EndBox createEndBoxWithLocation:ccp(64.0f, yBounds / 2)];
    
    //[newEndBox setZOrder:1];
    
    //[self addChild:newEndBox];
}




// -----------------------------------------------------------------------
// **** creation of the blocks method **** //
-(void)creationOfBlocks{
    
    /*
    // **** creation of the upper level blocks **** //
    for(int i = 1; i < xBounds / 64; i ++){
        
        Block_Wall *newBlockWallLayout = [Block_Wall createWallAtPosition:ccp(i * 64, 32.0f)];
        newBlockWallLayout.name = @"Lower";
        
        //[newBlockWallLayout setZOrder:1];
        [self addChild:newBlockWallLayout z:1 name:@"Lower"];
    }
    
    
    // **** creation of the lower level blocks **** //
    for(int j = 1; j < xBounds / 64; j++){
        
        Block_Wall *newBlockWallLayout = [Block_Wall createWallAtPosition:ccp(j * 64, yBounds - 32)];
        newBlockWallLayout.name = @"Upper";
        [newBlockWallLayout setZOrder:1];
        [self addChild:newBlockWallLayout];
    }
    
     */
    // **** creation of the middle block **** //
    Block_Wall *midBlock = [Block_Wall createWallAtPosition:ccp(128.0f, 128.0f)];
        
    midBlock.name = @"Middle";
    [midBlock setZOrder:1];
    [self addChild:midBlock];

}







// -----------------------------------------------------------------------
-(void)onEnter{
    [super onEnter];
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
}






// ------------------------------------------------------------------------
// **** update loop **** //
-(void)update:(CCTime)delta{
    
    deltaTime = delta;
    
    // **** collision for wall method **** //
    [self collisionForWall];
    
    // **** collision for enemy method **** //
    [self collisionForEnemy];
    
    // **** collision with the end **** //
    [self collisionWithEnd];
    
    //[self collisionWithWalls];
    
    
}





// -------------------------------------------------------------------------
// **** move the guy to a point on the screen **** //
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    touchPoint = [touch locationInNode:self];
    
    // **** trying out my delta time **** //
    CCActionMoveTo *moveGuy = [CCActionMoveTo actionWithDuration:deltaTime * 20 position:touchPoint];
    
    [newGuySprite runAction:moveGuy];
    
}






// -------------------------------------------------------------------------
// **** collision with the end of the game **** //
-(void)collisionWithEnd{
    
    // **** if the guy is in the end box boundry **** //
    if(CGRectIntersectsRect([newGuySprite getBoundingBox], [newEndBox getBoundingBox])){
        
        // **** reposition the guy so as to not keep triggering the collision **** //
        newGuySprite.position = ccp(xBounds - 64, yBounds / 2);
        
        // **** stopping all the actions on the new guy sprite **** //
        [newGuySprite stopAllActions];
        
        [playSound playBg:@"Applause.mp3"];
        
        [self goalPopup:@"Gooaaaal!"];
    }
}




// ------------------------------------------------------------------------
// **** collision detection for enemy **** //
-(void)collisionForEnemy{
    
    // **** basically If the user touches the enemy, I need to reset their position **** //
    if(CGRectIntersectsRect([newGuySprite getBoundingBox], [newEnemySprite getBoundingBox])){
        
        // **** stops the guy from continuing to move after hitting **** //
        [newGuySprite stopAllActions];
        
        [playSound playBg:@"sea_audio.mp3"];
        
        touchPoint = ccp(xBounds - 64, yBounds / 2);
        
        // **** resets the position of the guy **** //
        newGuySprite.position = touchPoint;
        
        [self goalPopup:@"Ouch!!!!"];
    }
    
}







// -------------------------------------------------------------------------
// **** collision detection for wall types **** //
-(void)collisionForWall{
    
    // **** looking for the block wall **** //
    for(Block_Wall *blocks in self.children){
        
        // **** going through all my block classes and getting their locations **** //
        if([blocks isKindOfClass:[Block_Wall class]]){
            
            // **** check for collision **** //
            if(CGRectIntersectsRect([blocks getBoundingBox], [newGuySprite getBoundingBox])){
                
                if([blocks.name isEqualToString:@"Upper"]){
                    
                    NSLog(@"upper");
                    newGuySprite.position = ccp(newGuySprite.position.x, blocks.position.y - 64);
                    [newGuySprite stopAllActions];
                    NSLog(@"Collision at %@", NSStringFromCGPoint(newGuySprite.position));
                    
                    //[playSound playBg:@"Hammer.mp3"];
                    
                }else if([blocks.name isEqualToString:@"Lower"]){
                    
                    NSLog(@"Lower");
                    // **** repositioning my guy **** //
                    newGuySprite.position = ccp(newGuySprite.position.x , blocks.position.y + 64);
                    [newGuySprite stopAllActions];
                    NSLog(@"Collision at %@", NSStringFromCGPoint(newGuySprite.position));
                    
                    //[playSound playBg:@"Hammer.mp3"];
                    
                // **** for any block that is in the middle **** //
                }else if([blocks.name isEqualToString:@"Middle"]){
                    
                    float positiveXForGuy = newGuySprite.position.x + [newGuySprite getBoundingBox].size.width / 2;
                    float negativeXForGuy = newGuySprite.position.x - [newGuySprite getBoundingBox].size.width / 2;
                    float positiveYForGuy = newGuySprite.position.y + [newGuySprite getBoundingBox].size.height / 2;
                    float negativeYForGuy = newGuySprite.position.y - [newGuySprite getBoundingBox].size.height / 2;
                    
                    float positiveXForBlock = blocks.position.x + [blocks getBoundingBox].size.width / 2;
                    float negativeXForBlock = blocks.position.x - [blocks getBoundingBox].size.width / 2;
                    float positiveYForBlock = blocks.position.y + [blocks getBoundingBox].size.height / 2;
                    float negativeYForBlock = blocks.position.y - [blocks getBoundingBox].size.height / 2;
                    
                    
                    // **** checking to see if the right side of the free standing block has been touched **** //
                    // **** if so, check the top and bottom edges to make sure its free before allowing **** //
                    // **** to pass **** //
                    if((negativeXForGuy < positiveXForBlock) && ((negativeYForGuy < positiveYForBlock) && (positiveYForGuy > negativeYForBlock)) && (!(negativeXForGuy < blocks.position.x))){
                        
                        
                        newGuySprite.position = ccp(blocks.position.x + 64 , newGuySprite.position.y);
                        [newGuySprite stopAllActions];
                        
                        
                    }
                    
                    // **** checking to see if the left side of the free standing block has been touched **** //
                    // **** if so, check the top and bottom edges to makes sure its free before allowing **** //
                    // **** to pass **** //
                    else if((positiveXForGuy > negativeXForBlock) && ((negativeYForGuy < positiveYForBlock) && (positiveYForGuy > negativeYForBlock)) && (!(positiveXForGuy > blocks.position.x))){
                        
                        
                        newGuySprite.position = ccp(blocks.position.x - 64, newGuySprite.position.y);
                        [newGuySprite stopAllActions];
                        
                        
                    }
                    
                    
                    // **** checking to see if the positive y intercepts with the negative y for the block **** //
                    else if((positiveYForGuy > negativeYForBlock) && ((negativeXForGuy < positiveYForBlock) && (positiveXForGuy > negativeXForBlock)) && (!(positiveYForGuy > blocks.position.y))){
                        
                        
                        newGuySprite.position = ccp(newGuySprite.position.x, blocks.position.y - 64);
                        [newGuySprite stopAllActions];
                        
                        
                    }
                    
                    // **** checking to see if the negative y intercepts with the positive y for the block **** //
                    else if((negativeYForGuy < positiveYForBlock) && ((negativeXForGuy < positiveXForBlock) && (positiveXForGuy > negativeXForBlock)) && (!(negativeYForGuy < blocks.position.y))){
                        
                        
                        newGuySprite.position = ccp(newGuySprite.position.x, blocks.position.y + 64);
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                        
                        
                
                        
                        
                    
                    
                    
                    
                    
                    
            
                    

                }
            }
        }
    }
}





// -------------------------------------------------------------------------
// **** popup **** //
-(void)goalPopup:(NSString *)passedInString{
    
    // **** initializing a goalbox **** //
    CCLayoutBox *goalBox = [[CCLayoutBox alloc] init];
    
    // **** the ok button **** //
    CCButton *okButton = [CCButton buttonWithTitle:@"Ok!"];
    okButton.block = ^(id sender){
        
        // **** dismissing the box **** //
        [goalBox removeFromParentAndCleanup:true];
        
    };
    
    // **** setting up a label **** //
    CCLabelTTF *label = [CCLabelTTF labelWithString:passedInString fontName:@"Chalkduster" fontSize:20.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.5f);
    
    
    // **** setting parameters for the goal box **** //
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
