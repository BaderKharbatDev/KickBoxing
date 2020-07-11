//
//  MoveManager.m
//  kickboxing app
//
//  Created by Bader on 5/19/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import "MoveManager.h"
#import "Move.h"
#include <stdlib.h>

@implementation MoveManager

-(id)init {
    self = [super init];
    if(self){
        self.moveList = [[NSMutableArray alloc] init];
        //read all moves into moveList
        [self.moveList addObject: [[Move alloc] initWithParams:@"Knee" : @"knee" : Kick : Easy : Close : true :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 5], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement | Far :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Teep" :  @"teep" :Kick : Easy : Close : true :
                                   @[[[CategoryItem alloc] init: Kick : 3],[[CategoryItem alloc] init: Punch : 5], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Front Kick" :  @"front" : Kick : Easy : Far : true :
                                   @[[[CategoryItem alloc] init: Kick : 3],[[CategoryItem alloc] init: Punch : 5], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Round Kick" :  @"round" : Kick : Easy : Far : true :
                                   @[[[CategoryItem alloc] init: Kick : 3],[[CategoryItem alloc] init: Punch : 5], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Side Kick" :  @"sidekick" : Kick :Normal : Far : false :
                                   @[[[CategoryItem alloc] init: Kick | Close : 3],[[CategoryItem alloc] init: Punch : 5], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Turning side kick" :  @"sidekick" : Kick : Hard : Far : false :
                                   @[[[CategoryItem alloc] init: Kick : 2],[[CategoryItem alloc] init: Punch : 5], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Jab" :  @"jab" : Punch : Easy : Close : true :
                                   @[[[CategoryItem alloc] init: Kick | Close : 4],[[CategoryItem alloc] init: Punch : 5], [[CategoryItem alloc] init: HeadMovement : 3], [[CategoryItem alloc] init: FootMovement | Close :3]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Cross" :  @"cross" : Punch : Easy : Close : true :
                                   @[[[CategoryItem alloc] init: Kick | Close : 4],[[CategoryItem alloc] init: Punch : 5], [[CategoryItem alloc] init: HeadMovement : 3], [[CategoryItem alloc] init: FootMovement | Close :3]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Lead Hook" :  @"lead hook" : Punch : Normal : Close : true :
                                   @[[[CategoryItem alloc] init: Kick | Close : 4],[[CategoryItem alloc] init: Punch : 5], [[CategoryItem alloc] init: HeadMovement : 3], [[CategoryItem alloc] init: FootMovement | Close :3]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Rear Hook" :  @"rear hook" : Punch : Normal : Close : true :
                                   @[[[CategoryItem alloc] init: Kick | Close : 4],[[CategoryItem alloc] init: Punch : 5], [[CategoryItem alloc] init: HeadMovement : 3], [[CategoryItem alloc] init: FootMovement | Close :3]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Lead Uppercut" :  @"lead upper" : Punch : Normal : Close : false :
                                   @[[[CategoryItem alloc] init: Kick | Close : 3],[[CategoryItem alloc] init: Punch : 3], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement | Close :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Rear Uppercut" :  @"rearuppercut" : Punch : Normal : Close : false :
                                   @[[[CategoryItem alloc] init: Kick | Close : 3],[[CategoryItem alloc] init: Punch : 3], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement | Close :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Slip" :  @"slip" : HeadMovement : Easy : Close : false :
                                   @[[[CategoryItem alloc] init: Kick | Close : 3],[[CategoryItem alloc] init: Punch : 5], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Roll" :  @"roll" : HeadMovement : Easy : Close : false :
                                   @[[[CategoryItem alloc] init: Kick | Close : 3],[[CategoryItem alloc] init: Punch : 5], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Lean Back" :  @"lean" : HeadMovement : Easy : Close : false :
                                   @[[[CategoryItem alloc] init: Kick | Close : 3],[[CategoryItem alloc] init: Punch : 5], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Slide in" :  @"move forward" : FootMovement : Easy : Far : false :
                                   @[[[CategoryItem alloc] init: Kick | Close : 3],[[CategoryItem alloc] init: Punch : 5], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Slide out" :  @"move back" : FootMovement : Easy : Close : false :
                                   @[[[CategoryItem alloc] init: Kick | Far : 3],[[CategoryItem alloc] init: Punch : 2], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Slide left" :  @"move left" : FootMovement : Easy : Close | Far : false :
                                   @[[[CategoryItem alloc] init: Kick : 3],[[CategoryItem alloc] init: Punch : 5], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Slide right" :  @"move right" : FootMovement : Easy : Close | Far : false :
                                   @[[[CategoryItem alloc] init: Kick : 3],[[CategoryItem alloc] init: Punch : 5], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
    }
    return self;
}

-(NSMutableArray *)generate: (int) size {
    NSMutableArray *rv = [[NSMutableArray alloc] init];

    NSMutableArray * activeMoveList = [self getActiveMoveHelper];
    if(activeMoveList.count == 0) {
        [NSException raise:@"Move Generating Warning" format:@"No Moves Are Currently Selected"];
    }
    NSUInteger r = arc4random_uniform(activeMoveList.count);
    Move * current = activeMoveList[r];
    [rv addObject:current];
    
    size--;
    for(int i = 0; i < size; i++) {
        current = [self getNextMove: current];
        [rv addObject:current];
    }

    return rv;
}

-(NSMutableArray *) getActiveMoveHelper { //gets the entire list of active available moves
    NSMutableArray * rv = [[NSMutableArray alloc] init];
    Move * currentMove;
    for(int i = 0; i < self.moveList.count; i++) {
        currentMove = (Move *) self.moveList[i];
        if([currentMove isActive]) { //checks if move is active
            [rv addObject:currentMove];
        }
    }
    return rv;
}

-(Move *)getNextMove: (Move *) lastMove { //returns the next move given the previous move
    
    NSMutableArray * availableMoves = [[NSMutableArray alloc] init];
    for(int i = 0; i < [lastMove nextArray].count; i++) {
        NSArray *available = [self getMatchingMovesHelper: [ [(CategoryItem *)[[lastMove nextArray] objectAtIndex:i] category] intValue] ];
        //adds every found move for the bitmask n (weight value) amount of times
        for( Move* move in available) {
            if(move.isActive) {
                if(move == lastMove) { //repeats so check if it can repeat
                    if(move.canRepeat) {  //add it
                        for(int e = 0; e < [(CategoryItem *)[[lastMove nextArray] objectAtIndex:i] weight]; e++) { //adds the move enough times to account for weighting
                            [availableMoves addObject:move];
                        }
                    }
                } else { //non repeating move, just add it
                    for(int e = 0; e < [(CategoryItem *)[[lastMove nextArray] objectAtIndex:i] weight]; e++) { //adds the move enough times to account for weighting
                        [availableMoves addObject:move];
                    }
                }
            }
        }
    }
    NSUInteger r = arc4random_uniform(availableMoves.count);
    return availableMoves[r];
}

-(NSMutableArray *)getMatchingMovesHelper: (int) bitmask { //gets a list of matching moves given a valid bitmask
    NSMutableArray *rv = [[NSMutableArray alloc] init];

    for(int i = 0; i < self.moveList.count; i++) {
        if( ~([(Move *) self.moveList[i] algorithmBitmask] | ~bitmask) == 0) {
            [rv addObject: self.moveList[i]];
        }
    }
    return rv;
}

@end
