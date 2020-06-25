//
//  ViewController.m
//  kickboxing app
//
//  Created by Bader on 5/17/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIStepper *stepper;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property MoveManager * manager;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate* delegateInstance = ( AppDelegate* )[UIApplication sharedApplication].delegate;
    _manager = [delegateInstance manager];
    [self setupUI];
}

-(void)setupUI {
    //setup UI
    self.stepper.maximumValue = 1;
    self.stepper.maximumValue = 10;
    self.stepper.value = 4;
    self.countLabel.text = [NSString stringWithFormat:@"%1.0f", self.stepper.value];
}

- (IBAction)onStepperChange:(UIStepper *)sender {
    self.countLabel.text = [NSString stringWithFormat:@"%1.0f", self.stepper.value];
}

- (IBAction)generateListOfMoves:(UIButton *)sender {
    NSMutableArray * rv = [self.manager generate:self.stepper.value];
    for(int i = 0; i < rv.count; i++) {
        NSLog(@"%@", [(Move *) rv[i] name]);
    }
    NSLog(@"------");
}


@end
