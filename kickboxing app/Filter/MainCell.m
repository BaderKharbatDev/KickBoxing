//
//  HeaderCell.m
//  kickboxing app
//
//  Created by Bader on 6/30/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import "HeaderCell.h"
#import "MainCell.h"

@interface MainCell ()

@end

@implementation MainCell

-(id)initWithCell: (Move *) move : (UITableViewCell *) cell {
    self = (MainCell *) cell;
    if(self) {
        self.title.text = move.name;
        [self.image setImage: [UIImage imageNamed:@"punchplaceholder"]];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];

    CGRect newFrame = UIEdgeInsetsInsetRect(self.layer.frame, UIEdgeInsetsMake(4, 0, 4, 0));
    self.layer.frame = newFrame;
}

@end
