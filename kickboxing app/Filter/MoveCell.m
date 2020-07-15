//
//  MoveCell.m
//  kickboxing app
//
//  Created by Bader on 7/2/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import "MoveCell.h"

@interface MoveCell ()

@end

@implementation MoveCell
-(id)initWithCell: (Move *) move : (UITableViewCell *) cell {
    self = (MoveCell *) cell;
    if(self) {
        self.move = move;
        self.title.text = move.name;
        [self.image setImage: [UIImage imageNamed: self.move.imgStr ]];
        if(move.isActive)
            [self.boxButton setImage: [UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
        else
            [self.boxButton setImage: [UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    }
    return self;
}

- (IBAction)checkBoxPressed:(UIButton *)sender {
    [self changeActiveStatus];
}

-(void)changeActiveStatus {
    self.move.isActive = !self.move.isActive;
    if(self.move.isActive)
        [self.boxButton setImage: [UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
    else
        [self.boxButton setImage: [UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
}

-(void)makeActiveTrue {
    self.move.isActive = true;
    [self.boxButton setImage: [UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
}

-(void)makeActiveFalse {
    self.move.isActive = false;
    [self.boxButton setImage: [UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
}

@end

