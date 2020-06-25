//
//  CategoryItem.h
//  kickboxing app
//
//  Created by Bader on 6/24/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryItem : NSObject
-(id)init: (int) category : (int) weight;
@property NSInteger weight; //1, 2, or 3
@property NSNumber* category; //the bitmask category
@end
