//
//  MoveManager.h
//  kickboxing app
//
//  Created by Bader on 5/19/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Move.h"
#import "CategoryItem.h"

@interface MoveManager : NSObject
-(id)init;
-(NSMutableArray *)generate: (int) size;
@property NSMutableArray * moveList;
@property MoveDistance playerDistance;

@end
