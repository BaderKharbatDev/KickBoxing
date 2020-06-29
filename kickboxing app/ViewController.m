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
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UIView *popupWindow;
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
    self.stepper.minimumValue = 1;
    self.stepper.maximumValue = 10;
    self.stepper.value = 4;
    self.countLabel.text = [NSString stringWithFormat:@"%1.0f", self.stepper.value];
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

- (IBAction)modalPopupButton:(UIButton *)sender {
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView * blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.alpha = 0.5f;
    blurEffectView.frame = self.view.frame;
    [self.view addSubview:blurEffectView];
    
    [self.view addSubview: _popupWindow];
    _popupWindow.center = self.view.center;
}

- (IBAction)dismissPopupWindow:(UIButton *)sender {
    [self.popupWindow removeFromSuperview];
    [self.view.subviews[self.view.subviews.count - 1] removeFromSuperview];
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
