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
        [self.moveList addObject: [[Move alloc] initWithParams:@"Knee" : Kick : Easy : Close :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Teep" : Kick : Easy : Close :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Front Kick" : Kick : Easy : Far :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Round Kick" : Kick : Easy : Far :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Side Kick" : Kick :Normal : Far :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Turning side kick" : Kick : Hard : Far :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Jumping knee" : Kick : Hard : Close :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Tornado kick" : Kick : Hard : Far :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Jumping front kick" : Kick : Hard  : Far :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Jab" : Punch : Easy : Close :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Cross" : Punch : Easy : Close :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Lead Hook" : Punch : Normal : Close :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Rear Hook" : Punch : Normal : Close :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Lead Uppercut" : Punch : Normal : Close :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Rear Uppercut" : Punch : Normal : Close :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Slip" : HeadMovement : Easy : Close :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Roll" : HeadMovement : Easy : Close :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Lean Back" : HeadMovement : Easy : Close :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Slide in" : FootMovement : Easy : Far :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Slide out" : FootMovement : Easy : Close :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Slide left" : FootMovement : Easy : Close | Far :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Slide right" : FootMovement : Easy : Close | Far :
                                   @[[[CategoryItem alloc] init: Kick : 1],[[CategoryItem alloc] init: Punch : 1], [[CategoryItem alloc] init: HeadMovement : 1], [[CategoryItem alloc] init: FootMovement :1]] ]];
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

-(NSMutableArray *) getActiveMoveHelper {
    NSMutableArray * rv = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.moveList.count; i++) {
        if([(Move *)self.moveList[i] isActive])
            [rv addObject:self.moveList[i]];
    }
    return rv;
}

-(Move *)getNextMove: (Move *) lastMove {
    
    NSMutableArray * availableMoves = [[NSMutableArray alloc] init];
    for(int i = 0; i < [lastMove nextArray].count; i++) {
        NSArray *available = [self getMatchingMovesHelper: [ [(CategoryItem *)[[lastMove nextArray] objectAtIndex:i] category] intValue] ];
        //adds every found move for the bitmask n (weight value) amount of times
        for( Move* move in available) {
            if(move.isActive) {
                for(int e = 0; e < [(CategoryItem *)[[lastMove nextArray] objectAtIndex:i] weight]; e++) {
                    [availableMoves addObject:move];
                }
            }
        }
    }
    NSUInteger r = arc4random_uniform(availableMoves.count);
    return availableMoves[r];
}

-(NSMutableArray *)getMatchingMovesHelper: (int) bitmask {
    NSMutableArray *rv = [[NSMutableArray alloc] init];

    for(int i = 0; i < self.moveList.count; i++) {
        if( ~([(Move *) self.moveList[i] algorithmBitmask] | ~bitmask) == 0) {
            [rv addObject: self.moveList[i]];
        }
    }
    return rv;
}

@end
