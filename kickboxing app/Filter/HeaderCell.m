//
//  HeaderCell.m
//  kickboxing app
//
//  Created by Bader on 6/30/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import "HeaderCell.h"

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
    }
    return self;
}

- (IBAction)arrowPressed:(UIButton *)sender {
    _isOpen = !_isOpen;
    if(_isOpen)
        [self.arrowButton setImage:[UIImage imageNamed:@"arrowdown"] forState:UIControlStateNormal];
    else
        [self.arrowButton setImage:[UIImage imageNamed:@"arrowright"] forState:UIControlStateNormal];
}



@end
