//
//  HeaderCell.m
//  kickboxing app
//
//  Created by Bader on 6/30/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import "HeaderCell.h"
#import "../Objects/Move.h"
#import "CellMenuItem.h"
#import "MoveCell.h"

@interface HeaderCell ()

@end

@implementation HeaderCell

-(id)initWithCell: (NSString *) title : (UITableViewCell *) cell : (NSMutableArray *) moveCellArray {
    self = (HeaderCell *) cell;
    if(self) {
        self.titleLabel.text = title;
        self.isOpen = false;
        [self.arrowButton setImage: [UIImage imageNamed:@"arrowright"] forState:UIControlStateNormal];
        self.moveCellArray = moveCellArray;
        [self updateActiveNumber];
    }
    return self;
}

- (IBAction)arrowPressed:(UIButton *)sender {
    //nothin
}

-(void) updateActiveNumber {
    int total = 0;
    for(int i = 0; i < self.moveCellArray.count; i++) {
        if([[(MoveCell *)[(CellMenuItem *) self.moveCellArray[i] cell] move] isActive])
            total++;
    }
    
    //update label
    self.activeCountLabel.text = [NSString stringWithFormat:@"%d/%lu Active", total, (unsigned long)self.moveCellArray.count];
    [self updateCheckBoxImg:total];
}

-(void) updateCheckBoxImg: (int) count {
    if(count == 0) {
        [self.checkBoxImg setImage: [UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    } else {
        [self.checkBoxImg setImage: [UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
    }
}

-(void) checkBoxPressedAction {
    int total = 0;
    for(int i = 0; i < self.moveCellArray.count; i++) {
        if( [[(MoveCell *) [(CellMenuItem *) self.moveCellArray[i] cell] move] isActive] )
            total++;
    }
    if(total > 0) { //disable all
        for(int i = 0; i < self.moveCellArray.count; i++) {
            [(MoveCell *)[(CellMenuItem *) self.moveCellArray[i] cell] makeActiveFalse];
        }
    } else { //enable all
       for(int i = 0; i < self.moveCellArray.count; i++) {
           [(MoveCell *)[(CellMenuItem *) self.moveCellArray[i] cell] makeActiveTrue];
       }
    }
    [self updateActiveNumber];
}

- (void) layoutSubviews {
    [super layoutSubviews];

//    CGRect newFrame = UIEdgeInsetsInsetRect(self.layer.frame, UIEdgeInsetsMake(3, 0, 3, 0));
//    self.layer.frame = newFrame;
}


@end
