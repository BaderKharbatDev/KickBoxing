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
        [self.moveList addObject: [[Move alloc] initWithParams:@"Knee" : Kick : Easy : Close : @[[NSNumber numberWithInt: Kick | Close], [NSNumber numberWithInt: Punch], [NSNumber numberWithInt: HeadMovement], [NSNumber numberWithInt: FootMovement | Close]] ] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Teep" : Kick : Easy : Close : @[[NSNumber numberWithInt: Kick], [NSNumber numberWithInt: Punch], [NSNumber numberWithInt: HeadMovement], [NSNumber numberWithInt: FootMovement | Close]] ] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Front Kick" : Kick : Easy : Close : @[[NSNumber numberWithInt: Kick], [NSNumber numberWithInt: Punch], [NSNumber numberWithInt: HeadMovement], [NSNumber numberWithInt: FootMovement | Close]]] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Round Kick" : Kick : Easy : Close : @[[NSNumber numberWithInt: Kick], [NSNumber numberWithInt: Punch], [NSNumber numberWithInt: HeadMovement], [NSNumber numberWithInt: FootMovement | Close]]] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Side Kick" : Kick :Normal : Far : @[[NSNumber numberWithInt: Kick], [NSNumber numberWithInt: FootMovement], [NSNumber numberWithInt: Punch]]] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Turning side kick" : Kick : Hard : Far : @[[NSNumber numberWithInt: Kick | Easy], [NSNumber numberWithInt: FootMovement], [NSNumber numberWithInt: Punch]]] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Jumping knee" : Kick : Hard : Close : @[[NSNumber numberWithInt: Kick | Close], [NSNumber numberWithInt: Punch], [NSNumber numberWithInt: HeadMovement], [NSNumber numberWithInt: FootMovement | Close]]] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Tornado kick" : Kick : Hard : Far : @[[NSNumber numberWithInt: Kick | Easy], [NSNumber numberWithInt: FootMovement], [NSNumber numberWithInt: Punch]]] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Jumping front kick" : Kick : Hard  : Far : @[[NSNumber numberWithInt: Kick], [NSNumber numberWithInt: Punch], [NSNumber numberWithInt: HeadMovement], [NSNumber numberWithInt: FootMovement | Close]] ] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Jab" : Punch : Easy : Close : @[[NSNumber numberWithInt: Kick | Close], [NSNumber numberWithInt: Punch], [NSNumber numberWithInt: FootMovement | Close], [NSNumber numberWithInt: HeadMovement]] ] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Cross" : Punch : Easy : Close : @[[NSNumber numberWithInt: Kick | Close], [NSNumber numberWithInt: Punch], [NSNumber numberWithInt: FootMovement | Close], [NSNumber numberWithInt: HeadMovement]] ] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Lead Hook" : Punch : Normal : Close : @[[NSNumber numberWithInt: Kick | Close], [NSNumber numberWithInt: Punch], [NSNumber numberWithInt: FootMovement | Close], [NSNumber numberWithInt: HeadMovement]] ] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Rear Hook" : Punch : Normal : Close : @[[NSNumber numberWithInt: Kick | Close], [NSNumber numberWithInt: Punch], [NSNumber numberWithInt: FootMovement | Close], [NSNumber numberWithInt: HeadMovement]] ] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Lead Uppercut" : Punch : Normal : Close : @[[NSNumber numberWithInt: Kick | Close], [NSNumber numberWithInt: Punch], [NSNumber numberWithInt: FootMovement | Close], [NSNumber numberWithInt: HeadMovement]] ] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Rear Uppercut" : Punch : Normal : Close : @[[NSNumber numberWithInt: Kick | Close], [NSNumber numberWithInt: Punch], [NSNumber numberWithInt: FootMovement | Close], [NSNumber numberWithInt: HeadMovement]] ] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Slip" : HeadMovement : Easy : Close : @[[NSNumber numberWithInt: Punch], [NSNumber numberWithInt: FootMovement | Close], [NSNumber numberWithInt: HeadMovement]] ] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Roll" : HeadMovement : Easy : Close : @[[NSNumber numberWithInt: Punch], [NSNumber numberWithInt: FootMovement | Close], [NSNumber numberWithInt: HeadMovement]] ] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Lean Back" : HeadMovement : Easy : Close : @[[NSNumber numberWithInt: Punch], [NSNumber numberWithInt: FootMovement | Close]] ] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Slide in" : FootMovement : Easy : Far : @[[NSNumber numberWithInt: Punch], [NSNumber numberWithInt: Kick | Close], [NSNumber numberWithInt: HeadMovement]] ] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Slide out" : FootMovement : Easy : Close : @[[NSNumber numberWithInt: Kick], [NSNumber numberWithInt: HeadMovement]] ] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Slide left" : FootMovement : Easy : Close | Far : @[[NSNumber numberWithInt: Punch], [NSNumber numberWithInt: Kick | Close], [NSNumber numberWithInt: HeadMovement]] ] ];
        [self.moveList addObject: [[Move alloc] initWithParams:@"Slide right" : FootMovement : Easy : Close | Far : @[[NSNumber numberWithInt: Punch], [NSNumber numberWithInt: Kick | Close], [NSNumber numberWithInt: HeadMovement]] ] ];
    }
    return self;
}

-(NSMutableArray *)generate: (int) size {
    NSMutableArray *rv = [[NSMutableArray alloc] init];
//    NSLog(@"%d", [[[(Move *)self.moveList[0] nextArray] objectAtIndex:0] intValue]);
    NSUInteger r = arc4random_uniform(self.moveList.count);
    Move * current = self.moveList[r];
    [rv addObject:current];
    
    size--;
    for(int i = 0; i < size; i++) {
        current = [self getNextMove: current];
        [rv addObject:current];
    }

    return rv;
}

-(Move *)getNextMove: (Move *) lastMove {
    NSMutableArray * availableMoves = [[NSMutableArray alloc] init];
    for(int i = 0; i < [lastMove nextArray].count; i++) {
        NSArray *available = [self getMatchingMovesHelper: [ [[lastMove nextArray] objectAtIndex:i] intValue] ];
        for( Move* move in available) {
            [availableMoves addObject:move];
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
