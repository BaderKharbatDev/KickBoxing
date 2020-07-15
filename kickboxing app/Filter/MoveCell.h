//
//  MoveCell.h
//  kickboxing app
//
//  Created by Bader on 7/1/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#ifndef MoveCell_h
#define MoveCell_h


#endif /* MoveCell_h */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "../Objects/Move.h"

@interface MoveCell : UITableViewCell
-(id)initWithCell: (Move *) move : (UITableViewCell *) cell;
-(void)changeActiveStatus;
- (IBAction)checkBoxPressed:(UIButton *)sender;
-(void)makeActiveFalse;
-(void)makeActiveTrue;
@property (strong, nonatomic) IBOutlet UIButton *boxButton;
@property (strong, nonatomic) IBOutlet UILabel * title;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property Move * move;
@end
