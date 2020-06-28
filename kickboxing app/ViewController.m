//
//  ViewController.m
//  kickboxing app
//
//  Created by Bader on 5/17/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIStepper *stepper;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property NSMutableArray * moveArray;
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
//    self.moveArray = [NSMutableArray arrayWithArray:@[self.manager.moveList[0]]];
}

- (IBAction)onStepperChange:(UIStepper *)sender {
    self.countLabel.text = [NSString stringWithFormat:@"%1.0f", self.stepper.value];
}

- (IBAction)generateListOfMoves:(UIButton *)sender {
    self.moveArray = [self.manager generate:self.stepper.value];
    [self.table reloadData];
    
    for(int i = 0; i < self.moveArray.count; i++) {
        NSLog(@"%@", [(Move *) self.moveArray[i] name]);
    }
    NSLog(@"------");
}

#pragma mark - UITableView DataSource Methods
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _moveArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString * cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = [(Move *) self.moveArray[indexPath.row] name];
    cell.detailTextLabel.text = @"";
    
    return cell;
}

@end
