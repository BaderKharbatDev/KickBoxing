//
//  CellMenuItem.h
//  kickboxing app
//
//  Created by Bader on 7/2/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#ifndef CellMenuItem_h
#define CellMenuItem_h


#endif /* CellMenuItem_h */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface CellMenuItem : NSObject
-(id)init: (BOOL) isHeader : (UITableViewCell *) cell;
@property BOOL isHeader;
@property UITableViewCell * cell;
@end
