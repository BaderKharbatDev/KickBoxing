//
//  Move.m
//  kickboxing app
//
//  Created by Bader on 5/19/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import "Move.h"
#import "CategoryItem.h"

@implementation Move
//auto generated by compiler
-(id)initWithParams:(NSString*) name : (MoveType) type : (MoveDifficulty) difficulty : (MoveDistance) distance : (NSArray *) nextArray {
    self = [super init];
    if(self) {
        self.name = name;
        self.moveType = type;
        self.moveDifficulty = difficulty;
        self.moveDistance = distance;
        self.algorithmBitmask = type | difficulty | distance;
        self.isActive = true;
        self.nextArray = nextArray;
    }
    return self;
}

@end
