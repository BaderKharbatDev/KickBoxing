//
//  CategoryItem.m
//  kickboxing app
//
//  Created by Bader on 6/24/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import "CategoryItem.h"

@implementation CategoryItem

-(id)init: (int) category : (int) weight {
    self = [super init];
    if(self) {
        self.category = [NSNumber numberWithInt:category];
        self.weight = weight;
    }
    return self;
}

@end
