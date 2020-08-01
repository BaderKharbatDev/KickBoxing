//
//  Move.h
//  kickboxing app
//
//  Created by Bader on 5/19/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(int, MoveType) {
    Punch = 0x01,
    FootMovement = 0x02,
    HeadMovement = 0x04,
    Kick = 0x08
};

typedef NS_OPTIONS(int, MoveDifficulty) {
    Easy = 0x10,
    Normal = 0x20,
    Hard = 0x40
};

typedef NS_OPTIONS(int, MoveDistance) {
    Close = 0x80,
    Far = 0x100
};

@interface Move : NSObject 
-(id)initWithParams:(NSString*) name : (NSString *) imgStr : (BOOL) active : (MoveType) type : (MoveDifficulty) difficulty : (MoveDistance) distance : (BOOL) canRepeat : (NSString*) sound : (NSArray *) nextArray;
@property NSString *name;
@property NSString * imgStr;
@property NSString * sound;
@property (nonatomic, assign) MoveType moveType;
@property (nonatomic, assign) MoveDifficulty moveDifficulty;
@property (nonatomic, assign) MoveDistance moveDistance;
@property BOOL canRepeat;
@property BOOL isActive;
@property int algorithmBitmask;
@property NSArray* nextArray;
@end
