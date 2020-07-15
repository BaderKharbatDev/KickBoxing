//
//  HeaderCell.h
//  kickboxing app
//
//  Created by Bader on 6/30/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#ifndef HeaderCell_h
#define HeaderCell_h


#endif /* HeaderCell_h */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "../Objects/Move.h"

@interface MainCell : UITableViewCell
-(id)initWithCell: (Move *) move : (UITableViewCell *) cell : (int) count;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;

@end
