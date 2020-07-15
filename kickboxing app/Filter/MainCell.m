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
@property (strong, nonatomic) IBOutlet UIView *imgBackgroundView;
@end

@implementation MainCell

-(id)initWithCell: (Move *) move : (UITableViewCell *) cell : (int) count{
    self = (MainCell *) cell;
    if(self) {
        self.title.text = move.name;
        [self.image setImage: [UIImage imageNamed:@"punchplaceholder"]];
        self.countLabel.text = [NSString stringWithFormat:@"%d.", count];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];

    CGRect newFrame = UIEdgeInsetsInsetRect(self.layer.frame, UIEdgeInsetsMake(3, 0, 3, 0));
    self.layer.frame = newFrame;
    
    self.imgBackgroundView.layer.shadowOffset = CGSizeMake(0, 1);
    self.imgBackgroundView.layer.shadowRadius = 1;
    self.imgBackgroundView.layer.shadowOpacity = 0.15;
    
//    self.layer.shadowOffset = CGSizeMake(0, 5);
//    self.layer.shadowRadius = 5;
//    self.layer.shadowOpacity = 0.15;
}

@end
