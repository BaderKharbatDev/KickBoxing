//
//  CellMenuItem.m
//  kickboxing app
//
//  Created by Bader on 7/2/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import "CellMenuItem.h"

@interface CellMenuItem()

@end

@implementation CellMenuItem

-(id)init: (BOOL) isHeader : (UITableViewCell *) cell {
    self = [super init];
    if(self) {
        self.isHeader = isHeader;
        self.cell = cell;
    }
    return self;
}


@end
